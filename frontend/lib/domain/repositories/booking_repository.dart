import 'package:frontend/domain/entities/ticket.dart';
import 'package:frontend/domain/entities/venue.dart';
import '../entities/booking.dart';

abstract class BookingRepository {
  Future<List<Booking>> getAllBookings();
  Future<void> addBooking(Booking booking);
  Future<Venue> getVenueById(String venueId);
  Future<List<TicketData>> getTickets();
}
