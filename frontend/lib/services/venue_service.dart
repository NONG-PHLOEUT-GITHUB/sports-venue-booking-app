// lib/services/venue_service.dart
import 'package:frontend/models/explore_venue_model.dart';

class VenueService {
  Future<List<ExploreVenueModel>> fetchVenues() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    final List<Map<String, dynamic>> rawData = [
      {
        "imageUrl":
            'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343.jpg&fm=jpg',
        "title": "Water football field",
        "location": "Phnom Penh",
        "time": "07:00 AM - 11:00 PM",
        "price": 20.00,
        "slots": "2 Field Available",
      },
      {
        "imageUrl":
            'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343-2.jpg&fm=jpg',
        "title": "Beach volleyball field",
        "location": "Phnom Penh",
        "time": "08:00 AM - 10:00 PM",
        "price": 20.00,
        "slots": "2 Field Available",
      },
      {
        "imageUrl":
            'https://5.imimg.com/data5/SELLER/Default/2023/8/335122442/GI/HG/ER/19508713/synthetic-basketball-court.jpeg',
        "title": "Basketball Court A",
        "location": "Phnom Penh",
        "time": "08:00 AM - 10:00 PM",
        "price": 25.00,
        "slots": "1 Court Available",
      },
      {
        "imageUrl":
            'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343-2.jpg&fm=jpg',
        "title": "Indoor Futsal Pitch",
        "location": "Phnom Penh",
        "time": "09:00 AM - 12:00 PM",
        "price": 30.00,
        "slots": "3 Pitches Available",
      },
      {
        "imageUrl":
            'https://images.stockcake.com/public/2/e/5/2e5770ce-1bde-4303-97b9-5933496291ca_large/sunset-soccer-scene-stockcake.jpg',
        "title": "Sunset Soccer Field",
        "location": "Phnom Penh",
        "time": "04:00 PM - 07:00 PM",
        "price": 22.00,
        "slots": "1 Field Available",
      },
      {
        "imageUrl":
            'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343-2.jpg&fm=jpg',
        "title": "Morning Grass Pitch",
        "location": "Phnom Penh",
        "time": "06:00 AM - 09:00 AM",
        "price": 18.00,
        "slots": "2 Fields Available",
      },
    ];

    return rawData.map((json) => ExploreVenueModel.fromJson(json)).toList();
  }
}
