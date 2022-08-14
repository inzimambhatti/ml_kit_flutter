import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import 'package:google_mlkit_commons/google_mlkit_commons.dart';
class HomeController extends GetxController {
  //TODO: Implement HomeController

  var selectedImagePath=''.obs;
  var extractedBarcode=''.obs;
  ///get image method
  getImage(ImageSource imageSource) async{
    final pickedFile= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      selectedImagePath.value=pickedFile.path;
    }
    else{
       Get.snackbar(

           "Error", "image is not selected"
       ,
       backgroundColor: Colors.red);
    }

  }

  ///recognise image text method
  Future<void> recognizedText(String pickedImage) async {
    if (pickedImage == null) {
      Get.snackbar(

          "Error", "image is not selected"
          ,
          backgroundColor: Colors.red);
    }
    else {
      extractedBarcode.value = '';
      var barCodeScanner = GoogleMlKit.vision.barcodeScanner();
      final visionImage = InputImage.fromFilePath(pickedImage);
      try{

        var barcodeText= await barCodeScanner.processImage(visionImage);

        for(Barcode barcode in barcodeText){
          extractedBarcode.value=barcode.displayValue!;

        }
      }
      catch(e){
        Get.snackbar(

            "Error", e.toString()
            ,
            backgroundColor: Colors.red);
      }
    }
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
