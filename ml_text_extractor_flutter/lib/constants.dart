
import 'package:flutter/material.dart';
import 'package:ml_text_extractor_flutter/size_config.dart';


const kPrimaryColor = Color(0xFFEB1555);
const kScaffoldBackgroundColor = Colors.black;
const kProcessButtunColor = Colors.green;
const kSnackSuccessBackground = Colors.green;
const kSnackErrorBackground = Colors.red;
const kPrimaryLightColor = Color(0xFFFFECDF);
const kDrawerBodyBackgroundColor = Colors.black;
final kColorizeDeveloperName = [
  kPrimaryColor,
  Colors.teal,
  Colors.white,
  Colors.orange,
];
const kColorizeTextStyle = TextStyle(
  fontSize: 25.0,
  fontFamily: 'Horizon',
);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kProcessButtonDisabledColor= Color(0xFF757575);
const kAnimationDuration = Duration(milliseconds: 200);
final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);
final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

const kBottomContainerHeight = 50.0;
const kActiveCardColour = Colors.white;
const kIconColor= Colors.teal;
const kBoxBackgroundColor = Color(0xFF111328);


const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kNumberTextStyle = TextStyle(
  color: Colors.blue,
  fontSize: 14.0,
  fontWeight: FontWeight.w900,
);
const kEarningNumberTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kNormalTextStyle = TextStyle(
  fontSize: 13.0,
  fontWeight: FontWeight.w400,
  color: Colors.grey,

);
final  kTextStyleDefaultButton=TextStyle(
  fontSize: getProportionateScreenWidth(17),
  color: Colors.white,
);
final kBoxDecorationImage=BoxDecoration(
  color:kBoxBackgroundColor,
  border: Border.all(color: kPrimaryColor),borderRadius: BorderRadius.circular(16),
);
final kBoxDecorationText=BoxDecoration(
  color:kBoxBackgroundColor,
  border: Border.all(color: kProcessButtunColor),
    borderRadius: BorderRadius.circular(16)
);
final kBottomSheetDecoration=BoxDecoration(
  color:Colors.black,
  border: Border.all(color: Colors.black),
    borderRadius: BorderRadius.circular(5)
);



