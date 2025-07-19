import 'package:flutter/material.dart';
import 'package:frontend/widgets/card_section.dart'; // Ensure this path is correct
import 'package:frontend/screens/venue_detail_screen.dart'; // Ensure VenueDetailPage is imported
import 'package:frontend/widgets/custom_back_button.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:get/get.dart';

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
      "price": "20.00",
      "slots": "2 Field Available",
    },
    {
      "imageUrl":
          'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343.jpg&fm=jpg',
      "title": "Beach volleyball field",
      "location": "Phnom Penh",
      "time": "08:00 AM - 10:00 PM",
      "price": "20.00",
      "slots": "2 Field Available",
    },
    {
      "imageUrl":
          'https://5.imimg.com/data5/SELLER/Default/2023/8/335122442/GI/HG/ER/19508713/synthetic-basketball-court.jpeg',
      "title": "Basketball Court A",
      "location": "Phnom Penh",
      "time": "08:00 AM - 10:00 PM",
      "price": "25.00",
      "slots": "1 Court Available",
    },
    {
      "imageUrl":
          'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343-2.jpg&fm=jpg',
      "title": "Indoor Futsal Pitch",
      "location": "Phnom Penh",
      "time": "09:00 AM - 12:00 PM",
      "price": "30.00",
      "slots": "3 Pitches Available",
    },
    {
      "imageUrl":
          'https://images.stockcake.com/public/2/e/5/2e5770ce-1bde-4303-97b9-5933496291ca_large/sunset-soccer-scene-stockcake.jpg',
      "title": "Sunset Soccer Field",
      "location": "Phnom Penh",
      "time": "04:00 PM - 07:00 PM",
      "price": "22.00",
      "slots": "1 Field Available",
    },
    {
      "imageUrl":
          'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343-2.jpg&fm=jpg',
      "title": "Morning Grass Pitch",
      "location": "Phnom Penh",
      "time": "06:00 AM - 09:00 AM",
      "price": "18.00",
      "slots": "2 Fields Available",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 20),
                SizedBox(width: 4),
                Text(
                  'Phnom Penh', // Location text
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),

            // Current date display
            Text(
              // Current date is June 27, 2025. Format to "27 June 2025"
              DateFormat('dd MMMM yyyy').format(
                DateTime(2025, 6, 27),
              ), // Use specific date for consistency with image
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        leading: CustomBackButton(),
      ),
      body:
          bookingData
                  .isEmpty // Check if bookingData is empty
              ? Center(
                child: Text(
                  'No bookings found for this date.',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                ),
              )
              : ListView.builder(
                // Remove horizontal padding from ListView.builder as CardSection has its own margin
                padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                itemCount: bookingData.length,
                itemBuilder: (context, index) {
                  final venue = bookingData[index];
                  return GestureDetector(
                    onTap: () {
                      // TODO: Pass venue details to VenueDetailPage if needed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VenueDetailPage(),
                        ),
                      );
                    },
                    child: CardSection(
                      imageUrl: venue["imageUrl"]!,
                      title: venue["title"]!,
                      location: venue["location"]!,
                      time: venue["time"]!,
                      price: venue["price"]!,
                      slots: venue["slots"]!,
                    ),
                  );
                },
              ),
    );
  }
}
