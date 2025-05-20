import 'package:flutter/material.dart';

class TAppTheme {
  // Defines the light theme settings
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.indigo, // Sets the primary color scheme
    brightness: Brightness.light, // Ensures a light appearance
  );

  // Defines the dark theme settings
  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.indigo, // Uses the same primary color for consistency
    brightness: Brightness.dark, // Ensures a dark appearance
  );
}
