import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/screens/confirm_booking_screen.dart';
import 'package:frontend/theme/app_colors.dart';

// class VenueDetailPage extends StatelessWidget {
//   VenueDetailPage({super.key});
//   final appBar = AppBar(
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//     iconTheme: IconThemeData(
//       color: Colors.white, // Color for the back button icon
//     ),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: appBar,
//       body: Stack(
//         children: [
//           // Cover Image
//           SizedBox(
//             height: 250,
//             width: double.infinity,
//             child: Image.network(
//               'https://images.pexels.com/photos/47343/the-ball-stadion-horn-corner-47343.jpeg?cs=srgb&dl=pexels-pixabay-47343.jpg&fm=jpg',
//               fit: BoxFit.cover,
//             ),
//           ),

//           // Content Container
//           DraggableScrollableSheet(
//             initialChildSize: 0.7,
//             minChildSize: 0.7,
//             maxChildSize: 1.0,
//             builder: (context, scrollController) {
//               return Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//                 ),
//                 padding: const EdgeInsets.all(16),
//                 child: SingleChildScrollView(
//                   controller: scrollController,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title and Location
//                       Text(
//                         'Phnom Penh Champain',
//                         style: TextStyle(
//                             fontSize: 22, fontWeight: FontWeight.bold),
//                       ),

//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           const Icon(Icons.location_on,
//                               size: 16, color: Colors.grey),
//                           Text(
//                             "Phnom Penh",
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           const Icon(Icons.timelapse_outlined,
//                               size: 16, color: Colors.grey),
//                           Text(
//                             "7 AM to 9 AM",
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Icon(Icons.star, color: Colors.amber),
//                           Icon(Icons.star, color: Colors.amber),
//                           Icon(Icons.star, color: Colors.amber),
//                           Icon(Icons.star_half, color: Colors.amber),
//                           Icon(Icons.star_border, color: Colors.amber),
//                           Text(' 3.5'),
//                         ],
//                       ),

//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Text(
//                             '\$10.00',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 12),

//                       // Location Map Link
//                       Row(
//                         children: [
//                           Icon(Icons.map, color: Colors.blue),
//                           const SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment
//                                 .start, // Align texts to the left
//                             children: [
//                               Text('TG Sports Center Condo Hotel',
//                                   style: TextStyle(color: Colors.grey)),
//                               Text('Open Maps',
//                                   style: TextStyle(
//                                       fontSize: 12, color: Colors.green))
//                             ],
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 12),

//                       // Tabs
//                       DefaultTabController(
//                         length: 2,
//                         child: Column(
//                           children: [
//                             TabBar(
//                               indicatorColor: AppColors.primary,
//                               labelColor: Colors.black,
//                               unselectedLabelColor: Colors.grey,
//                               tabs: const [
//                                 Tab(text: 'About Pitch'),
//                                 Tab(text: 'Review'),
//                               ],
//                             ),
//                             SizedBox(height: 8),

//                             // Tab View Content
//                             SizedBox(
//                               height: 200,
//                               child: TabBarView(
//                                 children: [
//                                   // About Pitch
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text('Available Fields',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold)),
//                                       SizedBox(height: 5),
//                                       Row(
//                                         children: [
//                                           Column(
//                                             crossAxisAlignment: CrossAxisAlignment
//                                                 .start, // Align content to the left
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Icon(Icons.stadium,
//                                                       color: Colors.green,
//                                                       size: 20), // Field icon
//                                                   SizedBox(width: 8),
//                                                   Text('Field A'),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 5),
//                                               Row(
//                                                 children: [
//                                                   Icon(Icons.stadium,
//                                                       color: Colors.green,
//                                                       size: 20), // Field icon
//                                                   SizedBox(width: 8),
//                                                   Text('Field B'),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 5),
//                                       Text('Features',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold)),
//                                       SizedBox(height: 5),
//                                       Row(
//                                         children: [
//                                           Column(
//                                             crossAxisAlignment: CrossAxisAlignment
//                                                 .start, // Align content to the left
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Icon(Icons.stadium,
//                                                       color: Colors.green,
//                                                       size: 20), // Field icon
//                                                   SizedBox(width: 8),
//                                                   Text('Grass Pitch'),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 5),
//                                               Row(
//                                                 children: [
//                                                   Icon(Icons.stadium,
//                                                       color: Colors.green,
//                                                       size: 20), // Field icon
//                                                   SizedBox(width: 8),
//                                                   Text('Astroturf'),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           Spacer(),
//                                           Column(
//                                             crossAxisAlignment: CrossAxisAlignment
//                                                 .start, // Align content to the left
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Icon(Icons.stadium,
//                                                       color: Colors.green,
//                                                       size: 20), // Field icon
//                                                   SizedBox(width: 8),
//                                                   Text('Floodlights'),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 5),
//                                               Row(
//                                                 children: [
//                                                   Icon(Icons.stadium,
//                                                       color: Colors.green,
//                                                       size: 20), // Field icon
//                                                   SizedBox(width: 8),
//                                                   Text('Changing Rooms'),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 8),
//                                       Text('Facilities',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold)),
//                                     ],
//                                   ),

//                                   // Review Tab
//                                   Center(
//                                       child: Text(
//                                           'Reviews will be displayed here')),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Padding(
//           padding: EdgeInsets.all(5.0),
//           child: SizedBox(
//             width: double.infinity,
//             height: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 // Confirm booking logic
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ConfirmBookingScreen()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Text(AppLocalizations.of(context)!.btnBookNow,
//                   style: TextStyle(fontSize: 18, color: Colors.white)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:carousel_slider/carousel_slider.dart';

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
      backgroundColor: AppColors.primary,
      iconTheme: IconThemeData(
        color: Colors.white, // Color for the back button icon
      ),
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
      backgroundColor: Colors.grey.shade100,
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Card(
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
                    items: imagePaths.map((imagePath) {
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
                    children: imagePaths.asMap().entries.map((entry) {
                      bool isActive = _currentIndex == entry.key;
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        height: 8.0,
                        width: isActive ? 20.0 : 8.0,
                        decoration: BoxDecoration(
                          color: isActive ? Colors.green : Colors.grey.shade400,
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
                      child: Text('Phnom Penh Champain',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
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
                      Text("0 Review",
                          style: TextStyle(fontWeight: FontWeight.w500)),
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
                          borderRadius: BorderRadius.circular(12)),
                      side: const BorderSide(color: Colors.teal),
                      foregroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Owner Details
                  const Text("Owner Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
               
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
                      Text("08:00 PM To 09:00 PM",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Amenities
                  const Text("Amenities",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Confirm booking logic
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfirmBookingScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.btnBookNow,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
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
