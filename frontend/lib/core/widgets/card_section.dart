import 'package:flutter/material.dart';
import 'package:frontend/models/explore_venue_model.dart'; // Import your VenueModel

class CardSection extends StatelessWidget {
  final ExploreVenueModel venue; // Now accepts a VenueModel object

  const CardSection({
    super.key,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Dynamic shadow color based on theme mode
    Color shadowColor;
    if (isDarkMode) {
      shadowColor = Colors.white.withOpacity(0.03); // Subtle for dark mode
    } else {
      shadowColor = Colors.black.withOpacity(0.08); // Standard for light mode
    }

    return Card(
      elevation: 0, // Control elevation via BoxDecoration shadow
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      color: theme.colorScheme.surface, // Use theme surface color
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface, // Card background color from theme
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 1,
              blurRadius: 10, // Increased blur for softer shadow
              offset: const Offset(0, 5), // Adjusted offset for depth
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image takes full width of the card, with rounded top corners
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                venue.imageUrl, // Use venue.imageUrl
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 150,
                  color: theme.colorScheme.surface.withOpacity(0.5), // Themed placeholder
                  child: Icon(Icons.broken_image, color: theme.colorScheme.onSurface.withOpacity(0.5)),
                ),
              ),
            ),
            // Padding for text content below the image
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    venue.title, // Use venue.title
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface, // Text color from theme
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: theme.colorScheme.onSurface.withOpacity(0.7)), // Icon color from theme
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          venue.location, // Use venue.location
                          style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7), fontSize: 14), // Text color from theme
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: theme.colorScheme.onSurface.withOpacity(0.7)), // Icon color from theme
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          venue.time, // Use venue.time
                          style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7), fontSize: 14), // Text color from theme
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${venue.price.toStringAsFixed(2)}', // Use venue.price
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary, // Price color from theme primary
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withOpacity(0.1), // Background from theme secondary
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          venue.slots, // Use venue.slots
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.secondary, // Text color from theme secondary
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
      ),
    );
  }
}