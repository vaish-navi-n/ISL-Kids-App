import 'package:flutter/material.dart';
import 'package:isl_kids_app/src/constants/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._(); // Private constructor to prevent instantiation

  // Light theme for TextFormField styling
  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
        border: OutlineInputBorder(), // Adds a default border
        prefixIconColor: tSecondaryColor, // Sets prefix icon color
        floatingLabelStyle: TextStyle(
          color: tSecondaryColor,
        ), // Adjusts label color when focused
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: tSecondaryColor,
          ), // Customizes border when focused
        ),
      );

  // Dark theme for TextFormField styling
  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
        border: OutlineInputBorder(), // Adds a default border
        prefixIconColor: tPrimaryColor, // Sets prefix icon color for dark mode
        floatingLabelStyle: TextStyle(
          color: tPrimaryColor,
        ), // Adjusts label color when focused
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: tPrimaryColor,
          ), // Customizes border when focused
        ),
      );
}
