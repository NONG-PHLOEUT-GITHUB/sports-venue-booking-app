import '../entities/venue.dart';

abstract class VenueRepository {
  Future<List<Venue>> getAllVenues();
  Future<void> addVenue(Venue venue);
}
