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
