import 'package:flutter/material.dart';
import 'package:frontend/controllers/locale_controller.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/widgets/app_primary_button.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import 'package:get/get.dart';

class SwitchLanguagePage extends StatefulWidget {
  const SwitchLanguagePage({super.key});

  @override
  _SwitchLanguagePageState createState() => _SwitchLanguagePageState();
}

class _SwitchLanguagePageState extends State<SwitchLanguagePage> {
  String _selectedLanguage = 'English';

  final List<Map<String, String>> languages = [
    {'label': 'English', 'flag': '🇬🇧'},
    {'label': 'Khmer', 'flag': '🇰🇭'},
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final locale = Localizations.localeOf(context);
    _selectedLanguage = locale.languageCode == 'km' ? 'Khmer' : 'English';
  }

  void _saveLanguageChange() {
    final localeController = Get.find<LocaleController>();

    Locale newLocale =
        _selectedLanguage == 'Khmer' ? const Locale('km') : const Locale('en');

    localeController.changeLocale(newLocale);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.languageChanged)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleText = Text(AppLocalizations.of(context)!.changeLanguage);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(leading: CustomBackButton(), title: titleText),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: languages.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16.0),
              itemBuilder: (context, index) {
                final language = languages[index];
                final isSelected = _selectedLanguage == language['label'];

                return _buildLanguageItem(language, isSelected);
              },
            ),
          ),
          AppPrimaryButton(
            text: AppLocalizations.of(context)!.btnSave,
            onPressed: _saveLanguageChange,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(Map<String, String> language, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = language['label']!;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected
                    ? Get.theme.colorScheme.primary
                    : Colors.grey.shade300,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Get.theme.colorScheme.surface,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(language['flag']!, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                language['label']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
