import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thaaja/ChatAndCall.dart';
import 'package:thaaja/Profile/addAddress.dart';
import 'dart:io';
import 'package:thaaja/Profile/calender.dart';
import 'package:thaaja/Profile/detaiilsPage.dart';
import 'package:thaaja/Profile/paymentMethods.dart';
import 'package:thaaja/deep/helpcenter.dart';
import 'package:thaaja/deep/settings_page.dart';
import 'package:thaaja/deep/SubscriptionPlans/subscriptionPlans.dart'; // For handling images
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thaaja/login.dart'; // Import Firebase Auth package

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController profileController = Get.put(ProfileController());

  File? _image; // To store the selected image
  bool _isLoading = false; // To show loading indicator
  String userName = '';
  bool isLoading = true;
  bool isGoogleUser = false; // To track whether the user is a Google user or phone number user

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  // Function to check if the user logged in via Google or Phone and fetch user data
  Future<void> _fetchUserName() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        isGoogleUser = user.providerData.any((userInfo) => userInfo.providerId == 'google.com');
        String documentId = isGoogleUser ? user.email! : user.phoneNumber!;

        DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('Customers').doc(documentId).get();

        if (snapshot.exists) {
          setState(() {
            userName = snapshot['name'] ?? 'User';
          });
        }

        // 🟢 Load image from local SQLite
        String? localImagePath = await LocalDBHelper.getImagePath();
        if (localImagePath != null && File(localImagePath).existsSync()) {
          setState(() {
            _image = File(localImagePath);
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to log out
  Future<void> _logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.snackbar("Logged Out", "You have been logged out successfully!");
      Get.offAll(() => LoginScreen()); // Assuming LoginScreen is your login page
    } catch (e) {
      print("Error logging out: $e");
      Get.snackbar("Error", "Failed to log out");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Obx(() {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: _image != null
                              ? FileImage(_image!)
                              : profileController.profileImage.value.isNotEmpty
                              ? NetworkImage(profileController.profileImage.value)
                              : AssetImage('assets/Profile.jpg') as ImageProvider,
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isLoading
                        ? 'Hello User' // Don't show userName while loading
                        : '$userName\n', // Displaying the user's name after fetching
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_isLoading)
                    CircularProgressIndicator(), // Show loading indicator while the image is being uploaded
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Divider(color: Colors.grey.shade300),
                  ProfileMenuItem("Orders", Icons.shopping_bag, TimeSelectionPage()),
                  Divider(color: Colors.grey.shade300),
                  ProfileMenuItem("My Details", Icons.person, DetailsPage()),
                  Divider(color: Colors.grey.shade300),
                  ProfileMenuItem("Delivery Address", Icons.location_on, AddAddressPage()),
                  Divider(color: Colors.grey.shade300),
                  ProfileMenuItem("SubscriptionProducts Plans", Icons.payment, SubscriptionPlans()),
                  Divider(color: Colors.grey.shade300),
                  ProfileMenuItem("Settings", Icons.settings, SettingsPage()),
                  Divider(color: Colors.grey.shade300),
                  ProfileMenuItem("Help", Icons.info, HelpCenterpage()),
                  Divider(color: Colors.grey.shade300),
                  ProfileMenuItem("Chat & Calls", Icons.info, ChatListScreen()),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _logOut, // Log out functionality when the button is pressed
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                      ),
                      child: Text("Log Out", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget page;

  ProfileMenuItem(this.title, this.icon, this.page);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Get.to(() => page);
      },
    );
  }
}


