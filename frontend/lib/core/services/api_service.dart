import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = 'http://127.0.0.1:8000/api';

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("GET $endpoint failed: ${response.statusCode}");
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("POST $endpoint failed: ${response.statusCode}");
    }
  }
}
