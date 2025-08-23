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
  final String note;
  final String image;

  NotificationDetails({
    required this.note,
    required this.image,
  });

  factory NotificationDetails.fromJson(Map<String, dynamic> json) {
    return NotificationDetails(
      note: json['note'],
      image: json['image'],
    );
  }
}
