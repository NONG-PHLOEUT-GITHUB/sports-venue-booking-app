import 'package:flutter/material.dart';
import 'package:frontend/screens/payment_options.dart';
import 'package:frontend/theme/app_colors.dart';
import 'package:frontend/l10n/app_localizations.dart';

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
      floatingLabelBehavior: FloatingLabelBehavior.auto, // Make label float
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), // More rounded corners
        borderSide: BorderSide(color: Colors.grey.shade300), // Subtle border
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 2,
        ), // Primary color on focus
      ),
      filled: true,
      fillColor: Colors.white, // White fill for text fields
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ), // Adjusted padding
      suffixIcon: suffixIcon,
      labelStyle: TextStyle(color: Colors.grey.shade700), // Style for the label
      hintStyle: TextStyle(color: Colors.grey.shade400), // Style for the hint
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
    // Current date from image_e02e66.png is 14-2-2025.
    // For a dynamic date, use DateTime.now().
    final String bookingDate = '14-2-2025';
    final String bookingTime = '14:00 PM - 16:00 PM'; // From image_e02e66.png
    final String totalPrice = '\$50.00'; // From image_e02e66.png

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.onSecondary, // Color for the back button icon
        ),
        title: Text(
          AppLocalizations.of(context)!.confirmBooking,
          style: TextStyle(
            fontSize: 22, // Slightly larger title
            fontWeight: FontWeight.bold,
            color: AppColors.onSecondary,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0, // No shadow
        centerTitle: true, // Center the title
      ),
      backgroundColor: Colors.grey.shade100, // Consistent background
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Contact Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  // Subtle shadow
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.yourContactInfo,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16), // Increased spacing
                  // Full Name Input
                  // Removed redundant Text widget for label, using InputDecoration's labelText
                  TextField(
                    controller: nameController,
                    decoration: _buildInputDecoration(
                      AppLocalizations.of(context)!.fullName,
                      AppLocalizations.of(context)!.enterFullName,
                    ),
                  ),
                  const SizedBox(height: 16), // Consistent spacing
                  // Phone Number Input
                  // Removed redundant Text widget for label
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
            const SizedBox(height: 16), // Spacing between cards
            // Booking Details Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  // Subtle shadow
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.bookingDetails,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16), // Increased spacing
                  // Select Field Dropdown
                  // Removed redundant Text widget for label
                  DropdownButtonFormField<String>(
                    value: selectedField,
                    decoration: _buildInputDecoration(
                      AppLocalizations.of(context)!.selectField,
                      '', // Hint text not typically needed for dropdown label
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey.shade600,
                      ), // Explicit dropdown icon
                    ),
                    items:
                        ['Field A', 'Field B', 'Field C']
                            .map(
                              (field) => DropdownMenuItem(
                                value: field,
                                child: Text(field),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedField = value!;
                      });
                    },
                    // Style the dropdown button text
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    icon:
                        SizedBox.shrink(), // Hide default dropdown icon if suffixIcon is used
                  ),
                  const SizedBox(height: 20), // Spacing before date/time
                  // Date Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.date,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        bookingDate,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ), // Stronger font
                      ),
                    ],
                  ),
                  const SizedBox(height: 12), // Consistent spacing
                  // Time Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.time,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        bookingTime,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ), // Stronger font
                      ),
                    ],
                  ),
                  const SizedBox(height: 12), // Consistent spacing
                  // Divider for Separation
                  const Divider(
                    height: 20,
                    thickness: 1,
                    color: Colors.grey,
                  ), // Thicker and more visible divider
                  // Total Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.totalPrice,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ), // Slightly bolder
                      ),
                      Text(
                        totalPrice,
                        style: TextStyle(
                          fontSize: 24, // Larger for emphasis
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: ElevatedButton(
              onPressed: () {
                // Confirm booking logic
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentOptionsScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.confirmBooking,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
