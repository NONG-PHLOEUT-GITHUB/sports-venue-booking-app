import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart';
import 'package:frontend/screens/login_screen.dart'; // Import your LoginPage

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  // Controllers for text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _usernameError;
  String? _emailError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFFE6F4EA); // Light green background

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),

                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Create your new account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 36),

                // Full Name Field
                buildTextField(
                  controller: _usernameController,
                  hintText: 'User Name',
                  icon: Icons.person,
                  errorText: _usernameError,
                ),

                const SizedBox(height: 16),

                // Email Field
                buildTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                  errorText: _emailError,
                ),

                const SizedBox(height: 16),

                // Password Field
                buildPasswordField(),

                const SizedBox(height: 16),

                // Register Button
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
                      _validateInputs();
                      if (_formKey.currentState!.validate()) {
                        // Process the registration if the form is valid
                      }
                    },
                    child: const Text(
                      'Register',
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

                // Already have an account?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
                        );
                      },
                      child: const Text(
                        'Login',
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
          if (hintText == 'User Name') _usernameError = null;
          if (hintText == 'Email') _emailError = null;
        });
      },
    );
  }

  Widget buildPasswordField() {
    bool obscureText = true; // Initial state for password visibility

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          controller: _passwordController,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF9F9F9),
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock, color: AppColors.primary),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: AppColors.primary,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText; // Toggle password visibility
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _passwordError = null; // Clear password error on change
            });
          },
        );
      },
    );
  }

  void _validateInputs() {
    setState(() {
      // Validate username
      if (_usernameController.text.isEmpty) {
        _usernameError = 'Please enter your username';
      } else {
        _usernameError = null;
      }

      // Validate email
      if (_emailController.text.isEmpty) {
        _emailError = 'Please enter your email';
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text)) {
        _emailError = 'Please enter a valid email';
      } else {
        _emailError = null;
      }

      // Validate password
      if (_passwordController.text.isEmpty) {
        _passwordError = 'Please enter your password';
      } else if (_passwordController.text.length < 6) {
        _passwordError = 'Password must be at least 6 characters';
      } else {
        _passwordError = null;
      }
    });
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