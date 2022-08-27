import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

List <CameraDescription> cameras=[];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras= await availableCameras();
  runApp(

    GetMaterialApp(

      theme: ThemeData.dark(),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
