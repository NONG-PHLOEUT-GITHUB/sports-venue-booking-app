// class PhoneAuthController extends GetxController {
//   var phoneNumber = "".obs;
//   var verificationId = "".obs;
//   var otpCode = "".obs;

//   // FirebaseAuth _auth = FirebaseAuth.instance;

//   // // Send OTP
//   // void sendOtp() async {
//   //   await _auth.verifyPhoneNumber(
//   //     phoneNumber: phoneNumber.value,
//   //     verificationCompleted: (PhoneAuthCredential credential) async {
//   //       await _auth.signInWithCredential(credential);
//   //       Get.snackbar("Success", "Phone number verified automatically");
//   //     },
//   //     verificationFailed: (FirebaseAuthException e) {
//   //       Get.snackbar("Error", e.message ?? "Verification failed");
//   //     },
//   //     codeSent: (String id, int? resendToken) {
//   //       verificationId.value = id;
//   //       Get.to(() => OtpScreen()); // Navigate to OTP screen
//   //     },
//   //     codeAutoRetrievalTimeout: (String id) {
//   //       verificationId.value = id;
//   //     },
//   //   );
//   // }

//   // // Verify OTP
//   // void verifyOtp() async {
//   //   try {
//   //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//   //       verificationId: verificationId.value,
//   //       smsCode: otpCode.value,
//   //     );
//   //     await _auth.signInWithCredential(credential);
//   //     Get.snackbar("Success", "Phone number verified!");
//   //     // Call Laravel API here for login/register
//   //   } catch (e) {
//   //     Get.snackbar("Error", "Invalid OTP");
//   //   }
//   // }
// }
