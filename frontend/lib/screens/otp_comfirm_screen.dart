import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:frontend/main.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:get/get.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.otpVerification,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.enterVerificationCode,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 32),

            // OTP Field
            PinCodeTextField(
              appContext: context,
              length: 4,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 60,
                fieldWidth: 60,
                activeColor: Colors.teal,
                selectedColor: Colors.teal,
                inactiveColor: Colors.grey.shade300,
              ),
              onChanged: (value) {},
              onCompleted: (code) {
                // Verify the code
              },
            ),

            const SizedBox(height: 32),

            // Verify Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.colorScheme.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.verify,
                  style: TextStyle(
                    fontSize: 16,
                    color: Get.theme.colorScheme.onSecondary,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Resend Text
            Center(
              child: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.didNotReceiveCode,
                  style: const TextStyle(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.resend,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w600,
                      ),
                      // You can attach a gesture recognizer here if needed
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
