import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isCurrentObscure = true.obs;
  var isNewObscure = true.obs;
  var isConfirmObscure = true.obs;
  var isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> changePassword() async {
    final current = currentPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    print("Current: '$current', New: '$newPass', Confirm: '$confirm'");

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    if (newPass != confirm) {
      Get.snackbar("Error", "New password and confirm password do not match");
      return;
    }

    try {
      isLoading.value = true;
      User? user = _auth.currentUser;

      if (user == null) {
        throw Exception("No user logged in");
      }

      // 🔹 Reauthenticate the user with current password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: current,
      );
      await user.reauthenticateWithCredential(credential);

      // 🔹 Update the password
      await user.updatePassword(newPass);

      Get.snackbar(
        "Success",
        "Password changed successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Get.snackbar("Error", "Current password is incorrect");
      } else if (e.code == 'weak-password') {
        Get.snackbar("Error", "Password is too weak");
      } else {
        Get.snackbar("Error", e.message ?? "Something went wrong");
      }
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
