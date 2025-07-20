import 'package:flutter/material.dart';
import 'package:frontend/widgets/app_primary_button.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import 'payment_successful_scrren.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatelessWidget {
  CheckOutScreen({super.key});

  final double transferAmount = 7.20;
  final double additionalCost = 0.50;

  @override
  Widget build(BuildContext context) {
    final double totalAmount = transferAmount + additionalCost;

    final appBar = AppBar(
      title: Text(AppLocalizations.of(context)!.payment),
      leading: const CustomBackButton(),
    );

    final Widget paymentButton = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PaymentSuccessfulScrren()),
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
          AppLocalizations.of(context)!.payNow,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );

    final Widget creditCardFormCard = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      color: Get.theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.creditPay,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Form(
              child: Column(
                children: [
                  _buildModernTextField(
                    AppLocalizations.of(context)!.cardHolderName,
                    Icons.person,
                  ),
                  const SizedBox(height: 16),
                  _buildModernTextField(
                    AppLocalizations.of(context)!.cardName,
                    Icons.credit_card,
                    hintText: '0000 0000 0000 0000',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
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
                          "CVV",
                          Icons.lock,
                          hintText: '000',
                          keyboardType: TextInputType.number,
                          isObscureText: true,
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
    );

    final Widget paymentSummaryCard = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      color: Get.theme.colorScheme.surface,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
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
            const Divider(height: 1, thickness: 1, color: Colors.grey),
            const SizedBox(height: 10),
            _buildSummaryRow(
              "Total",
              "\$${totalAmount.toStringAsFixed(2)}",
              isTotal: true,
            ),
          ],
        ),
      ),
    );

    final Widget bottomCard = Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 24, 16, 32),
        child: paymentButton,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            creditCardFormCard,
            const SizedBox(height: 24),
            paymentSummaryCard,
          ],
        ),
      ),
      bottomNavigationBar: AppPrimaryButton(
        text: AppLocalizations.of(context)!.payNow,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PaymentSuccessfulScrren()),
          );
        },
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

  Widget _buildModernTextField(
    String label,
    IconData icon, {
    String? hintText,
    TextInputType? keyboardType,
    bool isObscureText = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
      ),
      keyboardType: keyboardType,
      obscureText: isObscureText,
      style: const TextStyle(fontSize: 16),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
