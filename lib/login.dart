/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thaaja/Otp.dart';
import 'package:thaaja/home_screen/HomePageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isOtpLoading = false;  // Track OTP loading state
  bool isGoogleLoading = false;  // Track Google sign-in loading state

  // Function to send OTP via Firebase
  void sendOtp(String phoneNumber) async {
    setState(() {
      isOtpLoading = true; // Set OTP loading to true when the process starts
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Get.snackbar("OTP Verified", "Successfully logged in");
        Get.to(() => HomePageScreen());
        setState(() {
          isOtpLoading = false; // Set OTP loading to false when process is done
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar("Error", e.message ?? "Failed to send OTP");
        setState(() {
          isOtpLoading = false; // Set OTP loading to false on error
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.to(() => OtpScreen(verificationId: verificationId, phoneNumber: phoneNumber));
        setState(() {
          isOtpLoading = false; // Set OTP loading to false when code is sent
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // Google Sign In Function
  Future<void> _signInWithGoogle() async {
    setState(() {
      isGoogleLoading = true; // Set Google loading to true when the process starts
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() {
          isGoogleLoading = false;
        });
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        Get.offAll(() => HomePageScreen());
        Get.snackbar("Success", "Signed in as ${user.displayName}");
      }
      setState(() {
        isGoogleLoading = false; // Set Google loading to false when process is complete
      });
    } catch (e) {
      Get.snackbar("Error", "Failed to sign in with Google");
      setState(() {
        isGoogleLoading = false; // Set Google loading to false on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Section
            Image.asset(
              "assets/login page.png",
              width: double.infinity,
              height: screenHeight * 0.4,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            // Title
            Text(
              "Get your groceries with\nnectar",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Phone Number Input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: CountryCodePicker(
                    onChanged: (code) {},
                    initialSelection: 'IN',
                    favorite: ['+91', 'IN'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    enabled: false,
                    alignLeft: false,
                  ),
                  hintText: "Enter mobile number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Send OTP Button with fixed size
            SizedBox(
              width: 160, // Ensures the button takes full width
              height: 50, // Fixed height
              child: ElevatedButton(
                onPressed: () {
                  String phoneNumber = phoneController.text.trim();
                  if (phoneNumber.isNotEmpty) {
                    if (!phoneNumber.startsWith('+')) {
                      phoneNumber = '+91$phoneNumber'; // Defaulting to +91 for India
                    }
                    sendOtp(phoneNumber); // Send OTP when button is pressed
                  } else {
                    Get.snackbar("Error", "Please enter a valid phone number");
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: isOtpLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Send Otp', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:thaaja/Otp.dart';
import 'package:thaaja/home_screen/HomePageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isOtpLoading = false;

  void sendOtp(String phoneNumber) async {
    setState(() => isOtpLoading = true);

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Get.snackbar("OTP Verified", "Successfully logged in");
        Get.to(() => HomePageScreen());
        setState(() => isOtpLoading = false);
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar("Error", e.message ?? "Failed to send OTP");
        setState(() => isOtpLoading = false);
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.to(() => OtpScreen(verificationId: verificationId, phoneNumber: phoneNumber));
        setState(() => isOtpLoading = false);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Top Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: screenHeight * 0.4,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/login page.png",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.green.withOpacity(0.4), // Green overlay with opacity
                  ),
                ],
              ),
            ),
          ),
          // Bottom Card
          Positioned(
            top: screenHeight * 0.33,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Get your groceries with nectar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    "Enter your phone number to receive an OTP.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    height: 120,//120
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Road-themed GIF (background)
                        Image.asset(
                          'assets/rider.gif', // Road animation GIF
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        // App Icon Image (foreground)
                        /*Image.asset(
                          "assets/Splash.png",
                          fit: BoxFit.contain,
                          height: 80, // You can tweak this size
                        ),*/
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        CountryCodePicker(
                          onChanged: (code) {},
                          initialSelection: 'IN',
                          favorite: ['+91'],
                          enabled: false,
                          showCountryOnly: false,
                        ),
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Mobile Number",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // OTP Button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.green[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      String phone = phoneController.text.trim();
                      if (phone.isNotEmpty) {
                        if (!phone.startsWith('+')) phone = '+91$phone';
                        sendOtp(phone);
                      } else {
                        Get.snackbar("Error", "Enter a valid phone number");
                      }
                    },
                    icon: isOtpLoading
                        ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                        : Icon(Icons.delivery_dining,color: Colors.greenAccent,size: 40,),
                    label: Text(
                      isOtpLoading ? "Sending OTP..." : "Send OTP",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


