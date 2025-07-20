// lib/models/venue.dart
class ExploreVenueModel {
  final String imageUrl;
  final String title;
  final String location;
  final String time;
  final double price;
  final String slots;

  ExploreVenueModel({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.time,
    required this.price,
    required this.slots,
  });

  // Factory constructor to parse data from JSON (e.g., from an API response)
  factory ExploreVenueModel.fromJson(Map<String, dynamic> json) {
    return ExploreVenueModel(
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      time: json['time'] as String,
      price: (json['price'] as num).toDouble(), // Handles both int and double from JSON
      slots: json['slots'] as String,
    );
  }

  // Method to convert to JSON (if you need to send data back to an API)
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'location': location,
      'time': time,
      'price': price,
      'slots': slots,
    };
  }
}