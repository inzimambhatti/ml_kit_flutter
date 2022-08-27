

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui'as ui;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import '../views/components/labeling_painter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController {
  late ImageLabeler _imageLabeler;
  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  get getText {
    return _text;
  }
  get getCustomPaint {
    return _customPaint;
  }

  //////////////////////////////////////////////
  //TODO: Implement HomeController
  var selectedImagePath=''.obs;
  var extractedBarcode=''.obs;
  RxBool isLoading = false.obs;
  XFile ?iimageFile;
  List<DetectedObject> ?objectss;
  ui.Image ?iimage;
  void _initializeLabeler() async {
    // uncomment next line if you want to use the default model
    _imageLabeler = ImageLabeler(options: ImageLabelerOptions());

    // uncomment next lines if you want to use a local model
    // make sure to add tflite model to assets/ml
    //final path = 'assets/ml/lite-model_aiy_vision_classifier_birds_V1_3.tflite';
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

      _text = '';

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

      update();

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
  /////////////////////////////////////////////////////////////

  Future <void>getImageAndDetectObjects() async {
    final  imageFile = (await ImagePicker().pickImage(source: ImageSource.gallery)) ;
//var imageFilee=imageFile.toFile();
    isLoading.value = true;
selectedImagePath.value=imageFile!.path;
    final image = InputImage.fromFilePath(imageFile.path) ;
    var objectDetector=GoogleMlKit.vision.objectDetector(options: ObjectDetectorOptions(mode: DetectionMode.single, classifyObjects: true, multipleObjects: true));
    List<DetectedObject> objects = await objectDetector.processImage(image);
    iimageFile = imageFile;
    objectss = objects;
    _loadImage(imageFile);

    update();

  }

  _loadImage(XFile file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then(
            (value) =>

        iimage = value);
    isLoading.value = false;

    update();
  }


  @override
  void onInit() {
    super.onInit();
    _initializeLabeler();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _canProcess = false;
    _imageLabeler.close();
    super.onClose();
  }
}
