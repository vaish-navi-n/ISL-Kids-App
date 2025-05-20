import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Singleton pattern for easy access to ThemeController instance
  static ThemeController get to => Get.find();

  // Observable variable to track the current theme mode (system, light, dark)
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  // Getter to retrieve the current theme mode
  ThemeMode get themeMode => _themeMode.value;

  // Method to toggle between light and dark themes
  void toggleTheme() {
    if (_themeMode.value == ThemeMode.light) {
      _themeMode.value = ThemeMode.dark; // Update observable theme mode
      Get.changeThemeMode(ThemeMode.dark); // Apply theme change globally
    } else {
      _themeMode.value = ThemeMode.light;
      Get.changeThemeMode(ThemeMode.light);
    }
  }

  // Method to set the theme mode to follow the system settings
  void setSystemTheme() {
    _themeMode.value = ThemeMode.system; // Update observable theme mode
    Get.changeThemeMode(ThemeMode.system); // Apply system theme globally
  }
}
