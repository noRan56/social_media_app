import 'package:flutter/material.dart';

ThemeData DarkModeTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade400,
  ),
  textTheme: ThemeData.dark()
      .textTheme
      .apply(bodyColor: Colors.grey[400], displayColor: Colors.white),
);
