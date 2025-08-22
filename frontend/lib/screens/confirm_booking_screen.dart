import 'package:flutter/material.dart';
import 'package:frontend/screens/payment_options.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/core/widgets/app_primary_button.dart';
import 'package:frontend/core/widgets/custom_back_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:frontend/controllers/confirm_booking_controller.dart';

class ConfirmBookingScreen extends StatefulWidget {
  const ConfirmBookingScreen({super.key});

  @override
  _ConfirmBookingScreenState createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
   final BookingController bookingController = Get.put(BookingController());
  String selectedField =
      'Field C'; // Set a default value that exists in the list
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Helper for consistent text field decoration
  InputDecoration _buildInputDecoration(
    String labelText,
    String hintText, {
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText, // Use labelText for floating label effect
      hintText: hintText,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), // More rounded corners
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Get.theme.colorScheme.primary,
          width: 2,
        ), // Primary color on focus
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ), // Adjusted padding
      suffixIcon: suffixIcon,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final String bookingDate = '14-2-2025';
    // final String bookingTime = '14:00 PM - 16:00 PM';
    final now = DateTime.now();

// Format the date to 'dd-MM-yyyy'
    final bookDate = DateFormat('dd-MM-yyyy').format(now);

    // final String totalPrice = '\$50.00';
    // final String bookingDate = bookingController.bookingDate.value;
    final String bookingTime = bookingController.bookingTime.value;
    final String totalPrice = bookingController.totalPrice.value;

    // AppBar
    final appBar = AppBar(
      title: Text(AppLocalizations.of(context)!.confirmBooking),
      leading: CustomBackButton(),
    );

    // Contact Info Card
    final contactInfoCard = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      color: Get.theme.colorScheme.surface,
      margin: EdgeInsets.zero, // since you already control padding outside
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
            TextField(
              controller: nameController,
              decoration: _buildInputDecoration(
                AppLocalizations.of(context)!.fullName,
                AppLocalizations.of(context)!.enterFullName,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: _buildInputDecoration(
                AppLocalizations.of(context)!.phoneNumber,
                AppLocalizations.of(context)!.enterPhoneNumber,
              ),
            ),
          ],
        ),
      ),
    );

    // Booking Details Card
    final bookingDetailsCard = Card(
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
            DropdownButtonFormField<String>(
              value: selectedField,
              decoration: _buildInputDecoration(
                AppLocalizations.of(context)!.selectField,
                '',
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
              items:
                  ['Field A', 'Field B', 'Field C']
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
              onChanged: (value) {
                setState(() {
                  selectedField = value!;
                });
              },
              style: const TextStyle(fontSize: 16),
              icon: const SizedBox.shrink(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.date,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  bookDate,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  bookingTime,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  totalPrice,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            contactInfoCard,
            const SizedBox(height: 16),
            bookingDetailsCard,
          ],
        ),
      ),
      bottomNavigationBar: AppPrimaryButton(
        text: AppLocalizations.of(context)!.confirmBooking,
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => PaymentOptionsScreen()),
          // );
            
          bookingController.fullName.value = nameController.text;
          bookingController.phoneNumber.value = phoneController.text;
          bookingController.selectedField.value = selectedField;
          bookingController.bookingDate.value = bookDate;
          bookingController.bookingTime.value = bookingTime;
          bookingController.totalPrice.value = totalPrice;

          // Now navigate to the next screen
          // The next screen can simply find the same controller to get all the data
          Get.to(() => PaymentOptionsScreen());
        },
      ),
    );
  }
}
