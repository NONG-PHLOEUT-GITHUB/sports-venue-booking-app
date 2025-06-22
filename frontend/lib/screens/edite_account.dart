import 'package:flutter/material.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/theme/app_colors.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Color for the back button icon
        ),
        title: Text(
          AppLocalizations.of(context)!.editAccount,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.onSecondary,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField('Name', 'Charlotte King'),
                  _buildTextField(
                      'Email address', 'johnkinggraphics@gmail.com'),
                  _buildTextField('Password', '**********', isPassword: true),
                  _buildTextField('Phone number', '+91 6895312'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: ElevatedButton(
              onPressed: () {
                // Confirm booking logic
                // Navigator.push(
                //   context
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.btnSave,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: isPassword ? const Icon(Icons.visibility) : null,
        ),
      ),
    );
  }
}
