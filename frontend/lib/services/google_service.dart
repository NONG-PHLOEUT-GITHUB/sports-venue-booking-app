import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/screens/layout.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  static GoogleService _instance = GoogleService._init();

  static GoogleService get instance => _instance;

  GoogleService._init();

  Future<void> signInWithGoogle() async {
    // SignIn Google
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // SignIn Auth
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // SignIn Firebase
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    if (userCredential.user != null) {
      Get.offAll(MainLayout());
    }
  }

  Future<bool> isGoogleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    return googleAuth?.accessToken != null;
  }

  Future<void> signOutFromGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}


// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:frontend/screens/layout.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;

// class GoogleService {
//   static GoogleService _instance = GoogleService._init();
//   static GoogleService get instance => _instance;
//   GoogleService._init();

//   final storage = GetStorage();
//   final baseUrl = "http://127.0.0.1:8000/api";

//   /// Sign in with Google and get Laravel JWT
//   Future<void> signInWithGoogle() async {
//     // 1️⃣ Google Sign-In
//     final googleUser = await GoogleSignIn().signIn();
//     if (googleUser == null) return; // user cancelled

//     final googleAuth = await googleUser.authentication;
//     final idToken = googleAuth.idToken;

//     if (idToken == null) {
//       Get.snackbar("Error", "Google ID token not found");
//       return;
//     }

//     // 2️⃣ Send ID token to Laravel backend
//     final response = await http.post(
//       Uri.parse("$baseUrl/auth/social-login"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "id_token": idToken,
//         "name": googleUser.displayName,
//         "email": googleUser.email,
//         "photo": googleUser.photoUrl,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       // 3️⃣ Store JWT & user info
//       await storage.write("access_token", data['access_token']);
//       await storage.write("user", data['user']);

//       // 4️⃣ Navigate to main layout
//       Get.offAll(() => MainLayout());
//     } else {
//       final error = jsonDecode(response.body);
//       Get.snackbar("Login Error", error['error'] ?? "Unknown error");
//     }
//   }

//   /// Check if user is signed in
//   Future<bool> isSignedIn() async {
//     final user = FirebaseAuth.instance.currentUser;
//     return user != null || storage.read("access_token") != null;
//   }

//   /// Sign out
//   Future<void> signOut() async {
//     await GoogleSignIn().signOut();
//     await FirebaseAuth.instance.signOut();
//     await storage.remove("access_token");
//     await storage.remove("user");
//   }
// }
