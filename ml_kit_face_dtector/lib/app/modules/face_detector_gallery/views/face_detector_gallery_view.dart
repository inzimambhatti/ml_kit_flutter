import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/face_detector_gallery_controller.dart';

class FaceDetectorGalleryView extends GetView<FaceDetectorGalleryController> {
  const FaceDetectorGalleryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(FaceDetectorGalleryController());
    return GetBuilder<FaceDetectorGalleryController>(
      builder: (context) {
        return Scaffold(
          body: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : (controller.iimageFile == null)
              ? Center(child: Text('No image selected'))
              : Center(
            child: FittedBox(
              child: SizedBox(
                width: controller.iimage?.width.toDouble(),
                height: controller.iimage?.height.toDouble(),
                child: CustomPaint(
                  painter: FacePainter(controller.iimage!, controller.facess!),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: controller.getImageAndDetectFaces,
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),
          ),
        );
      }
    );
  }
}
