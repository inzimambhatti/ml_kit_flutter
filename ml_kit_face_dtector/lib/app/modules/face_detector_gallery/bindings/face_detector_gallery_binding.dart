import 'package:get/get.dart';

import '../controllers/face_detector_gallery_controller.dart';

class FaceDetectorGalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceDetectorGalleryController>(
      () => FaceDetectorGalleryController(),
    );
  }
}
