import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/services/profile_service.dart';
import 'package:frontend/screens/login_screen.dart';

class ProfileController extends GetxController {
  final ProfileService _service = Get.put(ProfileService());

  // State
  var isLoading = false.obs;
  var userData = {}.obs;

  // Form controllers (for Edit Profile page)
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final data = await _service.fetchProfile();
      userData.value = data;

      // Pre-fill form fields
      if (data.isNotEmpty) {
        print("database user data: $data");
        userData.value = data;
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phone'] ?? '';
      } else {
        // 2️⃣ Fallback: get Firebase user info
        final user = FirebaseAuth.instance.currentUser;
        print("Firebase user data: $user");

        if (user != null) {
          userData.value = {
            "name": user.displayName,
            "email": user.email,
            "photoUrl": user.photoURL,
            "uid": user.uid,
          };

          nameController.text = user.displayName ?? '';
          emailController.text = user.email ?? '';
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveProfile() async {
    isLoading.value = true;
    try {
      final result = await _service.updateProfile(
        name: nameController.text,
        email: emailController.text,
        // phone: phoneController.text,
        password:
            passwordController.text.isNotEmpty ? passwordController.text : null,
      );

      userData.value = result['user']; // Update local state

      Get.snackbar(
        "Success",
        result['message'] ?? "Profile updated",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _service.logout();
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => LoginScreen());
  }
}
