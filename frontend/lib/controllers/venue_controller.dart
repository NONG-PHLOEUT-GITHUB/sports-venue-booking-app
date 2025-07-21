import 'package:get/get.dart';
import '../models/venue_model.dart';
import '../api/api_config.dart';

class VenueListController extends GetxController {
  final ApiService api = ApiService();

  var venues = <VenueModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVenues();
  }

  Future<void> fetchVenues() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final fetchedVenues = await api.getRequest('/venues');
      venues.assignAll(fetchedVenues); // Already parsed
      print("Fetched venues:");
      for (var venue in fetchedVenues) {
        print(
          "Name: ${venue.name}, Location: ${venue.location}, Image: ${venue.imageUrl}",
        );
      }
    } catch (e) {
      errorMessage.value = 'Failed to load venues: $e';
      print(e); // For debugging
    } finally {
      isLoading.value = false;
    }
  }
}

// import 'package:frontend/api/api_config.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart' as dio;

// class VenueListController extends GetxController {
//   var venues = [].obs;
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     ApiService.initInterceptors();
//     fetchVenues();
//   }

//   void fetchVenues() async {
//     try {
//       isLoading.value = true;
//       final dio.Response response = await ApiService.get('/venues');
//       venues.value = response.data['data'];
//        print("Fetched venues count: ${venues.length}");
//       for (var v in venues) {
//         print("${v.name} - ${v.location} - ${v.imageUrl}");
//       }
//     } catch (e) {
//       print('Error fetching venues: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
