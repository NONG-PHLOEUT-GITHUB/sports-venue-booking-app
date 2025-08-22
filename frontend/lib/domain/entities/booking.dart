class Booking {
  final String id;
  final String userId;
  final String venueId;
  final String date;
  final String slot;
  final String status;

  Booking({
    required this.id,
    required this.userId,
    required this.venueId,
    required this.date,
    required this.slot,
    required this.status,
  });

  factory Booking.fromMap(String id, Map<String, dynamic> data) {
    return Booking(
      id: id,
      userId: data['userId'],
      venueId: data['venueId'],
      date: data['date'],
      slot: data['slot'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "venueId": venueId,
      "date": date,
      "slot": slot,
      "status": status,
    };
  }
}
