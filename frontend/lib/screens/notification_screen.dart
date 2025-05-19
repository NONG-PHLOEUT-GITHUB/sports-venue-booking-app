import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "Booking Successfully",
      "description": "Your booking has been confirmed.",
      "date": "2025-01-10",
      "details": {
        "field": "Soccer Field A",
        "time": "3:00 PM - 6:00 PM",
        "duration": "3 Hour",
        "price": "30\$",
        "booking_id": "#123456789",
        "location": "123 Sport St, City, State",
        "contact": "(885) 66 555 555",
        "note": "Arrive 15 minutes early for check-in.",
        "image":
            "https://via.placeholder.com/300" // Replace with actual image URL
      }
    },
    {
      "title": "Provide Feedback to Field Agent",
      "description": "Your feedback helps us improve.",
      "date": "2025-01-01",
      "details": {
        "field": "Soccer Field B",
        "time": "2:00 PM - 5:00 PM",
        "duration": "3 Hour",
        "price": "25\$",
        "booking_id": "#987654321",
        "location": "456 Park Ave, City, State",
        "contact": "(885) 66 777 888",
        "note": "Let us know about your experience.",
        "image": "https://via.placeholder.com/300"
      }
    }
  ];

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        AppLocalizations.of(context)!.notification,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.onSecondary,
        ),
      ),
      backgroundColor: AppColors.primary,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.appBackground,
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            child: ListTile(
              leading: Icon(Icons.notifications, color: Colors.green, size: 32),
              title: Text(
                notification["title"]!,
                style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(notification["description"]!),
              trailing: Text(
                formatDate(notification["date"]!),
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                _showNotificationDetail(notification);
              },
            ),
          );
        },
      ),
    );
  }

  void _showNotificationDetail(Map<String, dynamic> notification) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification["title"]!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
                _detailRow("Soccer Field", notification["details"]["field"]),
                _detailRow("Date", formatDate(notification["date"]!)),
                _detailRow("Time", notification["details"]["time"]),
                _detailRow("Duration", notification["details"]["duration"]),
                _detailRow("Price", notification["details"]["price"]),
                _detailRow("Booking ID", notification["details"]["booking_id"]),
                _detailRow("Location", notification["details"]["location"]),
                _detailRow("Contact", notification["details"]["contact"]),
                _detailRow("Note", notification["details"]["note"]),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(notification["details"]["image"]),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          text: "$label : ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
