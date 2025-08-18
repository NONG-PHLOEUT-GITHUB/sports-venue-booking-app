import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:frontend/screens/layout.dart';
import 'package:get/get.dart';

class FacebookService {
  static FacebookService _instance = FacebookService._init();

  static FacebookService get instance => _instance;

  FacebookService._init();

 Future<void> signInWithFacebook() async {
  print("🔹 Starting Facebook Sign-In...");

  try {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],
      loginBehavior: LoginBehavior.nativeWithFallback,
    );

    print("📌 Facebook login result: ${result.status}");
    print("📌 Access token: ${result.accessToken?.token}");
    print("📌 Access token expires: ${result.accessToken?.expires}");
    print("📌 User ID: ${result.accessToken?.userId}");

    if (result.status == LoginStatus.success) {
      print("✅ Facebook login successful. Creating Firebase credential...");

      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      print("📌 Firebase sign-in complete. User: ${userCredential.user}");

      if (userCredential.user != null) {
        print("✅ Firebase user created. Fetching Facebook user data...");
        Map<String, dynamic> userData = await _getUserData();
        print("📌 Facebook user data: $userData");

        String photoURL = userData['picture']['data']['url'];
        print("📌 Updating photo URL: $photoURL");

        await userCredential.user!.updatePhotoURL(photoURL);

        print("✅ Sign-in flow complete. Redirecting to MainLayout...");
        Get.offAll(MainLayout());
      } else {
        print("❌ Firebase user is null after sign-in!");
        Get.snackbar("Error", "Something went wrong");
      }
    } else if (result.status == LoginStatus.cancelled) {
      print("⚠️ Facebook login cancelled by user.");
      Get.snackbar("Error", "Login cancelled");
    } else {
      print("❌ Facebook login failed. Status: ${result.status}");
      Get.snackbar("Error", "Something went wrong");
    }
  } catch (e, stack) {
    print("🔥 Exception during Facebook Sign-In: $e");
    print("🔥 Stack trace: $stack");
    Get.snackbar("Error", "Login failed: $e");
  }
}


  Future<void> signOutFromFacebook() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> isFacebookLoggedIn() async {
    final token = await FacebookAuth.instance.accessToken;
    return token != null;
  }

  Future<Map<String, dynamic>> _getUserData() async {
    final userData = await FacebookAuth.instance.getUserData(
      fields: "email,name,picture.width(200)",
    );
    return userData;
  }
}
