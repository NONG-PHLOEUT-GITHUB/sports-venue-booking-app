import 'package:flutter/material.dart';
import 'package:frontend/controllers/locale_controller.dart';
import 'package:frontend/screens/otp_comfirm_screen.dart'; // This screen might not be needed for password login, but I'll keep the import for now
import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // UI constants
  final Color _primaryColor = const Color(0xFF6200EE);
  final Color _textColor = Colors.black87;
  final Color _hintColor = Colors.black45;
  final Color _borderColor = Colors.grey.shade300;
  final Color _fillColor = Colors.white;
  final double _borderRadius = 16;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                    controller: _emailController,
                    hintText:
                        isLocalizationsAvailable
                            ? localizations.enterEmail
                            : 'Enter email address',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  _buildPasswordField(),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => OtpVerificationPage(),
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_borderRadius),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
                              color: _primaryColor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => RegisterScreen(),
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
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: _fillColor,
        hintText: hintText,
        hintStyle: TextStyle(color: _hintColor),
        prefixIcon: Icon(icon, color: _primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: _borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: _borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: _primaryColor, width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: _fillColor,
        hintText: 'Enter password',
        hintStyle: TextStyle(color: _hintColor),
        prefixIcon: Icon(Icons.lock_outline, color: _primaryColor),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility,
            color: _primaryColor,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: _borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: _borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: _primaryColor, width: 2),
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
          onPressed: () => print("Google Login"),
        ),
        const SizedBox(width: 20),
        _socialButton(
          'assets/images/fb1.png',
          onPressed: () => print("Facebook Login"),
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
          borderRadius: BorderRadius.circular(_borderRadius),
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
