import 'api_client.dart';

class ProfileService {
  final ApiClient api = ApiClient();

  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String email,
    // required String phone,
    String? password,
  }) async {
    return await api.put("/auth/profile", {
      "name": name,
      "email": email,
      // "phone": phone,
      "password": password,
    });
  }

  Future<Map<String, dynamic>> fetchProfile() async {
    return await api.get("/auth/me");
  }

  Future<void> logout() async {
    api.storage.remove("access_token");
  }
}
