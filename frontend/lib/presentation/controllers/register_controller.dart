import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/layout.dart';
import 'package:frontend/presentation/screens/otp_comfirm_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  final storage = GetStorage();

  Future<void> register() async {
    if (!validateInputs()) return;

    isLoading.value = true;
    try {
      // 🔹 Firebase registration
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        // get firebase token
        String? token = await user.getIdToken();

        if (token != null) {
          storage.write('access_token', token);
          print("Firebase Token: $token");
        }

        Get.snackbar("Success", "Account created successfully",
            backgroundColor: Colors.green, colorText: Colors.white);

        // go to OTP screen
        Get.offAll(() => MainLayout());
        // Get.to(() => OtpVerificationPage(token: token ?? ""));
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Something Went Wrong", e.message ?? "Auth error",
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Something Went Wrong", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  bool validateInputs() {
    if (usernameController.text.isEmpty) {
      Get.snackbar("Error", "Please enter username",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      Get.snackbar("Error", "Please enter valid email",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (passwordController.text.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    return true;
  }
}
