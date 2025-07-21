import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final _key = 'themeMode';

  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }

  void changeThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    _saveThemeMode(mode);
  }

  // Placeholder for loading theme from storage
  void _loadThemeMode() {
    final savedMode = _storage.read<String>(_key);

    if (savedMode == 'light') {
      themeMode.value = ThemeMode.light;
    } else if (savedMode == 'dark') {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.system;
    }

    Get.changeThemeMode(themeMode.value);
  }

  // Placeholder for saving theme to storage

  void _saveThemeMode(ThemeMode mode) {
    final modeStr =
        mode == ThemeMode.dark
            ? 'dark'
            : mode == ThemeMode.light
            ? 'light'
            : 'system';
    _storage.write(_key, modeStr);
  }

  // Label for display (On, Off, System)
  String get themeModeLabel {
    switch (themeMode.value) {
      case ThemeMode.dark:
        return 'On';
      case ThemeMode.light:
        return 'Off';
      case ThemeMode.system:
      default:
        return 'System';
    }
  }
}
