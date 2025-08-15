import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> register() async {
    if (!validateInputs()) return;

    isLoading.value = true;
    try {
      var url = Uri.parse("http://127.0.0.1:8000/api/auth/register");
      var response = await http.post(url, body: {
        "name": usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        Get.snackbar("Success", "Account created successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
        print("Token: ${data['access_token']}");
            Get.to(() => OtpScreen(token: data['access_token']));
      } else {
        var error = json.decode(response.body);
        Get.snackbar("Error", error.toString(),
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
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
