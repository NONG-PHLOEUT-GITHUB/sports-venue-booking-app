import 'package:frontend/domain/entities/booking.dart';
import 'package:frontend/domain/entities/venue.dart';

class TicketData {
  final Booking booking;
  final Venue venue;

  TicketData({required this.booking, required this.venue});

  String get venueName => venue.name;
  String get location => venue.location;
  String get fieldName => booking.field;
  String get date => booking.date;
  String get startTime => booking.time; // adjust if you have start/end
  String get endTime => booking.time;   // adjust if you have actual endTime
  double get price => double.tryParse(booking.price) ?? venue.price;
  String get status => booking.status;
}
