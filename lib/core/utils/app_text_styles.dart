import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTitleStyle(
        {Color color = const Color(0xFF0B8FAC),
        double? fontSize = 18,
        FontWeight? fontWeight = FontWeight.bold}) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: GoogleFonts.cairo().fontFamily,
    );

TextStyle getbodyStyle(
        {Color color = const Color(0xFF35364F),
        double? fontSize = 14,
        FontWeight? fontWeight = FontWeight.w400}) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: GoogleFonts.cairo().fontFamily,
    );

TextStyle getsmallStyle(
        {Color color = const Color(0xFF35364F),
        double? fontSize = 12,
        FontWeight? fontWeight = FontWeight.w500}) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: GoogleFonts.cairo().fontFamily,
    );
