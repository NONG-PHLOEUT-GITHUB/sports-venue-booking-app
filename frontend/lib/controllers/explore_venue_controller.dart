// lib/controllers/venue_controller.dart
import 'package:get/get.dart';
import 'package:frontend/models/explore_venue_model.dart';
import 'package:frontend/services/venue_service.dart';

class ExploreVenueController extends GetxController {
  final VenueService _venueService = Get.find<VenueService>(); // GetX finds the service
  var venues = <ExploreVenueModel>[].obs;
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
      final fetchedVenues = await _venueService.fetchVenues();
      venues.assignAll(fetchedVenues); // Assign all new venues
      print(fetchedVenues);
    } catch (e) {
      errorMessage.value = 'Failed to load venues: $e';
      print(e); // For debugging
    } finally {
      isLoading.value = false;
    }
  }
}