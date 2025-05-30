import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart';
import '../widgets/carousel_slider.dart';
import 'booking_screen.dart';
import 'notification_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedSport = "Football";

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

  DateTime selectedDate = DateTime.now(); // Store selected date

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: _appBar,
      body: _body,
    );
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
      centerTitle: false,
      backgroundColor: AppColors.primary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.onSecondary,
                size: 20,
              ),
              SizedBox(width: 4),
              Text(
                'Phnom Penh',
                style: TextStyle(fontSize: 20, color: AppColors.onSecondary),
              ),
            ],
          ),

          // Current date display
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: IconButton(
              icon: Badge.count(
                count: 99,
                backgroundColor: Colors.red,
                child: const Icon(
                  Icons.notifications_none,
                  color: AppColors.onSecondary,
                ),
              ),
              // icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {
                // TODO: Handle notification action
              },
            ),
          ),
          // IconButton(
          //   icon: Badge.count(
          //     count: 99,
          //     backgroundColor: Colors.red,
          //     child: const Icon(
          //       Icons.notifications_none,
          //       color: AppColors.onSecondary,
          //     ),
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => NotificationPage()),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget get _body {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.greatOffers,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[ImageSlider()],
          ),

          SizedBox(height: 0),
          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.bookYourGround,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () => _selectDate(context),
                          backgroundColor: AppColors.primary,
                          child: const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ), // Adjust the space between the icon and text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${selectedDate.day}/${_getMonthName(selectedDate.month)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${selectedDate.year}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              _getWeekdayName(selectedDate.weekday),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedSport,
                          menuMaxHeight: 350,
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // Rounded corners
                          dropdownColor: Colors.white,
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
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        sport["name"],
                                        style: TextStyle(fontSize: 16),
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
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                ),
                SizedBox(
                  height: 20,
                  width: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookingPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                ),
                child: Text(
                  AppLocalizations.of(context)!.makeBooking,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget get _slider {

  // }

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
