import 'package:frontend/domain/entities/ticket.dart';
import 'package:frontend/domain/entities/venue.dart';

import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/firebase_booking_datasource.dart';

class BookingRepositoryImpl implements BookingRepository {
  final FirebaseBookingDataSource dataSource;

  BookingRepositoryImpl(this.dataSource);

  @override
  Future<List<Booking>> getAllBookings() async {
    final rawData = await dataSource.getAllBookings();
    return rawData.map((e) => Booking.fromMap(e['id'], e)).toList();
  }

  @override
  Future<void> addBooking(Booking booking) async {
    await dataSource.addBooking(booking);
  }

  @override
  Future<Venue> getVenueById(String venueId) async {
    return await dataSource.getVenueById(venueId);
  }

  @override
  Future<List<TicketData>> getTickets() async {
    final bookings = await getAllBookings();
    List<TicketData> tickets = [];
    for (var b in bookings) {
      try {
        final venue = await getVenueById(b.venueId);
        tickets.add(TicketData(booking: b, venue: venue));
      } catch (e) {
        print("Error building ticket for booking ${b.id}: $e");
      }
    }
    return tickets;
  }
}
