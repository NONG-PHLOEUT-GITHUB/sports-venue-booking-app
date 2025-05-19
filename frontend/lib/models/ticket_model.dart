class Ticket {
  final String eventName;
  final String location;
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final String field;
  final double price;

  Ticket({
    required this.eventName,
    required this.location,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.field,
    required this.price,
  });
}
