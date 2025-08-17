import 'package:frontend/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var userData = {}.obs;

  final String apiUrl = "http://127.0.0.1:8000/api/auth/me";

  final storage = GetStorage(); // for storing JWT token

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void logout() {
    storage.remove('access_token'); // remove JWT token
    Get.to(() => LoginScreen()); // Navigate to login or home page
  }

  Future<void> fetchProfile() async {
    final token = storage.read('access_token'); // Retrieve JWT token
    if (token == null) {
      Get.snackbar("Error", "Token not found");
      return;
    }

    isLoading.value = true;
    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        userData.value = json.decode(response.body);
        Get.snackbar("Error", "successfully fetched profile");
      } else {
        Get.snackbar("Error", "Failed to fetch profile");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
