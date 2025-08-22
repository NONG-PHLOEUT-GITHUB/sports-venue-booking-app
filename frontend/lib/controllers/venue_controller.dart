import 'package:get/get.dart';
import '../models/venue_model.dart';
import '../core//services/api_service.dart';

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

      final fetchedVenues = await api.get('/venues');
      venues.assignAll(fetchedVenues);
    
    } catch (e) {
      errorMessage.value = 'Failed to load venues: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
