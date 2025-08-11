import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart'; // Import your LoginPage
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Error strings
  String? _usernameError;
  String? _emailError;
  String? _passwordError;

  // UI constants
  final Color _inputFillColor = const Color(0xFFF9F9F9);
  final double _borderRadius = 12;
  final EdgeInsets _formPadding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
  final double _fieldSpacing = 16;
  final TextStyle _titleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Get.theme.colorScheme.surface,
  );
  final TextStyle _subtitleStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black54,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.theme.colorScheme.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: _formPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Text('Register', style: _titleStyle),
                const SizedBox(height: 8),
                Text('Create your new account', style: _subtitleStyle),
                const SizedBox(height: 36),
                buildTextField(
                  controller: _usernameController,
                  hintText: 'User Name',
                  icon: Icons.person,
                  errorText: _usernameError,
                ),
                SizedBox(height: _fieldSpacing),
                buildTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                  errorText: _emailError,
                ),
                SizedBox(height: _fieldSpacing),
                buildPasswordField(),
                SizedBox(height: _fieldSpacing),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_borderRadius),
                      ),
                    ),
                    onPressed: () {
                      _validateInputs();
                      if (_formKey.currentState!.validate()) {
                        // TODO: handle valid form submission
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    socialButton('assets/images/fb1.png', onPressed: () => print("Facebook Sign Up")),
                    socialButton('assets/images/google.webp', onPressed: () => print("Google Sign Up")),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Get.theme.colorScheme.surface,
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
        fillColor: _inputFillColor,
        hintText: hintText,
        prefixIcon: Icon(icon, color:Get.theme.colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        errorText: errorText,
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
    bool obscureText = true;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          controller: _passwordController,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: _inputFillColor,
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock, color: Get.theme.colorScheme.primary),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: Get.theme.colorScheme.primary,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_borderRadius),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            errorText: _passwordError,
          ),
          onChanged: (value) {
            setState(() {
              _passwordError = null;
            });
          },
        );
      },
    );
  }

  void _validateInputs() {
    setState(() {
      _usernameError = _usernameController.text.isEmpty ? 'Please enter your username' : null;

      if (_emailController.text.isEmpty) {
        _emailError = 'Please enter your email';
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text)) {
        _emailError = 'Please enter a valid email';
      } else {
        _emailError = null;
      }

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
          borderRadius: BorderRadius.circular(_borderRadius),
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
