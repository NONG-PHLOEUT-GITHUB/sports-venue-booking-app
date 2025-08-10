import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notification_controller.dart';
import '../utils/date_utils.dart';
import '../widgets/custom_back_button.dart';
import '../models/notification_model.dart';
import 'package:frontend/l10n/app_localizations.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());

    final appBar = AppBar(
      title: Text(AppLocalizations.of(context)!.notification),
      leading: const CustomBackButton(),
    );

    final loadingWidget = const Center(child: CircularProgressIndicator());

    final emptyWidget =
        const Center(child: Text("No notifications available."));

    final notificationList = Obx(() {
      if (controller.isLoading.value) return loadingWidget;
      if (controller.notifications.isEmpty) return emptyWidget;

      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: controller.notifications.length,
        itemBuilder: (context, index) {
          final notification = controller.notifications[index];
          return NotificationItem(
            notification: notification,
            onTap: () => _showNotificationDetail(notification),
          );
        },
      );
    });

    return Scaffold(
      appBar: appBar,
      body: notificationList,
    );
  }

  void _showNotificationDetail(NotificationModel notification) {
    Get.bottomSheet(
      NotificationDetailSheet(notification: notification),
      isScrollControlled: true,
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final NotificationModel notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final leadingIcon = const Icon(
      Icons.notifications,
      color: Colors.green,
      size: 32,
    );

    final titleText = Text(
      notification.title,
      style: const TextStyle(fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
    );

    final subtitleText = Text(notification.description);

    final trailingDate = Text(
      DateUtilsHelper.formatDate(notification.date),
      style: const TextStyle(color: Colors.grey),
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: ListTile(
        leading: leadingIcon,
        title: titleText,
        subtitle: subtitleText,
        trailing: trailingDate,
        onTap: onTap,
      ),
    );
  }
}
class NotificationDetailSheet extends StatelessWidget {
  const NotificationDetailSheet({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final details = notification.details;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),

            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),

            // Details list
            _buildDetailRow(Icons.sports_soccer, "Soccer Field", details.field),
            _buildDetailRow(Icons.calendar_today, "Date", DateUtilsHelper.formatDate(notification.date)),
            _buildDetailRow(Icons.access_time, "Time", details.time),
            _buildDetailRow(Icons.timer, "Duration", details.duration),
            _buildDetailRow(Icons.attach_money, "Price", details.price),
            _buildDetailRow(Icons.confirmation_number, "Booking ID", details.bookingId),
            _buildDetailRow(Icons.location_on, "Location", details.location),
            _buildDetailRow(Icons.phone, "Contact", details.contact),
            _buildDetailRow(Icons.note, "Note", details.note),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(value.isEmpty ? "-" : value, style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
