import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart';
import 'payment_successful_scrren.dart';
import 'package:frontend/l10n/app_localizations.dart';

class CheckOutScreen extends StatelessWidget {
  CheckOutScreen({super.key});
  final double transferAmount = 7.20;
  final double additionalCost = 0.50;

  @override
  Widget build(BuildContext context) {
    final double totalAmount = transferAmount + additionalCost;

    final Color onPrimaryColor = AppColors.onSecondary;

    final appBar = AppBar(
      iconTheme: IconThemeData(
        color: onPrimaryColor,
      ), // Back button color on primary
      title: Text(
        AppLocalizations.of(context)!.payment, // "Payment" or "Checkout"
        style: TextStyle(
          fontSize: 22, // Slightly larger title
          fontWeight: FontWeight.bold,
          color: onPrimaryColor,
        ),
      ),
      backgroundColor: AppColors.primary,
      centerTitle: true, // Center the title for consistency
      elevation: 0, // No shadow for a cleaner look
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar,
      body: SingleChildScrollView(
        // Make the body scrollable
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 20.0,
        ), // Overall padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Information Section
            // Container(
            //   padding: const EdgeInsets.all(16.0),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(16.0), // Rounded corners
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.05),
            //         spreadRadius: 1,
            //         blurRadius: 5,
            //         offset: Offset(0, 3),
            //       ),
            //     ],
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       // put card here
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 24), // Spacing between sections
            // Credit Card Payment Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    AppColors
                        .onSecondary, // White background for the card details section
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to start
                  children: [
                    Text(
                      AppLocalizations.of(
                        context,
                      )!.creditPay, // "Credit/Debit Card Details"
                      style: TextStyle(
                        fontSize: 18, // Consistent title size
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16), // Space between title and form
                    Form(
                      child: Column(
                        children: [
                          _buildModernTextField(
                            AppLocalizations.of(context)!.cardHolderName,
                            Icons.person,
                          ),
                          const SizedBox(height: 16), // Increased spacing
                          _buildModernTextField(
                            AppLocalizations.of(
                              context,
                            )!.cardName, // Changed from Card Name to Card Number
                            Icons.credit_card,
                            hintText:
                                '0000 0000 0000 0000', // More realistic hint
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16), // Increased spacing
                          Row(
                            children: [
                              Expanded(
                                child: _buildModernTextField(
                                  AppLocalizations.of(context)!.expiryDate,
                                  Icons.calendar_today,
                                  hintText: 'MM/YYYY',
                                  keyboardType: TextInputType.datetime,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildModernTextField(
                                  "CVV", // No localization for CVV usually
                                  Icons.lock,
                                  hintText: '000',
                                  keyboardType: TextInputType.number,
                                  isObscureText: true, // Hide CVV input
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
            ),
            const SizedBox(height: 24), // Spacing between sections
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSummaryRow(
                    "Transfer Amount",
                    "\$${transferAmount.toStringAsFixed(2)}",
                  ),
                  const SizedBox(height: 10),
                  _buildSummaryRow(
                    "Additional Cost",
                    "\$${additionalCost.toStringAsFixed(2)}",
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ), // Separator
                  const SizedBox(height: 10),
                  _buildSummaryRow(
                    "Total",
                    "\$${totalAmount.toStringAsFixed(2)}",
                    isTotal: true,
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
                    builder: (context) => PaymentSuccessfulScrren(),
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
                AppLocalizations.of(context)!.payNow,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Refined helper widget for summary rows
  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16, // Larger for Total
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black87 : Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? Colors.black87 : Colors.black87,
          ),
        ),
      ],
    );
  }

  // Refined TextField helper for modern look
  Widget _buildModernTextField(
    String label,
    IconData? icon, {
    String? hintText,
    TextInputType? keyboardType,
    bool isObscureText = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // More rounded corners
          borderSide: BorderSide(color: Colors.grey.shade300), // Lighter border
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
        prefixIcon:
            icon != null
                ? Icon(icon, color: Colors.grey.shade600)
                : null, // Icon color
        filled: true,
        fillColor: Colors.grey.shade50, // Light fill color
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ), // Adjust padding
      ),
      keyboardType: keyboardType,
      obscureText: isObscureText,
      style: TextStyle(color: Colors.black87, fontSize: 16),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
