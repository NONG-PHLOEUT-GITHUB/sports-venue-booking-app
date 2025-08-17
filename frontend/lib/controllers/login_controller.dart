import 'package:flutter/material.dart';
import 'package:frontend/screens/layout.dart';
import 'package:frontend/screens/phone_input_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final storage = GetStorage(); // add this

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // API URL
  final String apiUrl = "http://127.0.0.1:8000/api/auth/login";

  Future<void> login() async {
    if (!validateInputs()) return;

    isLoading.value = true;
    try {
      var url = Uri.parse(apiUrl);
      var response = await http.post(url, body: {
        "email": emailController.text,
        "password": passwordController.text,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        // Success
        String token = data['access_token'];
        storage.write('access_token', token);

        Get.snackbar("Success", "Logged in successfully",
            backgroundColor: Colors.green, colorText: Colors.white);

        // Save token if needed
        // You can use GetStorage or SharedPreferences to save token

        // Get.to(() => PhoneNumberScreen()); // Navigate to Phone Number screen
        Get.offAll(() => MainLayout()); // Navigate to Phone Number screen

        // Navigate to Home or OTP screen if needed
        // Get.offAllNamed('/home'); // Replace with your Home route
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
    if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text)) {
      Get.snackbar("Error", "Please enter a valid email",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    return true;
  }
}
