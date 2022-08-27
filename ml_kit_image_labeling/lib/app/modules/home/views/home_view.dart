

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ml_kit_object_detector_flutter/components/custom_button.dart';
import 'package:ml_kit_object_detector_flutter/painter/Object_Painter.dart';

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
