import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardTest extends StatelessWidget {
  //
  CardTest({super.key});

  final List<Map<String, String>> events = [
    {
      'image': 'assets/images/Football.jpg',
      'title': 'Cricket World Cup Trophy Generative',
      'location': 'Vietnam',
      'distance': '10 KM',
    },
    {
      'image': 'assets/images/Football.jpg',
      'title': 'Champions League Final',
      'location': 'Germany',
      'distance': '5 KM',
    },
    {
      'image': 'assets/images/Football.jpg',
      'title': 'T20 Cricket Championship',
      'location': 'Australia',
      'distance': '15 KM',
    },
    {
      'image': 'assets/images/Football.jpg',
      'title': 'T20 Cricket Championship',
      'location': 'Australia',
      'distance': '15 KM',
    },
    {
      'image': 'assets/images/Football.jpg',
      'title': 'T20 Cricket Championship',
      'location': 'Australia',
      'distance': '15 KM',
    },
  ];

  Widget buildVenueCard(
      String imageAsset, String title, String location, String distance) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset(
              imageAsset, // Now dynamic
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),

            // Distance Tag
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  distance,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Event Details
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: AppColors.primary,
      title: Text(
        AppLocalizations.of(context)!.venue,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.onSecondary,
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.appBackground,
      body: ListView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return buildVenueCard(
            event['image']!,
            event['title']!,
            event['location']!,
            event['distance']!,
          );
        },
      ),
    );
  }
}
