import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ml_kit_face_dtector/app/modules/face_detector_gallery/views/face_detector_gallery_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
        builder: (context) {
          return Stack(
            children: [
              SizedBox(width: Get.width,
              height: Get.height,
              child: controller.isInitializedCamera==true?
              CameraPreview(controller.cameraController):null,),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      controller.initializeCamera();
                     // controller.logger.w("i am logger");
                    }, child: const Text("Capture Face")),
                    ElevatedButton(onPressed: (){
                     // controller.initializeCamera();
                    Get.to(()=>FaceDetectorGalleryView());
                    }, child: const Text("Detect with Gallery")),
                  ],
                ),
              )

            ],
          );
        }
      ),
    );
  }
}
