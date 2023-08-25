import 'package:flutter/material.dart';

class CustomTextStyles {
  static normal({fontSize , fontColor,bool? isUnderLine, fontWeight}) {
    return TextStyle(
        color: fontColor, fontFamily: "Roboto-Regular", fontSize: fontSize,decoration: isUnderLine==true ?TextDecoration.underline:TextDecoration.none,fontWeight: fontWeight);
  }

  static bold({fontSize ,fontColor,}) {
    return TextStyle(
        color: fontColor, fontFamily: "Roboto-Bold", fontSize: fontSize);
  }

  static medium({fontSize ,fontColor,bool? isUnderLine}) {
    return TextStyle(
      color: fontColor, fontFamily: "Roboto-Medium", fontSize: fontSize,decoration: isUnderLine==true ?TextDecoration.underline:TextDecoration.none,);
  }
  static semiBold({fontSize , fontColor}) {
    return TextStyle(
        color: fontColor, fontFamily: "Roboto-Italic", fontSize: fontSize);
  }
}
