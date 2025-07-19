import 'package:flutter/material.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/main.dart';
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
    Locale newLocale =
        _selectedLanguage == 'Khmer' ? const Locale('km') : const Locale('en');
    MyApp.setLocale(context, newLocale);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.languageChanged)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleText = Text(
      AppLocalizations.of(context)!.changeLanguage,
    );

    final backButton = Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 1.2),
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );

    final saveButton = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveLanguageChange,
        style: ElevatedButton.styleFrom(
          backgroundColor:Get.theme.colorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          AppLocalizations.of(context)!.btnSave,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final bottomContainer = Container(
      padding: const EdgeInsets.fromLTRB(10, 24, 16, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [saveButton],
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: backButton,
        title: titleText,
      ),
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
          bottomContainer,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Get.theme.colorScheme.primary : Colors.grey.shade300,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
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
