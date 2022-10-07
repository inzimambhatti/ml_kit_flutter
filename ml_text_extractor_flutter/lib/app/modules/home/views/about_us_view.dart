import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:ml_text_extractor_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:ml_text_extractor_flutter/constants.dart';
import 'package:ml_text_extractor_flutter/widgets/default_button.dart';

class AboutUsView extends GetView<HomeController> {
  const AboutUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
        iconTheme: IconThemeData(color: kIconColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Text(
            'This application is designed and developed by:',
            style: TextStyle(fontSize: 15,color: Colors.white70),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 63,
              backgroundImage: AssetImage("assets/images/profile.JPG"),
            ),
          ),
          Center(
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Inzimam Bhatti',
                  textStyle: kColorizeTextStyle,
                  colors:kColorizeDeveloperName,
                ),
              ],
              isRepeatingAnimation: true,
              onTap: () {
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultButton(color: kPrimaryColor,press: (){controller.launchWebsite();},text: "Visit Website",),
        )
        ],
      ),
    );
  }
}
