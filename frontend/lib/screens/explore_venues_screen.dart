import 'package:flutter/material.dart';
import 'package:frontend/widgets/card_section.dart';
import 'package:frontend/screens/venue_detail_screen.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:frontend/controllers/explore_venue_controller.dart';

class ExploreVenuesScreen extends StatelessWidget {
  const ExploreVenuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExploreVenueController venueController = Get.put(ExploreVenueController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 20, color: theme.colorScheme.onSurface),
                const SizedBox(width: 4),
                Text(
                  'Phnom Penh',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            Text(
              DateFormat('dd MMMM yyyy').format(
                DateTime(2025, 7, 20),
              ),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
        leading: const CustomBackButton(),
      ),
      body: Obx(() {
        if (venueController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (venueController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              venueController.errorMessage.value,
              style: TextStyle(fontSize: 18, color: theme.colorScheme.error),
            ),
          );
        } else if (venueController.venues.isEmpty) {
          return Center(
            child: Text(
              'No venues found for this date.',
              style: TextStyle(fontSize: 18, color: theme.colorScheme.onBackground.withOpacity(0.6)),
            ),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: venueController.venues.length,
            itemBuilder: (context, index) {
              final venue = venueController.venues[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => VenueDetailPage(venue: venue));
                },
                // THIS IS THE FIX: Pass the entire 'venue' object
                child: CardSection(venue: venue),
              );
            },
          );
        }
      }),
    );
  }
}