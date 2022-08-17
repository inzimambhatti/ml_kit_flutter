
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class FaceDetectorGalleryController extends GetxController {
  //TODO: Implement HomeController
  var logger=Logger();
  var selectedImagePath=''.obs;
  var extractedBarcode=''.obs;
  RxBool isLoading = false.obs;
XFile ?iimageFile;
List<Face> ?facess;
ui.Image ?iimage;

Future <void>getImageAndDetectFaces() async {
  final  imageFile = (await ImagePicker().pickImage(source: ImageSource.gallery)) ;
//var imageFilee=imageFile.toFile();
    isLoading.value = true;

  final image = InputImage.fromFilePath(imageFile!.path) ;
  final faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
          performanceMode: FaceDetectorMode.fast, enableLandmarks: true));
  List<Face> faces = await faceDetector.processImage(image);
      iimageFile = imageFile;
      facess = faces;
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
class FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;
  final List<Rect> rects = [];

  FacePainter(this.image, this.faces) {
    for (var i = 0; i < faces.length; i++) {
      rects.add(faces[i].boundingBox);
    }
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..color = Colors.blue;

    canvas.drawImage(image, Offset.zero, Paint());
    for (var i = 0; i < faces.length; i++) {
      canvas.drawRect(rects[i], paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }
}
