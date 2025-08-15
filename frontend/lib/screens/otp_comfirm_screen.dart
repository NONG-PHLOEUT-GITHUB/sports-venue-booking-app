import 'package:flutter/material.dart';
import 'package:frontend/screens/layout.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:get/get.dart';

class OtpVerificationPage extends StatelessWidget {
final String token;
  const OtpVerificationPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isLocalizationsAvailable = localizations != null;

    final Color primaryColor = Get.theme.colorScheme.primary;
    final Color secondaryColor = const Color(
      0xFF03DAC6,
    ); // Use a consistent secondary color
    final Color textColor = Colors.black87;
    final Color hintColor = Colors.black45;
    final double borderRadius = 16;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, // Make AppBar transparent
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Use stretch for full width elements
          children: [
            Text(
              isLocalizationsAvailable
                  ? localizations.otpVerification
                  : 'OTP Verification',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              isLocalizationsAvailable
                  ? localizations.enterVerificationCode
                  : 'Enter the verification code sent to your phone number.',
              style: TextStyle(color: hintColor, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // OTP Field
            PinCodeTextField(
              appContext: context,
              length: 6,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(borderRadius),
                fieldHeight: 56,
                fieldWidth: 48,
                inactiveFillColor: Colors.white,
                selectedFillColor: Colors.white,
                activeFillColor: Colors.white,
                selectedColor: primaryColor,
                inactiveColor: Colors.grey.shade300,
                activeColor: primaryColor,
                borderWidth: 2,
              ),
              animationDuration: const Duration(milliseconds: 300),
              controller: TextEditingController(),
              onChanged: (value) {},
              onCompleted: (code) {
                // TODO: Verify the code
              },
            ),

            const SizedBox(height: 40),

            // Verify Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainLayout()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  isLocalizationsAvailable ? localizations.verify : 'Verify',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Resend Text
            Center(
              child: Text.rich(
                TextSpan(
                  text:
                      isLocalizationsAvailable
                          ? localizations.didNotReceiveCode
                          : 'Didn\'t receive the code? ',
                  style: TextStyle(color: hintColor, fontSize: 14),
                  children: [
                    TextSpan(
                      text:
                          isLocalizationsAvailable
                              ? localizations.resend
                              : 'Resend',
                      style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                      // You can attach a gesture recognizer here
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
