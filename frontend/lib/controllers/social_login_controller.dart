import 'package:frontend/screens/layout.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SocialLoginController extends GetxController {
  var isLoading = false.obs;
  final String apiUrl = "http://localhost:8000/api/auth/social-login";
  final storage = GetStorage();

  Future<void> googleSignIn() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        isLoading.value = false;
        return; // user cancelled
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      // Send token to Laravel API
      var response = await http.post(Uri.parse(apiUrl),
          body: {"provider": "google", "id_token": idToken});

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        storage.write('access_token', data['access_token']);
        Get.snackbar("Success", "Logged in successfully");
        Get.offAll(() => MainLayout());
      } else {
        Get.snackbar("Error", response.body);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
