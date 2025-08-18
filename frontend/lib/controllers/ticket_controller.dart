import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/ticket_model.dart';

class TicketController extends GetxController {
  var tickets = <TicketData>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadTickets();
  }

  Future<void> loadTickets() async {
    try {
      isLoading.value = true;
      final String response = await rootBundle.loadString('assets/data/ticket.json');
      final List<dynamic> data = json.decode(response);
      tickets.value = data.map((item) => TicketData.fromJson(item)).toList();
    } catch (e) {
      print("Error loading tickets: $e");
    } finally {
      isLoading.value = false;
    }
  }

  int get ticketCount => tickets.length;
}
