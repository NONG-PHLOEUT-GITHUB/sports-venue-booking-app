import 'package:flutter/material.dart';
import 'package:frontend/controllers/profile_controller.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/widgets/app_primary_button.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(localization.editProfile),
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
                    controller: controller.nameController,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: localization.email,
                    hint: localization.enterEmail,
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),
                  _buildTextField(
                    label: localization.phoneNumber,
                    hint: localization.enterPhoneNumber,
                    controller: controller.passwordController,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),
          AppPrimaryButton(
            text: AppLocalizations.of(context)!.btnSave,
            onPressed: controller.saveProfile,
          ),
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
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
