import 'package:flutter/material.dart';
import 'package:frontend/controllers/change_password_controller.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final controller = Get.put(ChangePasswordController());

  final double borderRadius = 12.0;
  final Color _inputFillColor = Colors.grey.shade100;
  final Color _borderColor = Colors.grey.shade400;
  final Color primaryColor = Get.theme.colorScheme.primary;
  final Color _hintColor = Colors.grey;

  Widget _buildPasswordField({
    required TextEditingController controllerField,
    required RxBool obscureText,
    required String hintText,
  }) {
    return Obx(
      () => TextFormField(
        controller: controllerField,
        obscureText: obscureText.value,
        decoration: InputDecoration(
          filled: true,
          fillColor: _inputFillColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Column(
            children: [
              _buildPasswordField(
                controllerField: controller.currentPasswordController,
                obscureText: controller.isCurrentObscure,
                hintText: "Current Password",
              ),
              const SizedBox(height: 16),
              _buildPasswordField(
                controllerField: controller.newPasswordController,
                obscureText: controller.isNewObscure,
                hintText: "New Password",
              ),
              const SizedBox(height: 16),
              _buildPasswordField(
                controllerField: controller.confirmPasswordController,
                obscureText: controller.isConfirmObscure,
                hintText: "Confirm Password",
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Save",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
