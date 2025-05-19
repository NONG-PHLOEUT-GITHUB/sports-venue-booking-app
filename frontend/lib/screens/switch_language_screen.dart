import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/main.dart';
import 'package:frontend/theme/app_colors.dart';

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

    // Get current locale from context
    final locale = Localizations.localeOf(context);

    // Update selected language according to current locale
    if (locale.languageCode == 'km') {
      _selectedLanguage = 'Khmer';
    } else {
      _selectedLanguage = 'English';
    }
  }

  void _saveLanguageChange() {
    Locale newLocale =
        _selectedLanguage == 'Khmer' ? const Locale('km') : const Locale('en');

    // Make sure MyApp.setLocale is implemented to change the app locale dynamically
    MyApp.setLocale(context, newLocale);

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.languageChanged)),
    );

    // Return to previous screen
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
        title: Text(
          AppLocalizations.of(context)!.changeLanguage,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.onSecondary,
          ),
        ),
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

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLanguage = language['label']!;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey.shade300,
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
                        Text(
                          language['flag']!,
                          style: const TextStyle(fontSize: 24),
                        ),
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
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _saveLanguageChange,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.btnSave,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
