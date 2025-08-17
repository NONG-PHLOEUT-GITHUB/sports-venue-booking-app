import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_screen.dart';
import 'package:frontend/controllers/locale_controller.dart';
import 'package:frontend/l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();
    final localization = AppLocalizations.of(context)!;

    final Color primaryColor = Get.theme.colorScheme.primary;
    final Color whiteColor = Colors.white;

    final List<Map<String, String>> languages = [
      {'label': "English", 'flag': '🇬🇧', 'code': 'en'},
      {'label': 'ភាសាខ្មែរ', 'flag': '🇰🇭', 'code': 'km'},
    ];

    // Build a language selection sheet dynamically from the list
    void _showLanguageSelectionSheet() {
      Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 213, 208, 208),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localization.language,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16.0),
              ...languages.map((language) {
                final bool isSelected =
                    localeController.locale.languageCode == language['code'];
                return Card(
                  elevation: 1,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Text(
                      language['flag']!,
                      style: const TextStyle(fontSize: 28),
                    ),
                    title: Text(language['label']!),
                    trailing:
                        isSelected
                            ? Icon(Icons.check_circle, color: primaryColor)
                            : const Icon(Icons.radio_button_unchecked),
                    onTap: () {
                      localeController.changeLocale(Locale(language['code']!));
                      Get.back();
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        isDismissible: true,
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top-right language selector button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _showLanguageSelectionSheet,
                  child: Obx(() {
                    final langCode = localeController.locale.languageCode;
                    final languageLabel =
                        languages.firstWhere(
                          (lang) => lang['code'] == langCode,
                        )['label'] ??
                        'English';
                    return Text(
                      languageLabel,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      semanticsLabel: localization.language,
                    );
                  }),
                ),
              ),

              // Center logo and welcome text
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'https://i.pinimg.com/1200x/f1/af/d0/f1afd0f196c1796951e924cfd958af46.jpg', // replace with your image URL
                    // width: 100,
                    // height: 100,
                    fit: BoxFit.contain,
                    semanticLabel: 'App Logo',
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        width: 100,
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 100,
                        semanticLabel: 'Error loading logo',
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                  Text(
                    // localization.welcome, // Use localization key here
                    "Every great match starts with the right venue.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    semanticsLabel: localization.welcome,
                  ),
                ],
              ),
              // https://i.pinimg.com/736x/89/8c/25/898c25d871c899822fd798ff99c8eaaa.jpg

              // Bottom Get Started button — full width with padding
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(
                      localization.getStarted,
                    ), // Assuming you have this key
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: whiteColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Get.to(() => LoginScreen()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
