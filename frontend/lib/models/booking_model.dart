// booking_model.dart
class Booking {
  final String fieldName;
  final String location;
  final DateTime date;
  final String startTime;
  final String endTime;
  final double price;

  Booking({
    required this.fieldName,
    required this.location,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.price,
  });
}
