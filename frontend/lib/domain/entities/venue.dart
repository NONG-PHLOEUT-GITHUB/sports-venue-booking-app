class Venue {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final String time;
  final double price;
  final String slots;

  Venue({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.time,
    required this.price,
    required this.slots,
  });

  // Convert Firestore map to Venue entity
  factory Venue.fromMap(String id, Map<String, dynamic> map) {
    return Venue(
      id: id,
      name: map['title'] ?? '',
      location: map['location'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      time: map['time'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      slots: map['slots'] ?? '',
    );
  }

  // Convert Venue entity to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'imageUrl': imageUrl,
      'time': time,
      'price': price,
      'slots': slots,
    };
  }
}
