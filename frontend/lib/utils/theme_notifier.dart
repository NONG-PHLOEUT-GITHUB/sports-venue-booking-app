import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  // Store themeMode as observable
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  bool get isDark => themeMode.value == ThemeMode.dark;

  void toggleTheme(bool isDarkMode) {
    themeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    // Apply theme change globally:
    Get.changeThemeMode(themeMode.value);
  }
}
