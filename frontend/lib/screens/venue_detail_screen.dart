import 'package:flutter/material.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/screens/confirm_booking_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import 'package:get/get.dart';

class VenueDetailPage extends StatefulWidget {
  @override
  _VenueDetailState createState() => _VenueDetailState();
}

class _VenueDetailState extends State<VenueDetailPage> {
  final List<String> imagePaths = [
    'assets/images/Football.jpg', // Replace with your own URLs
    'assets/images/Football.jpg',
    'assets/images/Football.jpg',
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(AppLocalizations.of(context)!.venue),
      leading: CustomBackButton(),
    );

    final paymentButton = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConfirmBookingScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Get.theme.colorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          AppLocalizations.of(context)!.btnBookNow,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final bottomContainer = Container(
      padding: const EdgeInsets.fromLTRB(10, 24, 16, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [paymentButton],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 150,
                      // enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items:
                        imagePaths.map((imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              );
                            },
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 10),

                  // Dot Indicator with active width effect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        imagePaths.asMap().entries.map((entry) {
                          bool isActive = _currentIndex == entry.key;
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            height: 8.0,
                            width: isActive ? 20.0 : 8.0,
                            decoration: BoxDecoration(
                              color:
                                  isActive
                                      ? Colors.green
                                      : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 12),
                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Phnom Penh Champain',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Stars and Review
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "0 Review",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Address
                  Row(
                    children: const [
                      Icon(Icons.location_on_outlined, size: 18),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Delight Party Laws, New 150ft, Ring Road, B/H Rajkot',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Map Location Button
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.navigation),
                    label: const Text("Map Location"),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: Colors.teal),
                      foregroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Owner Details
                  const Text(
                    "Owner Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  // Date and Time
                  Row(
                    children: const [
                      Icon(Icons.calendar_today, size: 18),
                      SizedBox(width: 8),
                      Text("16/07/2024", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.access_time, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "08:00 PM To 09:00 PM",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Amenities
                  const Text(
                    "Amenities",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: const [
                      AmenityChip(label: "Canteen and cafe"),
                      AmenityChip(label: "Lookers"),
                      AmenityChip(label: "Parkings"),
                      AmenityChip(label: "Refreshment Room"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomContainer,
    );
  }
}

class AmenityChip extends StatelessWidget {
  final String label;

  const AmenityChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.teal.shade50,
      label: Text(label, style: TextStyle(color: Colors.teal.shade800)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
