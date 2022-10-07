import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_text_extractor_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:contactus/contactus.dart';
import '../../../../constants.dart';
class HelpCenterView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kIconColor),
        title: const Text(
          'Help Center',
          style: TextStyle(color:Colors.white),
        ),
        centerTitle: true,
        toolbarHeight: 40,
      ),
      backgroundColor: Colors.black,
      body: ContactUs(
        textColor: Colors.white,
        companyColor: kPrimaryColor,
        cardColor: kPrimaryColor,
        logo: AssetImage("assets/images/profile.JPG"),
        email: 'inzimamb5@gmail.com',
        companyName: 'Inzimam Bhatti',
        phoneNumber: '+92 306 9797441',
        githubUserName: 'inzimambhatti',
        linkedinURL: 'https://www.linkedin.com/in/inzimam-bhatti-79b755172/',
        tagLine: 'Flutter Developer',
        twitterHandle: 'iamInzimam',
        taglineColor: Colors.black,
        instagram: 'iam.inzimam',
        facebookHandle: 'iaminzimam',
      ),
    );
  }
}
