import 'package:flutter/material.dart';
import 'package:frontend/screens/layout.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/widgets/app_primary_button.dart';

class PaymentSuccessfulScrren extends StatelessWidget {
  const PaymentSuccessfulScrren({super.key});

  @override
  Widget build(BuildContext context) {

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
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppPrimaryButton(
        text: AppLocalizations.of(context)!.returnHome,
           onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainLayout()),
            (Route<dynamic> route) => false,
          );
        },
      ),
    );
  }
}
