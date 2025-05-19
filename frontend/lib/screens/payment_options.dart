import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart';
import 'pay_now_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentScreen> {
  String selectedPayment = "ABA Pay";

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required String imagePath,
    required String value,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              selectedPayment == value ? Colors.green.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                selectedPayment == value ? Colors.green : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, width: 60), // Payment logo
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 5),
                subtitleWidget(subtitle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget subtitleWidget(String subtitle) {
    // Check if the subtitle is an image
    if (subtitle.endsWith(".png") ||
        subtitle.endsWith(".jpg") ||
        subtitle.endsWith(".jpeg")) {
      return Image.asset(subtitle, width: 100, height: 15, fit: BoxFit.cover);
    } else {
      // If not an image, return a Text widget
      return Text(
        subtitle,
        style: TextStyle(fontSize: 14, color: Colors.grey),
      );
    }
  }

  Widget build(BuildContext context) {
    final appBar = AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        AppLocalizations.of(context)!.paymentOptions,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.onSecondary,
        ),
      ),
      backgroundColor: AppColors.primary,
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        color: const Color.fromARGB(248, 236, 236, 236), // Set background color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                AppLocalizations.of(context)!.summaryInformation,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            // Summary items
            summaryItem(AppLocalizations.of(context)!.name, 'Basketball Court'),
            summaryItem(AppLocalizations.of(context)!.date, '02/28/2025'),
            summaryItem(AppLocalizations.of(context)!.time, '7AM - 9AM'),
            summaryItem(AppLocalizations.of(context)!.duration, '2 Hours'),
            summaryItem(
                AppLocalizations.of(context)!.field, 'Field A, Field B'),

            // const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.totalAmountToPay,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '\$ 10.00',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              // This ensures the container occupies remaining space
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255,
                      255), // Background for the payment options section
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        AppLocalizations.of(context)!.pleaseSelectPayment,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      // Wrap payment options in another Expanded
                      child: ListView(
                        children: [
                          _buildPaymentOption(
                            title: "ABA Pay",
                            subtitle:
                                AppLocalizations.of(context)!.tapToPayWithABA,
                            imagePath: "assets/images/aba_pay.png",
                            value: "ABA Pay",
                          ),
                          _buildPaymentOption(
                            title: "KHQR",
                            subtitle:
                                AppLocalizations.of(context)!.tapToPayWithKHQR,
                            imagePath: "assets/images/khqr.png",
                            value: "KHQR",
                          ),
                          _buildPaymentOption(
                            title: "Credit/Debit card",
                            subtitle: "assets/images/master_card.png",
                            imagePath: "assets/images/visa_card.jpg",
                            value: "Credit/Debit card",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
              child: Text(AppLocalizations.of(context)!.checkOut,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }

  Widget summaryItem(String label, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
              width: 8), // Add some space between label and description
          Text(
            description,
            style: const TextStyle(
                fontSize: 16, color: Colors.grey), // Gray color for description
          ),
        ],
      ),
    );
  }
}
