import 'package:flutter/material.dart';
import '../widgets/carousel_slider.dart';
import 'explore_venues_screen.dart';
import 'notification_screen.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedSport = "Football";
  DateTime selectedDate = DateTime.now(); // Store selected date

  final List<Map<String, dynamic>> sports = [
    {"name": "Football", "icon": Icons.sports_soccer, "color": Colors.green},
    {
      "name": "Basketball",
      "icon": Icons.sports_basketball,
      "color": Colors.orange,
    },
    {"name": "Tennis", "icon": Icons.sports_tennis, "color": Colors.yellow},
    {"name": "Cricket", "icon": Icons.sports_cricket, "color": Colors.blue},
    {"name": "Hockey", "icon": Icons.sports_hockey, "color": Colors.red},
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Get.theme.colorScheme.primary, // Header background color
              onPrimary: Get.theme.colorScheme.onSecondary, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    Get.theme.colorScheme.primary, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar, body: _body);
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 20),
              const SizedBox(width: 4),
              Text('Phnom Penh'),
            ],
          ),
          IconButton(
            icon: Badge.count(
              count: 99,
              backgroundColor: Colors.red,
              alignment: Alignment.topRight, // Adjust badge position
              child: Icon(
                Icons.notifications_none,
                size: 28, // Slightly larger icon
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget get _body {
    return SingleChildScrollView(
      // Use SingleChildScrollView for scrollability
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to start
          children: <Widget>[
            const SizedBox(height: 16), // Added spacing from app bar
            // Title for offers
            Text(
              AppLocalizations.of(context)!.greatOffers,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ), // Slightly larger font
            ),
            const SizedBox(height: 16),
            // Image Slider
            ImageSlider(),
            const SizedBox(height: 32), // More space before next section
            // Title for booking
            Text(
              AppLocalizations.of(context)!.bookYourGround,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ), // Consistent font size
            ),
            const SizedBox(height: 16),

            // Booking Card
            Container(
              padding: const EdgeInsets.all(20), // Increased padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20), // More rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // subtle shadow
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Get.theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ), // Rounded corners for button
                                ),
                                padding: const EdgeInsets.all(
                                  10,
                                ), // Padding inside button
                                child: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.white,
                                  size: 28, // Larger icon
                                ),
                              ),
                              const SizedBox(width: 16), // More space
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // Formatted date string (e.g., "June 26")
                                    "${_getMonthName(selectedDate.month)} ${selectedDate.day}",
                                    style: TextStyle(
                                      fontSize: 20, // Larger font for date
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Colors
                                              .black87, // Slightly softer black
                                    ),
                                  ),
                                  Text(
                                    "${selectedDate.year}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.w500, // Medium weight
                                      color: Colors.black54, // Softer color
                                    ),
                                  ),
                                  Text(
                                    _getWeekdayName(selectedDate.weekday),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          Colors.grey.shade600, // Clearer grey
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Sport Dropdown
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50, // Lighter background
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ), // Subtle border
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedSport,
                            menuMaxHeight: 350,
                            borderRadius: BorderRadius.circular(12),
                            dropdownColor: Colors.white,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Get.theme.colorScheme.primary,
                            ), // Custom dropdown icon
                            onChanged: (newValue) {
                              setState(() {
                                selectedSport = newValue!;
                              });
                            },
                            items:
                                sports.map((sport) {
                                  return DropdownMenuItem<String>(
                                    value: sport["name"],
                                    child: Row(
                                      children: [
                                        Icon(
                                          sport["icon"],
                                          color: sport["color"],
                                          size: 20, // Consistent icon size
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          sport["name"],
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black87,
                                          ), // Clearer text
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ), // Space between content and dotted line
                  // Dotted line separator
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            (constraints.constrainWidth() / 10).floor(),
                            (index) => SizedBox(
                              height: 1,
                              width: 5,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ), // Space between dotted line and button
                  // Make Booking Button
                  SizedBox(
                    width: double.infinity, // Make button span full width
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            14,
                          ), // More rounded
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                        ), // Increased vertical padding
                        elevation: 3, // Subtle elevation
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.makeBooking,
                        style: TextStyle(
                          fontSize: 18, // Larger font for button text
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5, // Slightly spaced out letters
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24), // Space at the bottom
          ],
        ),
      ),
    );
  }

  // Convert month number to name
  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  // Convert weekday number to name
  String _getWeekdayName(int weekday) {
    const weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    return weekdays[weekday - 1];
  }
}
