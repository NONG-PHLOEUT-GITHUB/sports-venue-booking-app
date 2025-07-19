import 'package:flutter/material.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = 'Charlotte King';
    _emailController.text = 'johnkinggraphics@gmail.com';
    _passwordController.text = '**********';
    _phoneController.text = '+91 6895312';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Saving profile...')));

    await Future.delayed(const Duration(seconds: 2));

    // Normally send data to backend here
    print('Name: ${_nameController.text}');
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
    print('Phone: ${_phoneController.text}');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    final saveButton = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: Get.theme.colorScheme.primary,
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
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(localization.editAccount),
      ),

      body: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.jpeg'),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 20,
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Get.theme.colorScheme.background,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildTextField(
                    label: localization.name,
                    hint: localization.name,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: localization.email,
                    hint: localization.enterEmail,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: localization.password,
                    hint: '**********',
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: localization.phoneNumber,
                    hint: localization.enterPhoneNumber,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),
          bottomContainer,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword && !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // More rounded corners
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.primary,
            width: 2,
          ), // Primary color on focus
        ), // White fill for text fields
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Get.theme.colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
                : null,
      ),
    );
  }
}
