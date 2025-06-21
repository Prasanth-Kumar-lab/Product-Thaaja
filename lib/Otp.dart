/*import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:thaaja/CreatePassword.dart';
import 'package:thaaja/home_screen/HomePageScreen.dart';
import 'package:thaaja/login.dart';

class OtpScreen extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Prevents overflow
      body: Column(
        children: [
          // Stack for Background Image and Text
          Stack(
            children: [
              Container(
                height: screenHeight * 0.35,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/Onboarding1.png"),
                    opacity: 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.25,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Text(
                      "Enter Verification Code",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "We have sent SMS to : 01XXXXXXXX",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // OTP Input & Buttons
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      cursorColor: Colors.black,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 55,
                        fieldWidth: 55,
                        inactiveColor: Colors.grey.shade400,
                        activeColor: Colors.green,
                        selectedColor: Colors.green,
                        inactiveFillColor: Colors.white,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        if (value.length == 4) {
                          Get.to(() => HomePageScreen());
                        }
                      },
                    ),
                    SizedBox(height: 20),

                    // Resend OTP & Change Number
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.off(() => LoginScreen());
                      },
                      child: Text(
                        "Change Phone Number",
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Fixed Next Button at the Bottom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => HomePageScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Next", style: TextStyle(fontSize: 18, color: Colors.white)),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:thaaja/CreatePassword.dart';
import 'package:thaaja/home_screen/HomePageScreen.dart';
import 'package:thaaja/login.dart';

class OtpScreen extends StatefulWidget {
  final String otp; // Add OTP as a parameter
  final String phoneNumber;

  OtpScreen({required this.otp, required this.phoneNumber});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  // Function to verify the entered OTP
  void verifyOtp() {
    String enteredOtp = otpController.text.trim();
    if (enteredOtp == widget.otp) {
      Get.snackbar("Success", "OTP Verified Successfully");
      Get.to(() => HomePageScreen()); // Navigate to home page
    } else {
      Get.snackbar("Error", "Invalid OTP, please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Prevents overflow
      body: Column(
        children: [
          // Stack for Background Image and Text
          Stack(
            children: [
              Container(
                height: screenHeight * 0.35,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/Onboarding1.png"),
                    opacity: 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.25,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Text(
                      "Enter Verification Code",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "We have sent SMS to : ${widget.phoneNumber}",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // OTP Input & Buttons
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      cursorColor: Colors.black,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 55,
                        fieldWidth: 55,
                        inactiveColor: Colors.grey.shade400,
                        activeColor: Colors.green,
                        selectedColor: Colors.green,
                        inactiveFillColor: Colors.white,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        // We could also trigger OTP verification here, but we'll rely on the "Next" button
                      },
                    ),
                    SizedBox(height: 20),

                    // Resend OTP & Change Number
                    TextButton(
                      onPressed: () {
                        // Handle resend OTP functionality
                      },
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.off(() => LoginScreen()); // Go to the login screen if the user wants to change the number
                      },
                      child: Text(
                        "Change Phone Number",
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Fixed Next Button at the Bottom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ElevatedButton(
              onPressed: verifyOtp, // Trigger OTP verification on press
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Next", style: TextStyle(fontSize: 18, color: Colors.white)),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 */
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:thaaja/home_screen/HomePageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thaaja/login.dart';
class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  OtpScreen({required this.verificationId, required this.phoneNumber});
  @override
  _OtpScreenState createState() => _OtpScreenState();
}
class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Function to verify the entered OTP
  void verifyOtp() async {
    String enteredOtp = otpController.text.trim();
    if (enteredOtp.isNotEmpty) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: enteredOtp,
        );
        // Sign in with the credential
        await _auth.signInWithCredential(credential);
        Get.snackbar("Success", "OTP Verified Successfully");
        Get.to(() => HomePageScreen()); // Navigate to home page
      } catch (e) {
        Get.snackbar("Error", "Invalid OTP, please try again");
      }
    } else {
      Get.snackbar("Error", "Please enter the OTP");
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Prevents overflow
      body: Column(
        children: [
          // Stack for Background Image and Text
          Stack(
            children: [
              Container(
                height: screenHeight * 0.35,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/Onboarding1.png"),
                    opacity: 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.25,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Text(
                      "Enter Verification Code",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "We have sent SMS to: ${widget.phoneNumber}",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // OTP Input & Buttons
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,  // Adjusted length for OTP
                      cursorColor: Colors.black,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 55,
                        fieldWidth: 55,
                        inactiveColor: Colors.grey.shade400,
                        activeColor: Colors.green,
                        selectedColor: Colors.green,
                        inactiveFillColor: Colors.white,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        // Adjust spacing here
                        fieldOuterPadding: EdgeInsets.symmetric(horizontal: 3),
                      ),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 20), // Space between OTP and buttons

                    // Resend OTP & Change Number
                    TextButton(
                      onPressed: () {
                        // Handle resend OTP functionality
                      },
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.off(() => LoginScreen()); // Go to the login screen if the user wants to change the number
                      },
                      child: Text(
                        "Change Phone Number",
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Fixed Next Button at the Bottom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ElevatedButton(
              onPressed: verifyOtp, // Trigger OTP verification on press
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Next", style: TextStyle(fontSize: 18, color: Colors.white)),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

