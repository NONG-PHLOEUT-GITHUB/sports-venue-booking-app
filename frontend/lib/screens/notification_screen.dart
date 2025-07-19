import 'package:flutter/material.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import '../providers/notification_provider.dart'; // where loadFacts is defined
import 'package:frontend/utils/date_utils.dart';
import 'package:get/get.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<Map<String, dynamic>>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar, body: _body);
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.notification),
      leading: CustomBackButton(),
    );
  }

  Widget get _body {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _notificationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No notifications available."));
        }

        final notifications = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.notifications,
                  color: Colors.green,
                  size: 32,
                ),
                title: Text(
                  notification["title"] ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(notification["description"] ?? ''),
                trailing: Text(
                  DateUtilsHelper.formatDate(notification["date"] ?? ''),
                  style: const TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  _showNotificationDetail(notification);
                },
              ),
            );
          },
        );
      },
    );
  }

  void _showNotificationDetail(Map<String, dynamic> notification) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
                _detailRow(
                  "Date",
                  DateUtilsHelper.formatDate(notification["date"]!),
                ),
                _detailRow("Time", notification["details"]["time"]),
                _detailRow("Duration", notification["details"]["duration"]),
                _detailRow("Price", notification["details"]["price"]),
                _detailRow("Booking ID", notification["details"]["booking_id"]),
                _detailRow("Location", notification["details"]["location"]),
                _detailRow("Contact", notification["details"]["contact"]),
                _detailRow("Note", notification["details"]["note"]),
                SizedBox(height: 10),
                Image.asset(
                  notification["details"]["image"],
                  width: 24,
                  height: 24,
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(8),
                //   child: Image.network(notification["details"]["image"]),
                // ),
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
