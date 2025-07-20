// import 'package:dio/dio.dart';

// class ApiService {
//   static final ApiService _instance = ApiService._internal();
//   late Dio dio;

//   factory ApiService() {
//     return _instance;
//   }

//   ApiService._internal() {
//     // Base options for all requests
//     BaseOptions options = BaseOptions(
//       baseUrl: "http://10.0.2.2:8000/api", // Update with your API URL
//       connectTimeout: const Duration(seconds: 10), // <-- use Duration here
//       receiveTimeout: const Duration(seconds: 10), // <-- and here
//       headers: {"Content-Type": "application/json"},
//     );

//     dio = Dio(options);

//     // Add interceptors for request and response
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           // Example: Add an Authorization token to every request (replace with actual token retrieval)
//           options.headers['Authorization'] = "Bearer your_token";
//           print("Request: ${options.method} ${options.uri}");
//           return handler.next(options); // Proceed with the request
//         },
//         onResponse: (response, handler) {
//           print("Response: ${response.statusCode} ${response.data}");
//           return handler.next(response); // Proceed with the response
//         },
//         onError: (DioError e, handler) {
//           print("Error: ${e.response?.statusCode} ${e.message}");
//           return handler.next(e); // Proceed with the error
//         },
//       ),
//     );
//   }

//   // Example generic GET request
//   Future<Response> getRequest(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//   }) {
//     return dio.get(path, queryParameters: queryParameters);
//   }

//   // Example generic POST request
//   Future<Response> postRequest(String path, Map<String, dynamic> data) {
//     return dio.post(path, data: data);
//   }

//   // Add PUT, DELETE, PATCH methods as needed

//   // Provide access to the Dio client directly if needed
//   Dio get client => dio;
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/venue_model.dart'; // Make sure filename matches

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api'; // Replace with your actual base URL

  Future<List<VenueModel>> getRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((json) => VenueModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load venues: ${response.statusCode}');
    }
  }
}
