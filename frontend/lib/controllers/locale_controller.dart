import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  var currentLocale = const Locale('en').obs;

  void changeLocale(Locale locale) {
    currentLocale.value = locale;
    Get.updateLocale(locale); // Apply locale to GetMaterialApp
  }
}
