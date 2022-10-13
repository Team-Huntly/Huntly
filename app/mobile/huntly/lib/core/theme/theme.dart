import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  highlightColor: const Color(0xffee6c4d),
  indicatorColor: const Color(0xff57e126),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    background: const Color(0xff293241),
    primary: const Color(0xff3d5a80),
    onPrimary: Colors.white,
    onSecondary: const Color(0xff293241),
    secondary: const Color(0xff98c1d9),
    brightness: Brightness.dark,
    onBackground: Colors.white
  ),
  textTheme: TextTheme(
    headline1: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 42,
      fontWeight: FontWeight.w800,
    ),
    headline4: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic
    ),
    button: GoogleFonts.poppins(
      color: const Color(0xff293241),
      fontSize: 12,
      fontWeight: FontWeight.w400
    ),
    bodyText2: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.italic,
      height: 1.2,
    )
  )
);
