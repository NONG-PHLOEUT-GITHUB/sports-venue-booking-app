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
  DateTime selectedDate = DateTime.now();

  final List<Map<String, dynamic>> sports = const [
    {"name": "Football", "icon": Icons.sports_soccer, "color": Colors.green},
    {"name": "Basketball", "icon": Icons.sports_basketball, "color": Colors.orange},
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
              primary: Get.theme.colorScheme.primary,
              onPrimary: Get.theme.colorScheme.onPrimary,
              surface: Get.theme.colorScheme.surface, // Use theme surface for consistency
              onSurface: Get.theme.colorScheme.onSurface, // Use theme onSurface
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Get.theme.colorScheme.primary,
              ),
            ),
            // Ensure the background color of the date picker itself follows the theme
            dialogBackgroundColor: Get.theme.colorScheme.surface,
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
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 20, color: theme.colorScheme.onSurface),
              const SizedBox(width: 4),
              Text(
                'Phnom Penh',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ],
          ),
          IconButton(
            icon: Badge.count(
              count: 99,
              backgroundColor: theme.colorScheme.error, // Use theme error color for badge
              alignment: Alignment.topRight,
              child: Icon(
                Icons.notifications_none,
                size: 28,
                color: theme.colorScheme.onSurface, // Icon color from theme
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

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    Color shadowColor;
    if (isDarkMode) {
      shadowColor = Colors.white.withOpacity(0.03);
    } else {
      shadowColor = Colors.black.withOpacity(0.08);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.greatOffers,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground, // Use onBackground for main titles
              ),
            ),
            const SizedBox(height: 16),
            ImageSlider(),
            const SizedBox(height: 32),
            Text(
              AppLocalizations.of(context)!.bookYourGround,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground, // Use onBackground for main titles
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 0, // Controlled by BoxDecoration shadow
              margin: EdgeInsets.zero, // Remove default card margin
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: theme.colorScheme.surface, // Use theme surface color
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      spreadRadius: 2,
                      blurRadius: 10, // Increased blur for softer shadow
                      offset: const Offset(0, 5), // Adjusted offset
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
                                    color: theme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: const Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${_getMonthName(selectedDate.month)} ${selectedDate.day}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                    Text(
                                      "${selectedDate.year}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                                      ),
                                    ),
                                    Text(
                                      _getWeekdayName(selectedDate.weekday),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background, // Use theme background for dropdown container
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.colorScheme.onSurface.withOpacity(0.2), // Subtle border
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedSport,
                              menuMaxHeight: 350,
                              borderRadius: BorderRadius.circular(12),
                              dropdownColor: theme.colorScheme.surface, // Dropdown menu background
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: theme.colorScheme.primary,
                              ),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedSport = newValue;
                                  });
                                }
                              },
                              items: sports.map((Map<String, dynamic> sport) {
                                return DropdownMenuItem<String>(
                                  value: sport["name"] as String,
                                  child: Row(
                                    children: [
                                      Icon(
                                        sport["icon"] as IconData,
                                        color: sport["color"] as Color,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        sport["name"] as String,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: theme.colorScheme.onSurface,
                                        ),
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
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: DashedLine(
                          color: theme.colorScheme.onSurface.withOpacity(0.3)),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExploreVenuesScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 3,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.makeBooking,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimary, // Use onPrimary for button text
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December",
    ];
    return months[month - 1];
  }

  String _getWeekdayName(int weekday) {
    const weekdays = [
      "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday",
    ];
    return weekdays[weekday - 1];
  }
}

// Re-using DashedLine from TicketPage for consistency
class DashedLine extends StatelessWidget {
  final Color color;
  const DashedLine({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 6.0;
          const dashSpace = 4.0;
          final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}