


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedza_ecommerce/screens/common/color_manager.dart';

TextStyle _getTextStyle(double fontSize,    Color? color, FontWeight fontWeight){

  return GoogleFonts.poppins(fontSize: fontSize, color: color, fontWeight: fontWeight);

}

TextStyle getRegularStyle({double fontSize = FontSize.s12,  Color? color}){

  return _getTextStyle(fontSize, color, FontWeightManager.regular);

}

TextStyle getLightStyle({double fontSize = FontSize.s12,   Color? color}){

  return _getTextStyle(fontSize,  color, FontWeightManager.light);

}

TextStyle getBoldStyle({double fontSize = FontSize.s12,   Color? color}){

  return _getTextStyle(fontSize,  color, FontWeightManager.Bold);

}

TextStyle getSemiBoldStyle({double fontSize = FontSize.s12,   Color? color}){

  return _getTextStyle(fontSize,  color, FontWeightManager.semiBold);

}


TextStyle getMediumStyle({double fontSize = FontSize.s12,   Color? color}){

  return _getTextStyle(fontSize,  color, FontWeightManager.medium);

}

class FontWeightManager{
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight Bold = FontWeight.w300;

}

class FontSize{
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s17 = 17.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
}


contentButtonStyle() {
  return  BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(5.0),
      ),
      color: AppColors.primaryOpacity70);
}

roundedButtonStyle() {
  return const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(50.0),
      ),
      color: Color(0xFF8E5F43));
}

roundedBorderButtonStyle() {
  return BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(5.0),
      ),
      border: Border.all(color: AppColors.primary));
}
