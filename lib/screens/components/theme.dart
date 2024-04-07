import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4E5AE8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4669);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = const Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

TextStyle get greyStyle {
  return GoogleFonts.alikeAngular(
    textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Get.isDarkMode ? Colors.grey[500] : Colors.grey),
  );
}

TextStyle get subGreyStyle {
  return GoogleFonts.alikeAngular(
    textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Colors.grey ),
  );
}

TextStyle get pinkStyle {
  return GoogleFonts.alikeAngular(
    textStyle: const TextStyle(
        fontWeight: FontWeight.normal, fontSize: 25, color: pinkClr),
  );
}

TextStyle get blackStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 23,
        color: Get.isDarkMode ? Colors.white : Colors.black),
  );
}

TextStyle get subStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Get.isDarkMode ? Colors.white : Colors.black87),
  );
}
