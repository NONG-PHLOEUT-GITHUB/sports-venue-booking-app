import 'package:flutter/material.dart';
import 'package:frontend/screens/layout.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:get/get.dart';

class PaymentSuccessfulScrren extends StatelessWidget {
  const PaymentSuccessfulScrren({super.key});

  @override
  Widget build(BuildContext context) {
    final saveButton = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainLayout()),
            (Route<dynamic> route) => false,
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
          AppLocalizations.of(context)!.returnHome,
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
        children: [saveButton],
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.paymentSuccess,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.paymentThankYou,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomContainer,
    );
  }
}
