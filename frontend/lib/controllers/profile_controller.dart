import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class ProfileController extends GetxController {
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

  /// Fetch profile from Firebase
  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        userData.value = {
          "name": user.displayName,
          "email": user.email,
          "phone": user.phoneNumber,
          "photoUrl": user.photoURL,
          "uid": user.uid,
        };

        nameController.text = user.displayName ?? '';
        emailController.text = user.email ?? '';
        phoneController.text = user.phoneNumber ?? '';
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
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // 1. Reauthenticate the user (required for sensitive operations)
        final cred = EmailAuthProvider.credential(
          email: user.email!,
          password:
              passwordController.text.trim(), // Ask user for current password
        );
        await user.reauthenticateWithCredential(cred);

        // 2. Send verification for the new email
        if (emailController.text.isNotEmpty &&
            emailController.text != user.email) {
          await user.verifyBeforeUpdateEmail(emailController.text.trim());
          // User will need to verify their new email via the sent link
        }

        // 3. Optionally update display name
        if (nameController.text.isNotEmpty) {
          await user.updateDisplayName(nameController.text.trim());
        }

        // 4. Update password if provided
        if (passwordController.text.length >= 6) {
          await user.updatePassword(passwordController.text.trim());
        }

        await user.reload();
        fetchProfile();

        Get.snackbar(
          "Success",
          "Profile update in progress—please verify email if changed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
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

  /// Logout (all providers)
  Future<void> logout() async {
    try {
      //  Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      //  Sign out from Google
      await GoogleSignIn().signOut();

      //  Sign out from Facebook
      await FacebookAuth.instance.logOut();

      // Clear local storage if using GetStorage
      final storage = GetStorage();
      await storage.erase(); // clear all saved tokens or user info

      //  Navigate to login
      Get.offAll(() => LoginScreen());
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      fetchProfile();
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Sign in with Facebook
  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken!.token,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        fetchProfile();
      } else {
        Get.snackbar(
          "Error",
          result.message ?? "Facebook login failed",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
