import 'package:dio/dio.dart';
import '../api/api_config.dart';

class ApiProvider {
  final ApiService apiService = ApiService();

  Future<List<dynamic>> fetchFields() async {
    try {
      // Use the Dio instance from ApiService
      Response response = await apiService.client.get('/fields');
      return response.data as List<dynamic>;
    } catch (e) {
      print("Error fetching fields: $e");
      rethrow; // Propagate the error for higher-level handling
    }
  }
}
