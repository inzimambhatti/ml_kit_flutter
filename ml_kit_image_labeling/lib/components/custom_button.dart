import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultButton extends StatelessWidget {
   DefaultButton({
    Key? key,
    this.text,
    required this.btnColor,
    this.press,
  }) : super(key: key);
  final String? text;
  Color btnColor;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      // height: getProportionateScreenHeight(100),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: btnColor,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
