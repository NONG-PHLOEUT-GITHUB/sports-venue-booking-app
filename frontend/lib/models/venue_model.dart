class VenueModel {
  final String imageUrl;
  final String name;
  final String location;

  VenueModel({
    required this.imageUrl,
    required this.name,
    required this.location,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      imageUrl: json['image_url'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,
      'name': name,
      'location': location,
    };
  }
}
