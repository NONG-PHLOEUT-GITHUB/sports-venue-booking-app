// Inside lib/controllers/booking_controller.dart

import 'package:get/get.dart';
import 'package:frontend/models/explore_venue_model.dart';

class BookingController extends GetxController {
  final fullName = ''.obs;
  final phoneNumber = ''.obs;
  final selectedField = ''.obs;
  final bookingDate = ''.obs;
  final bookingTime = ''.obs;
  final totalPrice = ''.obs;
  final selectedVenue = Rxn<ExploreVenueModel>(); // Use the correct model

  void updateBookingDetails({
    required String name,
    required String phone,
    required ExploreVenueModel venue,
  }) {
    // This is where you populate all the data
    fullName.value = name;
    phoneNumber.value = phone;
    selectedVenue.value = venue;
    selectedField.value = venue.title;
    bookingTime.value = venue.time;
    totalPrice.value = venue.price.toStringAsFixed(2); 
  }
}