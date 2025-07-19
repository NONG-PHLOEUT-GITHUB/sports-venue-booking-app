import 'package:flutter/material.dart';
import 'package:frontend/screens/payment_options.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import 'package:get/get.dart';

class ConfirmBookingScreen extends StatefulWidget {
  const ConfirmBookingScreen({super.key});

  @override
  _ConfirmBookingScreenState createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
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
    final String bookingDate = '14-2-2025';
    final String bookingTime = '14:00 PM - 16:00 PM';
    final String totalPrice = '\$50.00';

    // AppBar
    final appBar = AppBar(
      title: Text(AppLocalizations.of(context)!.confirmBooking),
      leading: CustomBackButton(),
    );

    // Contact Info Card
    final contactInfoCard = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
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
                        (field) =>
                            DropdownMenuItem(value: field, child: Text(field)),
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
                  bookingDate,
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

    final confirmButton = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentOptionsScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Get.theme.colorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          AppLocalizations.of(context)!.confirmBooking,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final bottomContainer = Container(
      padding: const EdgeInsets.fromLTRB(10, 24, 16, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [confirmButton],
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
      bottomNavigationBar: bottomContainer,
    );
  }
}
