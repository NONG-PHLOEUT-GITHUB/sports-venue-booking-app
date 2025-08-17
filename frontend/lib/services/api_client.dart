import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ApiClient {
  final String baseUrl = "http://127.0.0.1:8000/api"; // your backend URL
  final storage = GetStorage();

  /// Get token dynamically
  String? get token => storage.read('access_token');

  /// Common headers
  Map<String, String> get _headers {
    if (token == null) {
      throw Exception("No access token found");
    }
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  /// GET request
  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers,
    );
    return _processResponse(response);
  }

  /// POST request
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  /// PUT request
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  /// DELETE request
  Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers,
    );
    return _processResponse(response);
  }

  /// Handle response
  Map<String, dynamic> _processResponse(http.Response response) {
    final decoded = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded is Map<String, dynamic> ? decoded : {"data": decoded};
    } else {
      throw Exception(decoded['message'] ?? "Error: ${response.statusCode}");
    }
  }
}
