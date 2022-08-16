

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:logger/logger.dart';

class HomeController extends GetxController {
 RxBool isInitializedCamera=false.obs;
 //RxBool isInitializedCamera=false.obs;
  FaceDetector ?_faceDetector;
  late CameraController   cameraController;

  //TODO: Implement HomeController
 var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
  ),
 );
  final count = 0.obs;
  @override
  Future<void> onInit() async {
    var cameras= await availableCameras();
   cameraController=CameraController(cameras[0],ResolutionPreset.high);
//initializeCamera();
_faceDetector=GoogleMlKit.vision.faceDetector(
   FaceDetectorOptions(
  performanceMode: FaceDetectorMode.accurate
 )
);
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
  Future getAvailableCamera() async {
  final  cameras= await availableCameras();
  return cameras;
  }
 initializeCamera() async{
   await cameraController.initialize();
isInitializedCamera.value=true;
cameraController.setFlashMode(FlashMode.always);

update();
 }

}
