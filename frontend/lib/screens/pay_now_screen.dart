import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart';
import 'payment_successful_scrren.dart';

class CheckOutScreen extends StatelessWidget {
  CheckOutScreen({super.key});

  final appBar = AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    title: Text(
      'Payment',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.onPrimary,
      ),
    ),
    backgroundColor: AppColors.primary,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        color: const Color.fromARGB(248, 236, 236, 236),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Summary Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            // Summary items
            summaryItem('Name :', 'Basketball Court'),
            summaryItem('Date :', '02/28/2025'),
            summaryItem('Time :', '7AM - 9AM'),
            summaryItem('Duration :', '2 Hours'),
            summaryItem('Field :', 'Field A, Field B'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total Amount to pay : ',
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
            SizedBox(
              height: 16,
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.onPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Credit Pay',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Form(
                        child: Column(
                      children: [
                        _buildTextField("Cardholder's Name", '', Icons.person),
                        SizedBox(
                          height: 10,
                        ),
                        _buildTextField(
                            "Card Name", '000 000 000', Icons.credit_card),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField("Expiry Date", 'MM/YYYY',
                                  Icons.calendar_today),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField("CVV", '000', Icons.lock),
                            ),
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ))
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
                  MaterialPageRoute(builder: (context) => PaymentSuccessfulScrren()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Pay Now",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}

Widget summaryItem(String label, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    child: Row(
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

Widget _buildTextField(
  String label,
  String? hint,
  IconData? icon,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null; // Return null if the input is valid
      },
    ),
  );
}
