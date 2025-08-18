import 'package:flutter/material.dart';
import 'package:frontend/controllers/locale_controller.dart';
import 'package:frontend/controllers/login_controller.dart';
import 'package:frontend/controllers/social_login_controller.dart';
import 'package:frontend/screens/otp_comfirm_screen.dart'; // This screen might not be needed for password login, but I'll keep the import for now
import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:frontend/services/facebook_service.dart';
import 'package:frontend/services/google_service.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final SocialLoginController socialLoginController = Get.put(
    SocialLoginController(),
  );
  // UI constants
  final Color primaryColor = Get.theme.colorScheme.primary;
  final Color _textColor = Colors.black87;
  final Color _hintColor = Colors.black45;
  final Color _borderColor = Colors.grey.shade300;
  final Color _fillColor = Colors.white;
  final double borderRadius = 16;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if AppLocalizations is available
    final localizations = AppLocalizations.of(context);
    final isLocalizationsAvailable = localizations != null;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    isLocalizationsAvailable
                        ? localizations.loginTitle
                        : 'Login to Your Account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: _textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isLocalizationsAvailable
                        ? localizations.welcomeMessage
                        : 'Welcome back! Please enter your details.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _hintColor, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  _buildTextField(
                    label:
                        isLocalizationsAvailable
                            ? localizations.email
                            : 'Email',
                    controller: controller.emailController,
                    hintText:
                        isLocalizationsAvailable
                            ? localizations.enterEmail
                            : 'Enter email address',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  _buildPasswordField(
                    label:
                        isLocalizationsAvailable
                            ? localizations.password
                            : 'Password',
                    hintText:
                        isLocalizationsAvailable
                            ? localizations.passwordhint
                            : 'Enter password',
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.isLoading.value ? null : controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                      child:
                          controller.isLoading.value
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                isLocalizationsAvailable
                                    ? localizations.btnLogin
                                    : 'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  _buildDividerWithText(
                    isLocalizationsAvailable
                        ? localizations.signInWith
                        : 'Or sign in with',
                  ),
                  const SizedBox(height: 20),
                  _buildSocialButtons(),
                  const SizedBox(height: 40),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text:
                            isLocalizationsAvailable
                                ? localizations.dontHaveAccount
                                : 'Don\'t have an account? ',
                        style: TextStyle(color: _textColor),
                        children: [
                          TextSpan(
                            text:
                                isLocalizationsAvailable
                                    ? localizations.signUp
                                    : 'Sign Up',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
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

  Widget _buildTextField({
    String? label,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label ?? '',
        filled: true,
        fillColor: _fillColor,
        hintText: hintText,
        hintStyle: TextStyle(color: _hintColor),
        prefixIcon: Icon(icon, color: primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: _borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: _borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField({String? label, required String hintText}) {
    var obscureText = true.obs;
    return Obx(
      () => TextField(
        controller: controller.passwordController,
        obscureText: obscureText.value,
        decoration: InputDecoration(
          filled: true,
          labelText: label ?? "",
          fillColor: _fillColor,
          hintText: hintText,
          hintStyle: TextStyle(color: _hintColor),
          prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText.value ? Icons.visibility_off : Icons.visibility,
              color: primaryColor,
            ),
            onPressed: () => obscureText.value = !obscureText.value,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: _borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: _borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialButton(
          'assets/images/google.webp',
          onPressed: () => GoogleService.instance.signInWithGoogle(),
        ),

        const SizedBox(width: 20),
        _socialButton(
          'assets/images/fb1.png',
           onPressed: () {
            FacebookService.instance.signInWithFacebook();
          },
        ),
      ],
    );
  }

  Widget _socialButton(String imagePath, {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: _fillColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(child: Image.asset(imagePath, width: 32, height: 32)),
      ),
    );
  }

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.black12, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(text, style: TextStyle(color: _hintColor, fontSize: 14)),
        ),
        const Expanded(child: Divider(color: Colors.black12, thickness: 1)),
      ],
    );
  }
}
