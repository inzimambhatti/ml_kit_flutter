import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml_text_extractor_flutter/widgets/default_button.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../../../widgets/drawer_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    TextEditingController txtController=TextEditingController(text: controller.extractedText.value);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extracto'),
        centerTitle: true,
        elevation: 10,
        iconTheme: IconThemeData(color: kIconColor),
        actions: [
          IconButton(onPressed: (){
            controller.isCameraSource=true;
            controller.getImage(ImageSource.camera);}, icon: Icon(Icons.camera_alt_outlined,color: Colors.teal,size: 20,))
        ],

      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: GetBuilder<HomeController>(
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    ///image box container
        DefaultButton(text: "Pick Image From Gallery",press:(){controller.getImage(ImageSource.gallery);},color: kPrimaryColor,),

                    ///image box container
                    Container(
                        height: SizeConfig.screenHeight/3,

                        decoration:kBoxDecorationImage,
                        child:
                        ///image box scrollview
                        Obx(()=>
                        controller.selectedImagePath.value==''?
                        const Center(
                            child: Text("Select an image from Gallery")
                        ):
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Stack(
                              children: [
                                Image.file(
                                  File(controller.selectedImagePath.value,),
                                  width: Get.width,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child:
                                  IconButton(icon: Icon(Icons.cancel,color: Colors.teal,),onPressed: (){controller.selectedImagePath.value='';},),),
                              ],
                            ),
                          ),
                        ),
                        )
                    ),

                    Obx(()=>
                       DefaultButton(text: "Process This Image",press: (){
                         if(controller.selectedImagePath.value.isNotEmpty)
                         controller.recognizedText(controller.selectedImagePath.value);
                         else
                           Get.snackbar("Something went wrong", "Image is not selected",backgroundColor: kSnackErrorBackground,colorText: kPrimaryLightColor);

                           },color:
                       controller.selectedImagePath.value.isEmpty?
                          kProcessButtonDisabledColor:
                      kProcessButtunColor,
                      ),
                    ),
                    controller.actionButtonRow(),
                    Container(
                      height: Get.height/3,
                      decoration: kBoxDecorationText,
                      child: Obx(()=>
                      controller.extractedText.value.isEmpty?
                      const Center(child: Text("Text Not Found")):
                      Center(child:Padding(padding: EdgeInsets.all(10),child:  SingleChildScrollView(child: Text(controller.extractedText.value)),)
                      ),
                      ),
                    )
                  ],
                );
              }
            ),
          )
        ),
      ),
    );
  }
}
