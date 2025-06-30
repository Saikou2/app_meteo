import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kBgLight = Color(0xFFF1F5F9);
const Color kBgDark  = Color(0xFF121212);


final ThemeData lightThemeData = ThemeData(
  scaffoldBackgroundColor: kBgLight,
  colorSchemeSeed: Colors.deepPurple,
  textTheme: GoogleFonts.poppinsTextTheme(),
  useMaterial3: true,
);


final ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: kBgDark,
  colorSchemeSeed: Colors.deepPurple,
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.dark().textTheme,
  ),
  useMaterial3: true,
);
