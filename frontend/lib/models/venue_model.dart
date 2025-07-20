// lib/models/venue.dart
class VenueModel {
  final String imageUrl;
  final String name;
  final String location;

  VenueModel({
    required this.imageUrl,
    required this.name,
    required this.location,
  });

  // Factory constructor to parse data from JSON (e.g., from an API response)
  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      location: json['location'] as String
    );
  }

  // Method to convert to JSON (if you need to send data back to an API)
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'location': location
    };
  }
}