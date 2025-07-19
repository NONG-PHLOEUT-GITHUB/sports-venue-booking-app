import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart'; // Assuming you have AppColors for consistent theming
import 'package:get/get.dart';

class CardSection extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String time;
  final String price; // Price as a string or double, will format to $XX.XX
  final String slots; // e.g., "2 Field Available" or "Available"

  const CardSection({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.time,
    required this.price,
    required this.slots,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Margin outside the card, consistent with list item spacing
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // More rounded corners as per design
      ),
      elevation: 0, // No shadow/elevation as per design
      color: Colors.white, // White background for the card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image takes full width of the card, with rounded top corners
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network( // Using Image.network for flexibility, you can change to Image.asset
              imageUrl,
              width: double.infinity, // Image takes full width of the card
              height: 150, // Fixed height for image as seen in design
              fit: BoxFit.cover,
              // Optional: Add a placeholder or error widget for network images
              // loadingBuilder: (context, child, loadingProgress) {
              //   if (loadingProgress == null) return child;
              //   return Center(child: CircularProgressIndicator(value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytes / loadingProgress.expectedTotalBytes! : null,));
              // },
              // errorBuilder: (context, error, stackTrace) => Container(
              //   height: 150, width: double.infinity, color: Colors.grey.shade200,
              //   child: Icon(Icons.broken_image, color: Colors.grey),
              // ),
            ),
          ),
          // Padding for text content below the image
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18, // Slightly larger title
                    fontWeight: FontWeight.bold,
                    color: Colors.black87, // Darker color for prominence
                  ),
                ),
                const SizedBox(height: 8), // Spacing below title
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4), // Small space between icon and text
                    Text(
                      location,
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4), // Spacing below location
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey), // Clock icon for time
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 12), // Spacing before price/slots
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Push price and slots to ends
                  children: [
                    Text(
                      '\$$price', // Format price
                      style: TextStyle(
                        fontSize: 20, // Larger price font
                        fontWeight: FontWeight.bold,
                        color: Get.theme.colorScheme.onSecondary, // Using your primary green color
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), // Adjusted padding
                      decoration: BoxDecoration(
                        color: Colors.green.shade100, // Light green background
                        borderRadius: BorderRadius.circular(20), // More rounded "pill" shape
                      ),
                      child: Text(
                        slots,
                        style: TextStyle(
                          fontSize: 13, // Smaller font for slots text
                          fontWeight: FontWeight.w600, // Semi-bold
                          color: Get.theme.colorScheme.primary, // Green text color
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}