import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../domain/entities/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var isLoading = true.obs;
  int get notificationCount => notifications.length;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      isLoading.value = true;

      // Load JSON from assets
      final String response = await rootBundle.loadString('assets/data/notification.json');
      final List<dynamic> data = json.decode(response);
      notifications.value = data
          .map((item) => NotificationModel.fromJson(item))
          .toList();
      notifications.value = data.map((item) => NotificationModel.fromJson(item)).toList();
    } catch (e) {
      print("Error loading notifications: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
