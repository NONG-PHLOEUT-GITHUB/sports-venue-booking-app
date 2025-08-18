import 'package:flutter/material.dart';
import '../widgets/carousel_slider.dart';
import 'explore_venues_screen.dart';
import 'notification_screen.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ----------------------------- State -----------------------------
  String selectedSport = "Football";
  DateTime selectedDate = DateTime.now();

  // ----------------------------- Constants -----------------------------
  static const double horizontalPadding = 16.0;
  static const double verticalSpacing = 16.0;
  static const double cardPadding = 20.0;
  static const double buttonVerticalPadding = 16.0;

  final List<Map<String, dynamic>> sports = const [
    {"name": "Football", "icon": Icons.sports_soccer, "color": Colors.green},
    {"name": "Basketball", "icon": Icons.sports_basketball, "color": Colors.orange},
    {"name": "Tennis", "icon": Icons.sports_tennis, "color": Colors.yellow},
    {"name": "Cricket", "icon": Icons.sports_cricket, "color": Colors.blue},
    {"name": "Hockey", "icon": Icons.sports_hockey, "color": Colors.red},
  ];

  // ----------------------------- Date Picker -----------------------------
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
              surface: Get.theme.colorScheme.surface,
              onSurface: Get.theme.colorScheme.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Get.theme.colorScheme.primary,
              ),
            ),
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

  // ----------------------------- Build -----------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  // ----------------------------- AppBar -----------------------------
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
              Text('Phnom Penh', style: TextStyle(color: theme.colorScheme.onSurface)),
            ],
          ),
          IconButton(
            icon: Badge.count(
              count: 99,
              backgroundColor: theme.colorScheme.error,
              alignment: Alignment.topRight,
              child: Icon(
                Icons.notifications_none,
                size: 28,
                color: theme.colorScheme.onSurface,
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

  // ----------------------------- Body -----------------------------
  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final shadowColor = isDarkMode
        ? Colors.white.withOpacity(0.03)
        : Colors.black.withOpacity(0.08);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: verticalSpacing),
            _buildSectionTitle(context, AppLocalizations.of(context)!.greatOffers),
            const SizedBox(height: verticalSpacing),
            ImageSlider(),
            const SizedBox(height: verticalSpacing * 2),
            _buildSectionTitle(context, AppLocalizations.of(context)!.bookYourGround),
            const SizedBox(height: verticalSpacing),
            _buildBookingCard(theme, shadowColor),
            const SizedBox(height: verticalSpacing * 1.5),
          ],
        ),
      ),
    );
  }

  // ----------------------------- Section Title -----------------------------
  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onBackground,
      ),
    );
  }

  // ----------------------------- Booking Card -----------------------------
  Widget _buildBookingCard(ThemeData theme, Color shadowColor) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: theme.colorScheme.surface,
      child: Container(
        padding: const EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildBookingHeader(theme),
            const SizedBox(height: 24),
            DashedLine(color: theme.colorScheme.onSurface.withOpacity(0.3)),
            const SizedBox(height: 24),
            _buildBookingButton(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildDateSelector(theme)),
        _buildSportDropdown(theme),
      ],
    );
  }

Widget _buildDateSelector(ThemeData theme) {
  return GestureDetector(
    onTap: () => _selectDate(context),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(Icons.calendar_month_outlined, color: theme.colorScheme.onPrimary, size: 28),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMMM d').format(selectedDate),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              DateFormat('y').format(selectedDate),
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            Text(
              DateFormat('EEEE').format(selectedDate),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSportDropdown(ThemeData theme) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: theme.colorScheme.background,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.2)),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedSport,
        menuMaxHeight: 350,
        borderRadius: BorderRadius.circular(12),
        dropdownColor: theme.colorScheme.surface,
        icon: Icon(Icons.arrow_drop_down, color: theme.colorScheme.primary),
        onChanged: (String? newValue) {
          if (newValue != null) setState(() => selectedSport = newValue);
        },
        items: sports.map((sport) {
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
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ),
  );
}

  Widget _buildBookingButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ExploreVenuesScreen()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(vertical: buttonVerticalPadding),
          elevation: 3,
        ),
        child: Text(
          AppLocalizations.of(context)!.makeBooking,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

// ----------------------------- DashedLine -----------------------------
class DashedLine extends StatelessWidget {
  final Color color;
  const DashedLine({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 6.0;
          const dashSpace = 4.0;
          final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
          return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: 1,
                child: DecoratedBox(decoration: BoxDecoration(color: color)),
              );
            }),
          );
        },
      ),
    );
  }
}
