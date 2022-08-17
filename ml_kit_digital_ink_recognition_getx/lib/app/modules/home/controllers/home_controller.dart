import 'package:flutter/material.dart' hide Ink;
import 'package:get/get.dart';

import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';

import '../../../../activity_indicator.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final DigitalInkRecognizerModelManager modelManager =
  DigitalInkRecognizerModelManager();
  final String language = 'en-US';
  late final DigitalInkRecognizer digitalInkRecognizer =
  DigitalInkRecognizer(languageCode: language);
  final Ink ink = Ink();
  List<StrokePoint> points = [];
  String recognizedText = '';
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    digitalInkRecognizer.close();
    super.onClose();
  }
/// mehrods
  void clearPad() {

      ink.strokes.clear();
      points.clear();
      recognizedText = '';
    update();
  }

  Future<void> isModelDownloaded() async {
    Toast().show(
        'Checking if model is downloaded...',
        modelManager
            .isModelDownloaded(language)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        Get.context!,
        );
  }

  Future<void> deleteModel() async {
    Toast().show(
        'Deleting model...',
        modelManager
            .deleteModel(language)
            .then((value) => value ? 'success' : 'failed'),
        Get.context!,
        );
  }

  Future<void> downloadModel() async {
    Toast().show(
        'Downloading model...',
        modelManager
            .downloadModel(language)
            .then((value) => value ? 'success' : 'failed'),
        Get.context!,
        );
  }

  Future<void> recogniseText() async {
    showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: Text('Recognizing'),
        ),
        barrierDismissible: true);
    try {
      final candidates = await digitalInkRecognizer.recognize(ink);
      recognizedText = '';
      for (final candidate in candidates) {
        recognizedText += '\n${candidate.text}';
      }
     update();
    } catch (e) {
     Get.snackbar("error", e.toString());
    }
    Get.back();
  }

}
