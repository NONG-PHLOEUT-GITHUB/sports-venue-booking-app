import 'package:flutter/material.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:get/get.dart';

class CardTest extends StatelessWidget {
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
    BuildContext context, // Pass context to access theme
    String imageAsset,
    String title,
    String location,
    String distance,
  ) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Dynamic shadow for the cards
    Color cardShadowColor;
    if (isDarkMode) {
      cardShadowColor = Colors.black.withOpacity(0.3);
    } else {
      cardShadowColor = Colors.black.withOpacity(0.08);
    }

    return Container( // Wrap with Container to control margin and shadow of the Card
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Consistent margin
      decoration: BoxDecoration(
        color: theme.colorScheme.surface, // Background color from theme
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: cardShadowColor,
            blurRadius: 10,
            offset: const Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Image takes full width of the card
            Image.asset(
              imageAsset,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200, // Fixed height for consistency
              errorBuilder: (context, error, stackTrace) => Container(
                width: double.infinity,
                height: 200,
                color: theme.colorScheme.surfaceContainerHighest,
                child: Icon(Icons.broken_image, size: 50, color: theme.colorScheme.onSurface.withOpacity(0.5)),
              ),
            ),

            // Distance Tag
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withOpacity(0.9), // Use theme surface for background
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  distance,
                  style: theme.textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface, // Text color from theme
                  ),
                ),
              ),
            ),

            // Event Details Section (Replacing a simple Container with a more themed approach)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container( // Using Container with BoxDecoration for rounded bottom
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface, // Background color from theme
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface, // Text color from theme
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: theme.colorScheme.onSurface.withOpacity(0.7), // Icon color from theme
                        ),
                        const SizedBox(width: 4),
                        Expanded( // Use Expanded to prevent overflow
                          child: Text(
                            location,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.7), // Text color from theme
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
    final theme = Theme.of(context); // Get theme here for AppBar
    final appBar = AppBar(
      title: Text(
        AppLocalizations.of(context)!.venue, // Using localization
        style: TextStyle(color: theme.colorScheme.onSurface), // Themed title color
      ),
      backgroundColor: theme.appBarTheme.backgroundColor, // Themed app bar background
      elevation: 0, // No shadow for AppBar to keep it clean
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: theme.colorScheme.background, // Themed scaffold background
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust padding for overall list
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return buildVenueCard( // Pass context to buildVenueCard
            context,
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