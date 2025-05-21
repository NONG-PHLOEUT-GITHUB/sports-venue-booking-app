class NotificationModel {
  final String title;
  final String description;
  final String date;
  final NotificationDetails details;

  NotificationModel({
    required this.title,
    required this.description,
    required this.date,
    required this.details,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      description: json['description'],
      date: json['date'],
      details: NotificationDetails.fromJson(json['details']),
    );
  }
}

class NotificationDetails {
  final String field;
  final String time;
  final String duration;
  final String price;
  final String bookingId;
  final String location;
  final String contact;
  final String note;
  final String image;

  NotificationDetails({
    required this.field,
    required this.time,
    required this.duration,
    required this.price,
    required this.bookingId,
    required this.location,
    required this.contact,
    required this.note,
    required this.image,
  });

  factory NotificationDetails.fromJson(Map<String, dynamic> json) {
    return NotificationDetails(
      field: json['field'],
      time: json['time'],
      duration: json['duration'],
      price: json['price'],
      bookingId: json['booking_id'],
      location: json['location'],
      contact: json['contact'],
      note: json['note'],
      image: json['image'],
    );
  }
}
