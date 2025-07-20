import 'package:frontend/models/venue_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _baseUrl = 'http://127.0.0.1:800/api';

  static Future<List<VenueModel>> fetchVenues() async {
    final response = await http.get(Uri.parse('$_baseUrl/venues'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => VenueModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}


