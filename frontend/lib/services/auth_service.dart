import 'package:dio/dio.dart';

class AuthService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: "http://127.0.0.1:8000/api"));

  static Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    try {
      var response = await _dio.post("/register", data: {
        "name": name,
        "email": email,
        "password": password,
      });
      return response.data;
    } on DioError catch (e) {
      return {
        "success": false,
        "message": e.response?.data["message"] ?? "Error occurred"
      };
    }
  }
}
