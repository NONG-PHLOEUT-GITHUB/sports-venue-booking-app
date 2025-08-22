import '../../domain/entities/venue.dart';
import '../../domain/repositories/venue_repository.dart';
import '../datasources/firebase_venue_datasource.dart';

class VenueRepositoryImpl implements VenueRepository {
  final FirebaseVenueDataSource dataSource;

  VenueRepositoryImpl(this.dataSource);

  @override
  Future<List<Venue>> getAllVenues() async {
    final rawData = await dataSource.getAllVenues();
    return rawData.map((e) => Venue.fromMap(e['id'], e)).toList();
  }

  @override
  Future<void> addVenue(Venue venue) async {
    await dataSource.addVenue(venue.toMap(), venue.id);
  }
}
