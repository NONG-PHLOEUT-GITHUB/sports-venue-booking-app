import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/venue_model.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<VenueModel>> getRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final List<dynamic> jsonList = json['data']; // <- Laravel response
      return jsonList.map((item) => VenueModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load venues: ${response.statusCode}');
    }
  }
}

// import 'package:dio/dio.dart' as dio;
// import 'package:frontend/controllers/loading_controller.dart';
// import 'package:get/get.dart';

// class ApiService {
//   static final dio.Dio _dio = dio.Dio(
//     dio.BaseOptions(
//       baseUrl: 'http://127.0.0.1:8001/api',
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     ),
//   );

//   static void initInterceptors() {
//     _dio.interceptors.add(
//       dio.InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           // Add token
//           // final token = await _getToken(); // simulate a local storage fetch
//           // if (token != null) {
//           //   options.headers['Authorization'] = 'Bearer $token';
//           // }

//           // Simulate loading start (if using GetX)
//           Get.find<LoadingController>().setLoading(true);

//           return handler.next(options);
//         },
//         onResponse: (response, handler) {
//           Get.find<LoadingController>().setLoading(false);
//           return handler.next(response);
//         },
//         onError: (error, handler) {
//           Get.find<LoadingController>().setLoading(false);

//           // if (error.response?.statusCode == 401 &&
//           //     error.response?.data['message'] == 'Unauthenticated') {
//           //   Get.find<AuthController>().setTokenExpired(true);
//           // }

//           return handler.next(error);
//         },
//       ),
//     );
//   }

//   static Future<String?> _getToken() async {
//     // Simulate token from storage or secure storage
//     return 'your-token-here';
//   }

//   static Future<dio.Response> get(String endpoint) async {
//     return await _dio.get(endpoint);
//   }

//   static Future<dio.Response> post(String endpoint, dynamic data) async {
//     return await _dio.post(endpoint, data: data);
//   }

//   static Future<dio.Response> put(String endpoint, dynamic data) async {
//     return await _dio.put(endpoint, data: data);
//   }

//   static Future<dio.Response> delete(String endpoint) async {
//     return await _dio.delete(endpoint);
//   }
// }
