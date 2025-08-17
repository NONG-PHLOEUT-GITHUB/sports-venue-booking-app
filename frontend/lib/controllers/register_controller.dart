import 'package:flutter/material.dart';
import 'package:frontend/screens/otp_comfirm_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  final storage = GetStorage(); // add this

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
        String token = data['access_token'];
        storage.write('access_token', token);
        Get.snackbar("Success", "Account created successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
        print("Token: ${data['access_token']}");
        Get.to(() => OtpVerificationPage(token: data['access_token']));
      } else {
        var error = json.decode(response.body);
        Get.snackbar("Something Went Wrong", error.toString(),
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Something Went Wrong", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  bool validateInputs() {
    if (usernameController.text.isEmpty) {
      Get.snackbar("Something Went Wrong", "Please enter username",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      Get.snackbar("Something Went Wrong", "Please enter valid email",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (passwordController.text.length < 6) {
      Get.snackbar("Something Went Wrong", "Password must be at least 6 characters",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    return true;
  }
}
