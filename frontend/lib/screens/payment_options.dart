import 'package:flutter/material.dart';
import 'package:frontend/screens/payment_successful_scrren.dart';
import 'package:frontend/core/widgets/app_primary_button.dart';
import 'package:frontend/core/widgets/custom_back_button.dart';
import 'card_payment_screen.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:frontend/controllers/confirm_booking_controller.dart';

enum PaymentMethod { abaPay, acledaPay, creditCard }

class PaymentOptionsScreen extends StatefulWidget {
  const PaymentOptionsScreen({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentOptionsScreen> {
  PaymentMethod? _selectedPaymentMethod = PaymentMethod.abaPay;
  final BookingController bookingController = Get.put(BookingController());

  // final double transferAmount = 7.20;
  final String additionalCost = "0.50";

  @override
  Widget build(BuildContext context) {
    final String fullName = bookingController.fullName.value;
    final String phoneNumber = bookingController.phoneNumber.value;
    final String totalPrice = bookingController.totalPrice.value;
    final String fieldName = bookingController.selectedField.value;
    final String bookingDate = bookingController.bookingDate.value;
    final String bookingTime = bookingController.bookingTime.value;
    final double totalPriceDouble = double.tryParse(totalPrice) ?? 0.0;
    final double additionalCostDouble = double.tryParse(additionalCost) ?? 0.0;
    final double totalAmountDouble = totalPriceDouble + additionalCostDouble;
    final String totalAmount = totalAmountDouble.toStringAsFixed(2);

    final Widget summaryCard = Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      color: Get.theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.summaryInformation,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildSummaryInfo(AppLocalizations.of(context)!.name, fullName),
            _buildSummaryInfo(
              AppLocalizations.of(context)!.phoneNumber,
              phoneNumber,
            ),
            _buildSummaryInfo(AppLocalizations.of(context)!.date, bookingDate),
            _buildSummaryInfo(AppLocalizations.of(context)!.time, bookingTime),
            _buildSummaryInfo(AppLocalizations.of(context)!.field, fieldName),
          ],
        ),
      ),
    );

    final Widget paymentMethodsCard = Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      color: Get.theme.colorScheme.surface,
      child: Column(
        children: [
          _buildPaymentOption(
            context: context,
            title: "ABA Pay",
            subtitle: AppLocalizations.of(context)!.tapToPayWithABA,
            imagePath: "assets/images/aba_pay.png",
            value: PaymentMethod.abaPay,
          ),
          const Divider(height: 1),
          _buildPaymentOption(
            context: context,
            title: "ACLEDA Pay",
            subtitle: AppLocalizations.of(context)!.tapToPayWithACLEDA,
            imagePath: "assets/images/acleda.jpg",
            value: PaymentMethod.acledaPay,
          ),
          const Divider(height: 1),
          _buildPaymentOption(
            context: context,
            title: "Credit Card",
            subtitle: "+16006 **** 24",
            imagePath: "assets/images/visa_card.jpg",
            value: PaymentMethod.creditCard,
          ),
        ],
      ),
    );

    final Widget promoCodeCard = Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFFDD446),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            const SizedBox(width: 4),
            const Icon(Icons.confirmation_num_outlined, color: Colors.black87),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Promo Code",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Apply button pressed!")),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Apply",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );

    final Widget paymentSummaryCard = Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      color: Get.theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryRow(
              AppLocalizations.of(context)!.transferAmount,
              "\$$totalPrice",
            ),
            const SizedBox(height: 10),
            _buildSummaryRow(
              AppLocalizations.of(context)!.addCost,
              "\$$additionalCost",
            ),
            const SizedBox(height: 10),
            const Divider(height: 1, thickness: 1, color: Colors.grey),
            const SizedBox(height: 10),
            _buildSummaryRow(
              AppLocalizations.of(context)!.totalPrice,
              "\$$totalAmount",
              isTotal: true,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.paymentOptions),
        leading: const CustomBackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            summaryCard,
            const SizedBox(height: 12),
            paymentMethodsCard,
            const SizedBox(height: 24),
            // promoCodeCard,
            // const SizedBox(height: 24),
            paymentSummaryCard,
          ],
        ),
      ),
      // Your button
      bottomNavigationBar: AppPrimaryButton(
        text: AppLocalizations.of(context)!.checkOut,
        onPressed: () {
          if (_selectedPaymentMethod == PaymentMethod.creditCard) {
            // Go to CheckoutScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckOutScreen()),
            );
          } else if (_selectedPaymentMethod != null) {
            // Go to PaymentSuccessfulScreen for other methods
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentSuccessfulScrren(),
              ),
            );
          } else {
            // No method selected
            Get.snackbar(
              "Error",
              "Please select a payment method",
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        },
      ),
    );
  }

  Widget _buildSummaryInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String imagePath,
    required PaymentMethod value,
  }) {
    final bool isSelected = _selectedPaymentMethod == value;

    return InkWell(
      onTap: () => setState(() => _selectedPaymentMethod = value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Image.asset(imagePath, width: 40, height: 40, fit: BoxFit.contain),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            Radio<PaymentMethod>(
              value: value,
              groupValue: _selectedPaymentMethod,
              onChanged: (PaymentMethod? newValue) {
                setState(() => _selectedPaymentMethod = newValue);
              },
              activeColor: Get.theme.colorScheme.primary,
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
