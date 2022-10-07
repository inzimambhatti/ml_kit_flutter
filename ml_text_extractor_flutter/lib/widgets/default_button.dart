import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
   DefaultButton({
    Key? key,
    this.text,
    this.press,
    required this.color,
  }) : super(key: key);
  final String? text;
  Color color;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
     // height: getProportionateScreenHeight(100),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          primary: Colors.white,
          backgroundColor: color,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: kTextStyleDefaultButton
        ),
      ),
    );
  }
}
