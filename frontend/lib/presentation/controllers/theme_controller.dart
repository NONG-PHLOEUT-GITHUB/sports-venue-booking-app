import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';
import 'package:frontend/l10n/app_localizations.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final _key = 'themeMode';
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void changeThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    _saveThemeMode(mode);

    if (mode == ThemeMode.system) {
      _timer?.cancel(); // nothing to override
    }
  }

  // Placeholder for loading theme from storage
  void _loadThemeMode() {
    final savedMode = _storage.read<String>(_key);

    if (savedMode == 'light') {
      changeThemeMode(ThemeMode.light);
    } else if (savedMode == 'dark') {
      changeThemeMode(ThemeMode.dark);
    } else if (savedMode == 'system') {
      changeThemeMode(ThemeMode.system);
    } else {
      changeThemeMode(ThemeMode.light); // default
    }
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

  void _startAutoThemeTimer() {
    _timer?.cancel(); // clear previous timer
    _timer = Timer.periodic(const Duration(minutes: 30), (_) {
      _applyTimeBasedTheme();
    });
  }

  void _applyTimeBasedTheme() {
    final hour = DateTime.now().hour;
    if (hour >= 18 || hour < 6) {
      themeMode.value = ThemeMode.dark;
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      themeMode.value = ThemeMode.light;
      Get.changeThemeMode(ThemeMode.light);
    }
  }

  // Label for display (On, Off, System)
  String getModeLabel(ThemeMode mode, BuildContext context) {
    switch (mode) {
      case ThemeMode.dark:
        return AppLocalizations.of(context)!.on;
      case ThemeMode.light:
        return AppLocalizations.of(context)!.off;
      case ThemeMode.system:
        return AppLocalizations.of(context)!.system;
    }
  }
}
