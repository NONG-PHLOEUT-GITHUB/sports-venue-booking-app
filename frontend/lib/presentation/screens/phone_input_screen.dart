import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthController extends GetxController {
  var phoneNumber = "".obs;
  var verificationId = "".obs;
  var otpCode = "".obs;

  // FirebaseAuth _auth = FirebaseAuth.instance;

  // // Send OTP
  // void sendOtp() async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber.value,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await _auth.signInWithCredential(credential);
  //       Get.snackbar("Success", "Phone number verified automatically");
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       Get.snackbar("Error", e.message ?? "Verification failed");
  //     },
  //     codeSent: (String id, int? resendToken) {
  //       verificationId.value = id;
  //       Get.to(() => OtpScreen()); // Navigate to OTP screen
  //     },
  //     codeAutoRetrievalTimeout: (String id) {
  //       verificationId.value = id;
  //     },
  //   );
  // }

  // // Verify OTP
  // void verifyOtp() async {
  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId.value,
  //       smsCode: otpCode.value,
  //     );
  //     await _auth.signInWithCredential(credential);
  //     Get.snackbar("Success", "Phone number verified!");
  //     // Call Laravel API here for login/register
  //   } catch (e) {
  //     Get.snackbar("Error", "Invalid OTP");
  //   }
  // }
}

// ======================= UI ========================
class PhoneNumberScreen extends StatelessWidget {
  final PhoneAuthController controller = Get.put(PhoneAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Number Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Enter Phone Number"),
              onChanged: (val) => controller.phoneNumber.value = val,
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () => controller.sendOtp(),
            //   child: Text("Send OTP"),
            // ),
          ],
        ),
      ),
    );
  }
}