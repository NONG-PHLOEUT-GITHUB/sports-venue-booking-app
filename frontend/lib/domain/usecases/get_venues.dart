import '../entities/venue.dart';
import '../repositories/venue_repository.dart';

class GetVenues {
  final VenueRepository repository;

  GetVenues(this.repository);

  Future<List<Venue>> call() async {
    return await repository.getAllVenues();
  }
}
