import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ml_kit_object_detector_flutter/components/custom_button.dart';
import 'package:ml_kit_object_detector_flutter/painter/Object_Painter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Object Detector flutter"),
            centerTitle: true,
            toolbarHeight: 40,

          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                  child: Container(
                    width: Get.width,
                    height: 200,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                    ),
                    child:
                    (controller.selectedImagePath.value.isEmpty)
                        ? Center(child: Text('No image selected')):
                    FittedBox(
                      child: SizedBox(
                        width: controller.iimage?.width.toDouble(),
                        height: controller.iimage?.height.toDouble(),
                        child: Image.file(File(controller.selectedImagePath.value)),
                      ),
                    ),
                  ),
                ),
                DefaultButton(btnColor: Colors.white,press: (){
                  controller.getImageAndDetectObjects();
                },
                text: "Pick Image",),
                Container(
                  width: Get.width,
                  height: 200,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                  child:
                  (controller.iimageFile == null)
                      ? const Center(child: Text('No object detected in image')):
                  FittedBox(
                    child: SizedBox(
                      width: controller.iimage?.width.toDouble(),
                      height: controller.iimage?.height.toDouble(),
                      child: CustomPaint(
                        painter: ObjectPainter(controller.iimage!, controller.objectss!),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          )
        );
      }
    );
  }
}
