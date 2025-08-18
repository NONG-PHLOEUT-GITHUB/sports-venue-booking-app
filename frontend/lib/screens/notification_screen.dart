import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notification_controller.dart';
import '../utils/date_utils.dart';
import '../widgets/custom_back_button.dart';
import '../models/notification_model.dart';
import 'package:frontend/l10n/app_localizations.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static const double padding = 16.0;
  static const double iconSize = 32.0;
  static Color primaryColor = Get.theme.colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notification),
        leading: const CustomBackButton(),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          return Center(
            child: Text(
              AppLocalizations.of(
                context,
              )!.noNotifications, // localized message
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return _buildNotificationItem(notification);
          },
        );
      }),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ListTile(
        leading: Icon(Icons.campaign, color: primaryColor, size: 32),
        title: Text(
          notification.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          notification.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          DateUtilsHelper.formatDate(notification.date),
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        onTap:
            () =>
                _showNotificationDetail(notification), // <-- Tap to show detail
      ),
    );
  }

  void _showNotificationDetail(NotificationModel notification) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    // <-- Wrap title in Expanded to prevent overflow
                    child: Text(
                      notification.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                notification.description,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Text(
                "Date: ${DateUtilsHelper.formatDate(notification.date)}",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
