

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui'as ui;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var selectedImagePath=''.obs;
  var extractedBarcode=''.obs;
  RxBool isLoading = false.obs;
  XFile ?iimageFile;
  List<DetectedObject> ?objectss;
  ui.Image ?iimage;

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
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
