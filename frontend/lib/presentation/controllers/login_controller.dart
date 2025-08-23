import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/layout.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final storage = GetStorage();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (!validateInputs()) return;

    isLoading.value = true;
    try {
      /// ✅ Firebase login
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        // Save token (Firebase returns an ID token)
        String? token = await user.getIdToken();
        if (token != null) {
          storage.write('access_token', token);
        }

        Get.snackbar(
          "Success",
          "Logged in successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAll(() => MainLayout());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "Login failed",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool validateInputs() {
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        "Error",
        "Please enter a valid email",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      Get.snackbar(
        "Error",
        "Password must be at least 6 characters",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }
}
