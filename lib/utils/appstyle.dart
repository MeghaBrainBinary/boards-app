import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

TextStyle appTextStyle({Color? color, double? fontSize, FontWeight? weight,}) {
  return GoogleFonts.inter(
    color: color ?? Colors.white,
    fontSize: fontSize ?? 18,
    fontWeight: weight ?? FontWeight.normal,
  );
}


TextStyle appTextStyleItalic({Color? color, double? fontSize, FontWeight? weight,}) {
  return GoogleFonts.inter(
    color: color ?? Colors.white,
    fontSize: fontSize ?? 18,
    fontWeight: weight ?? FontWeight.normal,
    fontStyle: FontStyle.italic,

  );
}