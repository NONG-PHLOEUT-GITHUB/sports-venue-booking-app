class Booking {
  String id;
  String venueId;
  String field;
  final String userId;
  String userFullName;
  String phoneNumber;
  String date;
  String time;
  String price;
  String status; // pending, paid, completed

  Booking({
    required this.id,
    required this.venueId,
    required this.field,
    required this.userId,
    required this.userFullName,
    required this.phoneNumber,
    required this.date,
    required this.time,
    required this.price,
    this.status = 'pending',
  });

  Map<String, dynamic> toMap() => {
    'venueId': venueId,
    'field': field,
    'userId': userId,
    'userFullName': userFullName,
    'phoneNumber': phoneNumber,
    'date': date,
    'time': time,
    'price': price,
    'status': status,
  };

  factory Booking.fromMap(String id, Map<String, dynamic> map) {
    return Booking(
      id: id,
      venueId: map['venueId'],
      field: map['field'],
      userId: map['userId'],
      userFullName: map['userFullName'],
      phoneNumber: map['phoneNumber'],
      date: map['date'],
      time: map['time'],
      price: map['price'],
      status: map['status'] ?? 'pending',
    );
  }
}
