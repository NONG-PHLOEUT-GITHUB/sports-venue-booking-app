import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/otp_comfirm_screen.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPhoneSelected = true;
  // Define the languages and selected value
  // Language + Flag map
  final Map<String, String> _languageFlags = {
    'English': '🇺🇸',
    'Khmer': '🇰🇭',
  };

  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🔽 Language dropdown with flags
                  Align(
                    alignment: Alignment.topRight,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedLanguage,
                        icon: const Icon(Icons.language, color: Colors.black54),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                        items: _languageFlags.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Row(
                              children: [
                                Text(entry.value,
                                    style: const TextStyle(fontSize: 20)),
                                const SizedBox(width: 8),
                                Text(entry.key),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLanguage = newValue!;
                          });
                          _saveLanguageChange();
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                   Text(
                    AppLocalizations.of(context)!.loginTitle,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.welcomeMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => isPhoneSelected = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: !isPhoneSelected
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.email,
                                style: TextStyle(
                                  color: !isPhoneSelected
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => isPhoneSelected = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: isPhoneSelected
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.phoneNumber,
                                style: TextStyle(
                                  color: isPhoneSelected
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (isPhoneSelected) ...[
                    Text(
                      AppLocalizations.of(context)!.phoneNumber,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    // IntlPhoneField(
                    //   decoration: const InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     hintText: 'Enter phone number',
                    //   ),
                    //   initialCountryCode: 'US',
                    //   onChanged: (phone) {},
                    // ),
                    TextField(
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context)!.enterPhoneNumber,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      // keyboardType: TextInputType.emailAddress,
                    ),
                  ] else ...[
                    Text(
                      AppLocalizations.of(context)!.email,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enterEmail,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OtpVerificationPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.sendCode,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(AppLocalizations.of(context)!.signInWith),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _socialButton('Google', 'assets/images/google.webp'),

                  const SizedBox(height: 16),

                  _socialButton('Facebook', 'assets/images/fb.webp'),

                  const SizedBox(height: 32),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: AppLocalizations.of(context)!.dontHaveAccount,
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.signUp,
                            style: const TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // 👇 Push to register screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String name, String imagePath) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Image.asset(
          imagePath,
          width: 24,
          height: 24,
        ),
        label: Text(name),
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  void _saveLanguageChange() {
    Locale newLocale =
        _selectedLanguage == 'Khmer' ? const Locale('km') : const Locale('en');

    MyApp.setLocale(context, newLocale);
  }
}
