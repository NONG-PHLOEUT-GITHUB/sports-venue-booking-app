import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/card_section.dart';
import 'package:frontend/presentation/controllers/venue_controller.dart';
import 'package:frontend/presentation/screens/venue_detail_screen.dart';
import 'package:frontend/core/widgets/custom_back_button.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ExploreVenuesScreen extends StatelessWidget {

  ExploreVenuesScreen({super.key});

  final VenueController controller = Get.put(VenueController(Get.find()));
  
  @override
  Widget build(BuildContext context) {

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
  
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: controller.venues.length,
            itemBuilder: (context, index) {
              final venue = controller.venues[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => VenueDetailPage(venue: venue));
                },
                // THIS IS THE FIX: Pass the entire 'venue' object
                child: CardSection(venue: venue),
              );
            },
          );
     
      }),
    );
  }
}