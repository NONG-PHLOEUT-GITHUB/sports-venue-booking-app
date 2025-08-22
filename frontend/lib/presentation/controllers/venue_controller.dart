import 'package:get/get.dart';
import '../../domain/entities/venue.dart';
import '../../domain/repositories/venue_repository.dart';

class VenueController extends GetxController {
  final VenueRepository repository;

  VenueController(this.repository);

  final venues = <Venue>[].obs;
  final isLoading = false.obs;

  Future<void> fetchVenues() async {
    try {
      isLoading.value = true;
      venues.value = await repository.getAllVenues();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addVenue(Venue venue) async {
    await repository.addVenue(venue);
    venues.add(venue);
  }
}
