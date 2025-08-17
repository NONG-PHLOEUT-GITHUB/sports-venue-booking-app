import 'package:flutter/material.dart';
import 'package:frontend/services/change_password_service.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final service = Get.put(ChangePasswordService());

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isCurrentObscure = true.obs;
  var isNewObscure = true.obs;
  var isConfirmObscure = true.obs;

  var isLoading = false.obs;

  void changePassword() async {
    final current = currentPasswordController.text;
    final newPass = newPasswordController.text;
    final confirm = confirmPasswordController.text;
  print("Current: '$current', New: '$newPass', Confirm: '$confirm'");
    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    if (newPass != confirm) {
      print("New password and confirm password do not match");
      Get.snackbar("Error", "New password and confirm password do not match");
      return;
    }

    try {
      isLoading.value = true;
      await service.changePassword(
        currentPassword: current,
        newPassword: newPass,
        confirmPassword: confirm,
      );
      Get.snackbar("Success", "Password changed successfully");
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
