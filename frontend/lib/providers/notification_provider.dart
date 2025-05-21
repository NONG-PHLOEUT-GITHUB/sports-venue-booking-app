import 'dart:convert';
import 'package:flutter/services.dart';
// import '../models/notification_model.dart'; // import your model

Future<List<Map<String, dynamic>>> loadNotifications() async {
  final String jsonString = await rootBundle.loadString('assets/data/notification.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.cast<Map<String, dynamic>>();
}