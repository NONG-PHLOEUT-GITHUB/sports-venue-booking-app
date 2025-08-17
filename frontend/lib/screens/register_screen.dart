import 'package:flutter/material.dart';
import 'package:frontend/controllers/register_controller.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final RegisterController controller = Get.put(RegisterController());

  // Error strings
  String? _usernameError;
  String? _emailError;


  // UI constants
  final double borderRadius = 16;
  final double _fieldSpacing = 20;
  final EdgeInsets _formPadding = const EdgeInsets.symmetric(horizontal: 24);

  // Colors
  late final Color primaryColor = Get.theme.colorScheme.primary;
  final Color _inputFillColor = Colors.white;
  final Color _textColor = Colors.black87;
  final Color _hintColor = Colors.black45;
  final Color _dividerColor = Colors.black12;
  final Color _borderColor = Colors.grey.shade300;

  // Text styles
  late final TextStyle _titleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: _textColor,
  );

  late final TextStyle _subtitleStyle = TextStyle(
    fontSize: 16,
    color: _hintColor,
  );

  late final TextStyle _linkStyle = TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.underline,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: _formPadding,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Create an Account',
                      style: _titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Join our community and get started!',
                      style: _subtitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    _buildTextField(
                      controller: controller.usernameController,
                      hintText: 'User Name',
                      icon: Icons.person_outline,
                      errorText: _usernameError,
                    ),
                    SizedBox(height: _fieldSpacing),

                    _buildTextField(
                      controller: controller.emailController,
                      hintText: 'Email',
                      icon: Icons.email_outlined,
                      errorText: _emailError,
                    ),
                    SizedBox(height: _fieldSpacing),

                    _buildPasswordField(),
                    SizedBox(height: _fieldSpacing + 10),

                    Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          elevation: 5,
                        ),
                        onPressed:
                            controller.isLoading.value
                                ? null
                                : () => controller.register(),
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
                                : const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: _dividerColor, thickness: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Or register with',
                            style: TextStyle(color: _hintColor, fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: _dividerColor, thickness: 1),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          'assets/images/google.webp',
                          onPressed: () => print("Google Sign Up"),
                        ),
                        const SizedBox(width: 20),
                        _buildSocialButton(
                          'assets/images/fb1.png',
                          onPressed: () => print("Facebook Sign Up"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: _textColor),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text('Login', style: _linkStyle),
                        ),
                      ],
                    ),
                  ],
                ),
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
    String? errorText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: _inputFillColor,
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

  Widget _buildPasswordField() {
    var obscureText = true.obs;
    return Obx(
      () => TextField(
        controller: controller.passwordController,
        obscureText: obscureText.value,
        decoration: InputDecoration(
          filled: true,
          fillColor: _inputFillColor,
          hintText: "Password",
          hintStyle: TextStyle(color: _hintColor),
          prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility,
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


  Widget _buildSocialButton(String imagePath, {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: _inputFillColor,
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
}
