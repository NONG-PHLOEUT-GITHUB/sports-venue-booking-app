import 'package:flutter/material.dart';
import 'package:frontend/controllers/venue_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/models/venue_model.dart';
import 'package:frontend/l10n/app_localizations.dart';

class VenueListSreen extends StatelessWidget {
  VenueListSreen({super.key});

  final VenueListController venueController = Get.put(VenueListController());

  Widget buildVenueCard(BuildContext context, VenueModel venue) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0,
      shadowColor:
          isDarkMode
              ? Colors.black.withOpacity(0.3)
              : Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias, // Ensures rounded image clipping
      child: Stack(
        children: [
          Image.network(
            venue.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
            errorBuilder:
                (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 200,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.broken_image,
                    size: 50,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              // Uncomment and customize if needed
              // child: Text(
              //   "${venue.slots} slots",
              //   style: theme.textTheme.labelMedium!.copyWith(
              //     fontWeight: FontWeight.bold,
              //     color: theme.colorScheme.onSurface,
              //   ),
              // ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: theme.colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    venue.name,
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          venue.location,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.venue)),
      body: Obx(() {
        if (venueController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (venueController.venues.isEmpty) {
          return const Center(child: Text("No venues found"));
        }

        return ListView.builder(
          itemCount: venueController.venues.length,
          itemBuilder: (context, index) {
            final venue = venueController.venues[index];
            return buildVenueCard(context, venue);
          },
        );
      }),
    );
  }
}
