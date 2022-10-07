import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml_text_extractor_flutter/constants.dart';
import 'package:ml_text_extractor_flutter/widgets/default_button.dart';
import 'package:share_plus/share_plus.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  bool visibility=false;
  bool isImagePicked=false;
  var selectedImagePath=''.obs;
  var extractedText=''.obs;
  RxBool isProcessButtonEnabled=false.obs;
  bool isCameraSource=false;
  TextEditingController ?textController=TextEditingController();


  final Uri _url = Uri.parse('https://inzimamb5.wixsite.com/inzimambhatti');

  ///get image method
  getImage(ImageSource imageSource) async{
    final pickedFile= await ImagePicker().pickImage(source:
    isCameraSource==false?
    ImageSource.gallery:ImageSource.camera);
    if(pickedFile!=null){
      selectedImagePath.value=pickedFile.path;
      isProcessButtonEnabled.value=true;
    }
    else{
       Get.snackbar(

           "Error", "image is not selected"
       ,
       backgroundColor: Colors.redAccent,
       colorText: kPrimaryLightColor);
    }
update();
  }
  ///recognise image text method
  Future<void> recognizedText(String pickedImage) async {
    if (pickedImage == null) {
      Get.snackbar(
          "Error", "image is not selected"
          ,
          backgroundColor: Colors.redAccent,
      colorText: kPrimaryLightColor);
    }
    else {
      extractedText.value = '';
      var textRecognizer = GoogleMlKit.vision.textRecognizer();
      final visionImage = InputImage.fromFilePath(pickedImage);
      try{

        var visionText= await textRecognizer.processImage(visionImage);
        for(TextBlock textBlock in visionText.blocks){
          for(TextLine textLine in textBlock.lines){
            for(TextElement textElement in textLine.elements){
              extractedText.value=extractedText.value + textElement.text+' ';
            }
            extractedText.value=extractedText.value + " \n";


          }
        }
      }
      catch(e){
        Get.snackbar(

            "File Error", e.toString()
            ,
            backgroundColor: Colors.redAccent,
        colorText: kPrimaryLightColor);
      }
      textController?.text=extractedText.value;
      update();
    }

  }
  bool checkVisibility(){
    if(extractedText.value.isNotEmpty){
      visibility=true;
    }
    else visibility=false;
    return visibility;
  }
  Visibility actionButtonRow(){
    return Visibility(
      visible: checkVisibility(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: (){
            FlutterClipboard.copy(extractedText.value??'')
                .then((value) {
             Get.snackbar("Copied", "Text is copied to clipboard",backgroundColor: kSnackSuccessBackground,colorText: kPrimaryLightColor);
            });
          }, icon: Icon(Icons.copy,color: Colors.teal,),),
          IconButton(onPressed: (){
            Share.share("Extracted Text" ": ${extractedText.value}",
                subject: "Extracted Text");
          }, icon: Icon(Icons.share,color: Colors.teal,),),
          IconButton(onPressed: ()async{
            Get.bottomSheet(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: Get.height/2.8,
                    decoration:kBottomSheetDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                      TextFormField(
                   maxLines: 10,
                   style: TextStyle(color: kPrimaryLightColor),
                       controller: textController,
                         decoration: InputDecoration(
  ),
),
                          DefaultButton(color: kProcessButtonDisabledColor,text: "OK",press: (){
                            extractedText.value=textController!.text;
                            Get.back();

                          },)
                        ],
                      ),
                    )),
              ),
              isDismissible: false,
              // barrierColor: Colors.red[50],
              enableDrag: false,
            );
          }, icon: Icon(Icons.edit,color: Colors.teal,),),
          IconButton(onPressed: (){
            extractedText.value="";
            textController?.text="";
            update();
          }, icon: Icon(Icons.delete_forever_outlined,color: Colors.teal,))
        ],
      ),
    );
  }
  Future<void> launchWebsite() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
    @override
    void onInit() {
      textController = TextEditingController();
      super.onInit();
    }

    @override
    void onReady() {
      super.onReady();
    }

    @override
    void onClose() {
      textController?.dispose();
      super.onClose();
    }
  }
}
