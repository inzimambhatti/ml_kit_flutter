import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'components/camera_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (context) {
        return   CameraView(
          title: 'Image Labeler by Bhatti',
          customPaint:controller.getCustomPaint,
          text: controller.getText,
          onImage: controller.processImage,
        );
      }
    );
  }
}
