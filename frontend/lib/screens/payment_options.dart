import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart';
import 'card_payment_screen.dart'; // Assuming this leads to the payment confirmation
import 'package:frontend/l10n/app_localizations.dart'; // For localization

class PaymentOptionsScreen extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentOptionsScreen> {
  // Using an enum for clarity and type safety for selected payment method
  PaymentMethod? _selectedPaymentMethod =
      PaymentMethod.abaPay; // Default to ABA Pay

  // Dummy values for demonstration
  final double transferAmount = 7.20;
  final double additionalCost = 0.50;

  @override
  Widget build(BuildContext context) {
    // Calculate total
    final double totalAmount = transferAmount + additionalCost;

    return Scaffold(
      backgroundColor:
          Colors.grey.shade100, // Light grey background as per design
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.onSecondary,
        ), // Back button color
        title: Text(
          AppLocalizations.of(context)!.paymentOptions, // Original title
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.onSecondary,
          ),
        ),
        backgroundColor: AppColors.primary, // Original app bar color
        centerTitle: true, // Center title for a clean look
        elevation: 0, // No shadow
      ),
      body: SingleChildScrollView(
        // Use SingleChildScrollView for scrollability
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 20.0,
        ), // Overall padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(
                      context,
                    )!.summaryInformation, // Use localization for this text
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ), // Slightly larger and darker
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryInfo(
                    AppLocalizations.of(context)!.name,
                    'Basketball Court',
                  ),
                  _buildSummaryInfo(
                    AppLocalizations.of(context)!.date,
                    '02/28/2025',
                  ),
                  _buildSummaryInfo(
                    AppLocalizations.of(context)!.time,
                    '7AM - 9AM',
                  ),
                  _buildSummaryInfo(
                    AppLocalizations.of(context)!.duration,
                    '2 Hours',
                  ),
                  _buildSummaryInfo(
                    AppLocalizations.of(context)!.field,
                    'Field A, Field B',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Payment Methods Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  16.0,
                ), // Slightly more rounded
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
                  // ABA Pay Option
                  _buildPaymentOption(
                    context: context,
                    title: "ABA Pay",
                    subtitle:
                        AppLocalizations.of(
                          context,
                        )!.tapToPayWithABA, // Use localized string
                    imagePath:
                        "assets/images/aba_pay.png", // Ensure this path is correct
                    value: PaymentMethod.abaPay,
                  ),
                  // ACLEDA Pay Option (added as requested)
                  _buildPaymentOption(
                    context: context,
                    title: "ACLEDA Pay",
                    subtitle:
                        AppLocalizations.of(
                          context,
                        )!.tapToPayWithACLEDA, // You might need to add this to your app_localizations.dart
                    imagePath:
                        "assets/images/acleda.jpg", // Ensure this path is correct
                    value: PaymentMethod.acledaPay,
                  ),
                  // Credit Card (from Dribbble design)
                  _buildPaymentOption(
                    context: context,
                    title: "Credit Card",
                    subtitle: "+16006 **** 24",
                    imagePath:
                        "assets/images/visa_card.jpg", // Placeholder path
                    value: PaymentMethod.creditCard,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24), // Spacing between sections
            // Promo Code Section
            Container(
              decoration: BoxDecoration(
                color: const Color(
                  0xFFFDD446,
                ), // Golden yellow color from design
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.confirmation_num_outlined,
                    color: Colors.black87,
                  ), // Promo code icon
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Promo Code",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none, // No underline border
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  InkWell(
                    // Use InkWell for a ripple effect on tap
                    onTap: () {
                      // TODO: Implement promo code apply logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Apply button pressed!")),
                      );
                    },
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Match button corner radius
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Colors.black, // Dark button as per Dribbble design
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Apply",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Small space from right edge
                ],
              ),
            ),
            const SizedBox(height: 24), // Spacing
            // Payment Summary Section
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
                  MaterialPageRoute(builder: (context) => CheckOutScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.checkOut,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryInfo(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
      ), // Adjusted vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight:
                  isTotal
                      ? FontWeight.bold
                      : FontWeight.normal, // Label bold if total
              color: isTotal ? Colors.black87 : Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16, // Value larger if total
              fontWeight:
                  isTotal
                      ? FontWeight.bold
                      : FontWeight.w600, // Value bold/semi-bold
              color:
                  isTotal
                      ? AppColors.primary
                      : Colors.black87, // Total amount in primary color
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for payment options
  Widget _buildPaymentOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String imagePath,
    required PaymentMethod value,
  }) {
    return InkWell(
      // Use InkWell for a nice ripple effect on tap
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Image.asset(imagePath, width: 40), // Payment logo, adjusted size
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600, // Semi-bold
                      fontSize: 17,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Radio<PaymentMethod>(
              value: value,
              groupValue: _selectedPaymentMethod,
              onChanged: (PaymentMethod? newValue) {
                setState(() {
                  _selectedPaymentMethod = newValue;
                });
              },
              activeColor:
                  AppColors
                      .primary, // Changed radio button active color to green
              visualDensity:
                  VisualDensity.compact, // Make radio button slightly smaller
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for summary rows
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
}

// Define an enum for payment methods for better type safety
enum PaymentMethod { abaPay, acledaPay, creditCard }
