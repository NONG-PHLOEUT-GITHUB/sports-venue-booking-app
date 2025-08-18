class TicketData {
  final String eventName;
  final String status;
  final String location;
  final String date;
  final String startTime;
  final String endTime;
  final String fieldName;
  final double price;

  TicketData({
    required this.eventName,
    required this.status,
    required this.location,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.fieldName,
    required this.price,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) {
    return TicketData(
      eventName: json['eventName'] ?? 'Unknown Event',
      status: json['status'] ?? 'Pending',
      location: json['location'] ?? 'N/A',
      date: json['date'] ?? 'N/A',
      startTime: json['startTime'] ?? 'N/A',
      endTime: json['endTime'] ?? 'N/A',
      fieldName: json['fieldName'] ?? 'N/A',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
