import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController txtController=TextEditingController(text: controller.extractedText.value);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Extractor App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ///image box container
                Container(
                  height: 220,
                  margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
          ),
child:
    ///image box scrollview
                SingleChildScrollView(
                  child: Obx(()=>

                  controller.selectedImagePath.value==''?
                  const Center(child: Text("Select an image from Gallery / camera")):
                  Image.file(
                    File(controller.selectedImagePath.value),
                    width: Get.width,
                    height: 300,
                  ),


                  ),
                )
          ),
                ///button row
                Container(
                  margin: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(onPressed: (){
                        controller.getImage(ImageSource.gallery);
                      }, child: const Text("Pick Image")),
                      ElevatedButton(onPressed: (){
                        controller.recognizedText(controller.selectedImagePath.value);
                      }, child: const Text("Extract Text")),
                    ],
                  ),
                ),
                ///text box ScrollView
                SingleChildScrollView(
                  child: Container(
                    height: 190,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Obx(()=>

                    controller.extractedText.value.isEmpty?
                    const Center(child: Text("Text Not Found")):
                    Center(child:Padding(padding: EdgeInsets.all(10),child:  TextFormField(
                      maxLines: 10,
                      controller: txtController,
                    ),)),



                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
