import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart';
import 'package:frontend/screens/otp_comfirm_screen.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _usernameError;
  String? _passwordError;
  bool _obscurePassword = true; // For toggling password visibility
  bool _rememberMe = false; // For Remember Me checkbox

  bool _isEmailValid(String email) {
    // Simple email regex validation
    return RegExp(
      r'^[^@]+@[^@]+\.[^@]+',
    ).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFFEFF1F7); // Light green background

    return Scaffold(
      backgroundColor: backgroundColor, // Set the background color
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Login to your account',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 36),

              // Username Field
              buildTextField(
                controller: _usernameController,
                hintText: 'Email',
                icon: Icons.person,
                errorText: _usernameError,
              ),
              const SizedBox(height: 16),

              // Password Field
              buildPasswordField(),
              const SizedBox(height: 16),

              // Remember Me Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                        side: BorderSide(color: Colors.black54),
                      ),
                      const Text(
                        'Remember Me',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle forgot password action
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Implement login logic here
                    if (_usernameController.text.isEmpty) {
                      setState(() {
                        _usernameError = 'Please enter your email.';
                      });
                    } else if (!_isEmailValid(_usernameController.text)) {
                      setState(() {
                        _usernameError = 'Please enter a valid email.';
                      });
                    } else if (_passwordController.text.isEmpty) {
                      setState(() {
                        _passwordError = 'Please enter your password.';
                      });
                    } else {
                      // Navigate to OTP verification
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OtpVerificationPage(),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Divider with text
              Row(
                children: [
                  const Expanded(child: Divider()),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),

              // Social Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  socialButton('assets/images/fb1.png', onPressed: () => print("Facebook Sign Up")),
                  socialButton('assets/images/google.webp', onPressed: () => print("Google Sign Up")),
                ],
              ),
              const SizedBox(height: 28),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()), // Navigate to RegisterScreen
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    String? errorText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF9F9F9),
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        errorText: errorText, // Show error text if any
      ),
      onChanged: (value) {
        setState(() {
          _usernameError = null; // Clear error on change
        });
      },
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF9F9F9),
        hintText: 'Password',
        prefixIcon: Icon(Icons.lock, color: AppColors.primary),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: AppColors.primary,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword; // Toggle password visibility
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        errorText: _passwordError, // Show error text if any
      ),
      onChanged: (value) {
        setState(() {
          _passwordError = null; // Clear error on change
        });
      },
    );
  }

  Widget socialButton(String imagePath, {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Image.asset(
          imagePath,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}