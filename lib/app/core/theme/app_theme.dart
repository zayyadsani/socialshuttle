import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    accentColor: Colors.white,
    buttonColor: Colors.grey,
  );

  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}