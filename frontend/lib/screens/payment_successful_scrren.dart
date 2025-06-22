import 'package:flutter/material.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/screens/layout.dart';
import 'package:frontend/l10n/app_localizations.dart';

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
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 30),
            CustomButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainLayout()),
                    (Route<dynamic> route) =>
                        false, // This clears all previous routes
                  );
                },
                text: AppLocalizations.of(context)!.returnHome),
          ],
        ),
      ),
    );
  }
}
