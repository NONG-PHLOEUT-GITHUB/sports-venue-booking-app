import 'package:flutter/material.dart';
import 'package:frontend/widgets/card_section.dart';
import 'package:frontend/screens/venue_detail_screen.dart';
import 'package:frontend/theme/app_colors.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatelessWidget {
  BookingPage({super.key});

  // Example data for the bookings
  final List<Map<String, String>> bookingData = [
    {
      "imageUrl":
          'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343.jpg&fm=jpg',
      "title": "Water football field",
      "location": "Phnom Penh",
      "time": "07:00 AM - 11:00 PM",
      "rating": "4.9",
      "reviews": "(370 reviews)",
      "price": "20",
      // "distance": "1.4 km",
      "slots": "2 Field Available",
    },
    // You can add more entries here to simulate more bookings
    {
      "imageUrl":
          'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343.jpg&fm=jpg',
      "title": "Beach volleyball field",
      "location": "Phnom Penh",
      "time": "08:00 AM - 10:00 PM",
      "rating": "4.7",
      "reviews": "(280 reviews)",
      "price": "20",
      "slots": "2 Field Available",
    },
    {
      "imageUrl":
          'https://5.imimg.com/data5/SELLER/Default/2023/8/335122442/GI/HG/ER/19508713/synthetic-basketball-court.jpeg',
      "title": "Beach volleyball field",
      "location": "Phnom Penh",
      "time": "08:00 AM - 10:00 PM",
      "rating": "4.7",
      "reviews": "(280 reviews)",
      "price": "20",
      "slots": "2 Field Available",
    },
    {
      "imageUrl":
          'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343-2.jpg&fm=jpg',
      "title": "Beach volleyball field",
      "location": "Phnom Penh",
      "time": "08:00 AM - 10:00 PM",
      "rating": "4.7",
      "reviews": "(280 reviews)",
      "price": "20",
      "slots": "2 Field Available",
    },
    {
      "imageUrl":
          'https://images.stockcake.com/public/2/e/5/2e5770ce-1bde-4303-97b9-5933496291ca_large/sunset-soccer-scene-stockcake.jpg',
      "title": "Beach volleyball field",
      "location": "Phnom Penh",
      "time": "08:00 AM - 10:00 PM",
      "rating": "4.7",
      "reviews": "(280 reviews)",
      "price": "20",
      "slots": "2 Field Available",
    },
    {
      "imageUrl":
          'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343-2.jpg&fm=jpg',
      "title": "Beach volleyball field",
      "location": "Phnom Penh",
      "time": "08:00 AM - 10:00 PM",
      "rating": "4.7",
      "reviews": "(280 reviews)",
      "price": "20",
      "slots": "2 Field Available",
    },
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Color for the back button icon
        ),
        backgroundColor: AppColors.primary,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 0),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Location icon and text
            Row(
              children: [
                Icon(
                  Icons.location_on, // location icon
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  'Phnom Penh', // Location text
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSecondary, // Adjust to your app color
                  ),
                ),
              ],
            ),

            // Current date display
            Text(
              DateFormat('dd-MMMM-yyyy')
                  .format(DateTime.now()), // Display current date
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
     body: ListView.builder(
  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10, top: 5),
  itemCount: bookingData.length,
  itemBuilder: (context, index) {
    final venue = bookingData[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VenueDetailPage(
              // imageUrl: venue["imageUrl"]!,
              // title: venue["title"]!,
              // location: venue["location"]!,
              // time: venue["time"]!,
              // rating: venue["rating"]!,
              // reviews: venue["reviews"]!,
              // price: venue["price"]!,
              // slots: venue["slots"]!,
            ),
          ),
        );
      },
      child: CardSection(
        imageUrl: venue["imageUrl"]!,
        title: venue["title"]!,
        location: venue["location"]!,
        time: venue["time"]!,
        rating: venue["rating"]!,
        reviews: venue["reviews"]!,
        price: venue["price"]!,
        slots: venue["slots"]!,
      ),
    );
  },
),

    );
  }
}
