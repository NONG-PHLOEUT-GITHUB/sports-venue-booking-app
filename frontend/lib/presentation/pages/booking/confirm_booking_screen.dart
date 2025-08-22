import 'package:flutter/material.dart';
import 'package:frontend/domain/entities/venue.dart';
import 'package:frontend/domain/repositories/booking_repository.dart';
import 'package:frontend/presentation/controllers/booking_controller.dart';
import 'package:frontend/screens/payment_options.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/core/widgets/app_primary_button.dart';
import 'package:frontend/core/widgets/custom_back_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConfirmBookingScreen extends StatelessWidget {
  final Venue venue;

  ConfirmBookingScreen({Key? key, required this.venue}) : super(key: key);

  final BookingController bookingController = Get.put(
    BookingController(Get.find<BookingRepository>()),
  );

  InputDecoration _buildInputDecoration(
    String labelText,
    String hintText, {
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Get.theme.colorScheme.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      suffixIcon: suffixIcon,
    );
  }

  void _initializeBooking() {
    final now = DateTime.now();
    bookingController.bookingDate.value = DateFormat('dd-MM-yyyy').format(now);
    bookingController.bookingTime.value = '08:00 AM - 10:00 AM';
    bookingController.totalPrice.value = venue.price;
    bookingController.selectedField.value = 'Field A';
  }

  @override
  Widget build(BuildContext context) {
    _initializeBooking();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.confirmBooking),
        leading: const CustomBackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Contact Info
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 1,
              color: Get.theme.colorScheme.surface,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.yourContactInfo,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    // Full Name
                    TextField(
                      onChanged: (val) => bookingController.fullName.value = val,
                      decoration: _buildInputDecoration(
                        AppLocalizations.of(context)!.fullName,
                        AppLocalizations.of(context)!.enterFullName,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Phone Number
                    TextField(
                      onChanged: (val) => bookingController.phoneNumber.value = val,
                      keyboardType: TextInputType.phone,
                      decoration: _buildInputDecoration(
                        AppLocalizations.of(context)!.phoneNumber,
                        AppLocalizations.of(context)!.enterPhoneNumber,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Booking Details
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 1,
              color: Get.theme.colorScheme.surface,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.bookingDetails,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => DropdownButtonFormField<String>(
                        value: bookingController.selectedField.value,
                        decoration: _buildInputDecoration(
                          AppLocalizations.of(context)!.selectField,
                          '',
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                        ),
                        items: ['Field A', 'Field B', 'Field C']
                            .map(
                              (field) => DropdownMenuItem(
                                value: field,
                                child: Text(
                                  field,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Get.theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) => bookingController.selectedField.value = val ?? 'Field A',
                        style: const TextStyle(fontSize: 16),
                        icon: const SizedBox.shrink(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.date,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Obx(
                          () => Text(
                            bookingController.bookingDate.value,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.time,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Obx(
                          () => Text(
                            bookingController.bookingTime.value,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 20, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.totalPrice,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Obx(
                          () => Text(
                            '\$${bookingController.totalPrice.value.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Get.theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppPrimaryButton(
        text: AppLocalizations.of(context)!.confirmBooking,
        onPressed: () {
          if (!bookingController.isValid) {
            Get.snackbar(
              'Error',
              'Please enter full name, phone, and select field',
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }
          // Navigate to payment options
          Get.to(() => PaymentOptionsScreen(venueId: venue.id));
        },
      ),
    );
  }
}
