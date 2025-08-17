import 'package:frontend/services/api_client.dart';
import 'package:get/get.dart';

class ChangePasswordService extends GetxService {
  final ApiClient api = ApiClient();

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
   return await api.put("/auth/change-password", {
      "current_password": currentPassword,
      "password": newPassword,
      "password_confirmation": confirmPassword,
    });
  }
}
