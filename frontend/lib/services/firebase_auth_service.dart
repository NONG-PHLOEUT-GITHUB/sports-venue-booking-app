import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/layout.dart';
import 'package:frontend/presentation/screens/login_screen.dart';
import 'package:get/get.dart';

class FirebaseAuthService {
  static FirebaseAuthService _instance = FirebaseAuthService._init();

  static FirebaseAuthService get instance => _instance;

  FirebaseAuthService._init();

  Future<void> signInFirebaseWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((UserCredential user) {
          print("User : $user");
          Get.offAll(MainLayout());
        })
        .catchError((error) {
          print("Error catchError : $error");
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: error.toString(),
              icon: const Icon(Icons.refresh),
              duration: const Duration(seconds: 3),
            ),
          );
        });
  }

  Future<void> createUserFirebaseWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((UserCredential user) {
          print("User : $user");
          Get.offAll(LoginScreen());
        })
        .catchError((error) {
          print("Error catchError : $error");
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: error.toString(),
              icon: const Icon(Icons.refresh),
              duration: const Duration(seconds: 3),
            ),
          );
        });
  }

  Future<void> signOutFromFacebook() async {
    await FirebaseAuth.instance.signOut();
  }
}
