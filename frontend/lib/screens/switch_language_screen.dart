import 'package:flutter/material.dart';
import 'package:frontend/controllers/locale_controller.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/widgets/app_primary_button.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import 'package:get/get.dart';

class SwitchLanguageScreen extends StatelessWidget {
  SwitchLanguageScreen({Key? key}) : super(key: key);

  final localeController = Get.find<LocaleController>();

  final List<Map<String, String>> languages = [
    {'label': 'English', 'flag': '🇬🇧', 'code': 'en'},
    {'label': 'Khmer', 'flag': '🇰🇭', 'code': 'km'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(AppLocalizations.of(context)!.changeLanguage),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final currentLangCode = localeController.locale.languageCode;
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: languages.length,
                separatorBuilder: (_, __) => const SizedBox(height: 0),
                itemBuilder: (context, index) {
                  final language = languages[index];
                  final isSelected = currentLangCode == language['code'];

                  return _buildLanguageItem(language, isSelected);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(Map<String, String> language, bool isSelected) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Text(
          language['flag']!,
          style: const TextStyle(fontSize: 28),
        ),
        title: Text(language['label']!),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: Get.theme.colorScheme.primary)
            : const Icon(Icons.radio_button_unchecked),
        onTap: () {
          final localeController = Get.find<LocaleController>();
          localeController.changeLocale(Locale(language['code']!));
        },
      ),
    );
  }
}
