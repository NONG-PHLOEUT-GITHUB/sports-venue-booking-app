import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/controllers/locale_controller.dart';
import 'package:frontend/controllers/venue_controller.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/services/venue_service.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/utils/theme_notifier.dart';
import 'screens/layout.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ThemeController());
  Get.put(LocaleController());
  Get.lazyPut(() => VenueService());
  Get.lazyPut(() => VenueController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final LocaleController localeController = Get.find();

    return Obx(
      () => GetMaterialApp(
        locale: localeController.currentLocale.value,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: themeController.themeMode.value,
        home: const MainLayout(),
      ),
    );
  }
}
