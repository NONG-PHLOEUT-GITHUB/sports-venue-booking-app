import 'package:flutter/material.dart';
import 'package:frontend/domain/entities/venue.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/presentation/pages/booking/confirm_booking_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/core/widgets/app_primary_button.dart';
import 'package:frontend/core/widgets/custom_back_button.dart';
import 'package:get/get.dart';
import 'package:frontend/presentation/controllers/booking_controller.dart';

class VenueDetailPage extends StatefulWidget {
  final Venue venue;

  const VenueDetailPage({Key? key, required this.venue}) : super(key: key);

  @override
  State<VenueDetailPage> createState() => _VenueDetailState();
}

class _VenueDetailState extends State<VenueDetailPage> {
  final List<String> imagePaths = [
    'assets/images/Football.jpg',
    'assets/images/Football.jpg',
    'assets/images/Football.jpg',
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        widget.venue.name,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      leading: const CustomBackButton(),
    );

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildImageCarousel(),
              const SizedBox(height: 8),
              _buildVenueInfoCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppPrimaryButton(
        text: AppLocalizations.of(context)!.btnBookNow,
        onPressed: () {
          final bookingController = Get.put(BookingController(Get.find()));
          bookingController.totalPrice.value = widget.venue.price;
          bookingController.bookingDate.value = DateTime.now().toString();
          bookingController.bookingTime.value = '08:00 AM - 10:00 AM';
          Get.to(() => ConfirmBookingScreen(venue: widget.venue));
        },
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 1.0,
            onPageChanged: (index, _) => setState(() => _currentIndex = index),
          ),
          items: imagePaths.map((imagePath) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList(),
        ),
        Positioned(
          bottom: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imagePaths.asMap().entries.map((entry) {
              final bool isActive = _currentIndex == entry.key;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: 8.0,
                width: isActive ? 22.0 : 8.0,
                decoration: BoxDecoration(
                  color: isActive
                      ? Get.theme.colorScheme.primary
                      : Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildVenueInfoCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Get.theme.colorScheme.surface,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildRatingSection(),
            const SizedBox(height: 12),
            _buildAddressSection(),
            const Divider(height: 24),
            _buildSectionTitle("Field Information"),
            _buildDetailRow(Icons.sports_soccer, "Type", "5-a-side"),
            _buildDetailRow(Icons.straighten, "Size", "30m x 20m"),
            _buildDetailRow(Icons.grass, "Surface", "Artificial Turf"),
            _buildDetailRow(
              Icons.attach_money,
              "Price per Hour",
              "\$${widget.venue.price.toStringAsFixed(2)}",
            ),
            _buildDetailRow(
              Icons.calendar_today,
              "Available Date",
              DateTime.now().toLocal().toString().split(' ')[0],
            ),
            _buildDetailRow(Icons.access_time, "Time", widget.venue.time),
            const Divider(height: 24),
            _buildFielAvailable(),
            const Divider(height: 24),
            _buildAmenitiesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: const [
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star_half, color: Colors.amber, size: 20),
        SizedBox(width: 8),
        Text("4.5 (20 Reviews)", style: TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildAddressSection() {
    final String address =
        'Delight Party Laws, New 150ft, Ring Road, B/H Rajkot';
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 18,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              address,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.teal),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildFielAvailable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Available Fields"),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: const [
            AmenityChip(label: "File 1", icon: Icons.sports_soccer),
            AmenityChip(label: "File 2", icon: Icons.sports_soccer),
            AmenityChip(label: "File 3", icon: Icons.sports_soccer),
            AmenityChip(label: "File 4", icon: Icons.sports_soccer),
          ],
        ),
      ],
    );
  }

  Widget _buildAmenitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Amenities"),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: const [
            AmenityChip(label: "Canteen and Cafe", icon: Icons.fastfood),
            AmenityChip(label: "Parking", icon: Icons.local_parking),
            AmenityChip(label: "Refreshment Room", icon: Icons.room_service),
          ],
        ),
      ],
    );
  }
}

class AmenityChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const AmenityChip({required this.label, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.teal.shade50,
      avatar: Icon(icon, color: Colors.teal.shade800, size: 18),
      label: Text(label, style: TextStyle(color: Colors.teal.shade800)),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
