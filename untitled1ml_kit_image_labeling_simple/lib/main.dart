import 'dart:io' as io;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'camera_view.dart';
import 'labeling_painter.dart';

List<CameraDescription> cameras=[];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  ImageLabelView(),
    );
  }
}
class ImageLabelView extends StatefulWidget {
  @override
  _ImageLabelViewState createState() => _ImageLabelViewState();
}

class _ImageLabelViewState extends State<ImageLabelView> {
  late ImageLabeler _imageLabeler;
  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;

  @override
  void initState() {
    super.initState();

    _initializeLabeler();
  }

  @override
  void dispose() {
    _canProcess = false;
    _imageLabeler.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Image Labeler by Bhatti',
      customPaint: _customPaint,
      text: _text,
      onImage: processImage,
    );
  }

  void _initializeLabeler() async {
    // uncomment next line if you want to use the default model
     _imageLabeler = ImageLabeler(options: ImageLabelerOptions());

    // uncomment next lines if you want to use a local model
    // make sure to add tflite model to assets/ml
    // final path = 'assets/ml/lite-model_aiy_vision_classifier_birds_V1_3.tflite';
    //final path = 'assets/ml/object_labeler.tflite';
    //final modelPath = await _getModel(path);
    //final options = LocalLabelerOptions(modelPath: modelPath);
    //_imageLabeler = ImageLabeler(options: options);

    // uncomment next lines if you want to use a remote model
    // make sure to add model to firebase
    // final modelName = 'bird-classifier';
    // final response =
    //     await FirebaseImageLabelerModelManager().downloadModel(modelName);
    // print('Downloaded: $response');
    // final options =
    //     FirebaseLabelerOption(confidenceThreshold: 0.5, modelName: modelName);
    // _imageLabeler = ImageLabeler(options: options);

    _canProcess = true;
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final labels = await _imageLabeler.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = LabelDetectorPainter(labels);
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Labels found: ${labels.length}\n\n';
      for (final label in labels) {
        text += 'Label: ${label.label}, '
            'Confidence: ${label.confidence.toStringAsFixed(2)}\n\n';
      }
      _text = text;
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<String> _getModel(String assetPath) async {
    if (io.Platform.isAndroid) {
      return 'flutter_assets/$assetPath';
    }
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await io.Directory(dirname(path)).create(recursive: true);
    final file = io.File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }
}
