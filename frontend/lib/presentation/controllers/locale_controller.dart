import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends GetxController {
  final _locale = const Locale('en').obs;
  final _storage = GetStorage();

  Locale get locale => _locale.value;

  @override
  void onInit() {
    super.onInit();
    String? langCode = _storage.read('lang');
    if (langCode != null) {
      _locale.value = Locale(langCode);
      Get.updateLocale(_locale.value);
    }
  }

  void changeLocale(Locale newLocale) {
    _locale.value = newLocale;
    _storage.write('lang', newLocale.languageCode);
    Get.updateLocale(newLocale);
  }
}
