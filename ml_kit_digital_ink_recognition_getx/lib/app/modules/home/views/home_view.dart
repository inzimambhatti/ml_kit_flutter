import 'package:flutter/material.dart' hide Ink;
import 'package:get/get.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GetBuilder<HomeController>(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(title: Text('Digital Ink Recognition : Bhatti')),
              body: SafeArea(
                child: Column(

                  children: [
                    Text("Start writing below :"),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)
                        ),
                        child: GestureDetector(
                          onPanStart: (DragStartDetails details) {
                            controller.ink.strokes.add(Stroke());
                            controller.update();
                          },
                          onPanUpdate: (DragUpdateDetails details) {
                            ///start state
                              final RenderObject? object = Get.context?.findRenderObject();
                              final localPosition = (object as RenderBox?)
                                  ?.globalToLocal(details.localPosition);
                              if (localPosition != null) {
                               controller. points = List.from(controller.points)
                                  ..add(StrokePoint(
                                    x: localPosition.dx,
                                    y: localPosition.dy,
                                    t: DateTime.now().millisecondsSinceEpoch,
                                  ));
                              }
                              if (controller.ink.strokes.isNotEmpty) {
                                controller.ink.strokes.last.points = controller.points.toList();
                              }
                              controller.update();
                            ///end set state
                          },
                          onPanEnd: (DragEndDetails details) {
                            controller.points.clear();
                            ///
                          },
                          child: CustomPaint(
                            painter: Signature(ink: controller.ink),
                            size: Size.infinite,
                          ),
                        ),
                      ),
                    ),
                    if (controller.recognizedText.isNotEmpty)
                      Container(
                       margin: EdgeInsets.all(7),
                        width: Get.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green)
                        ),
                        child: Center(
                          child: Text(
                            'Candidates: ${controller.recognizedText}',
                            style: TextStyle(fontSize: 23),
                          ),
                        ),
                      ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       padding: EdgeInsets.all(10),
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.orange),
                         borderRadius: BorderRadius.circular(20)
                       ),
                       child: Column(
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               ElevatedButton(
                                 child: Text('Read Text'),
                                 onPressed: controller.recogniseText,
                               ),
                               ElevatedButton(
                                 child: Text('Clear Pad'),
                                 onPressed: controller.clearPad,
                               ),
                             ],
                           ),
                          
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               ElevatedButton(
                                 child: Text('Check Model'),
                                 onPressed: controller.isModelDownloaded,
                               ),
                               ElevatedButton(
                                 child: Text('Download'),
                                 onPressed: controller.downloadModel,
                               ),
                               ElevatedButton(
                                 child: Text('Delete'),
                                 onPressed: controller.deleteModel,
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),
                   )

                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}
class Signature extends CustomPainter {
  Ink ink;
  var controller=Get.put(HomeController());
  Signature({required this.ink});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (final stroke in ink.strokes) {
      for (int i = 0; i < stroke.points.length - 1; i++) {
        final p1 = stroke.points[i];
        final p2 = stroke.points[i + 1];
        canvas.drawLine(Offset(p1.x.toDouble(), p1.y.toDouble()),
            Offset(p2.x.toDouble(), p2.y.toDouble()), paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => true;
}
