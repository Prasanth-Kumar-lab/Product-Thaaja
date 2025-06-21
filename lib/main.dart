import 'package:flutter/material.dart';
/*
import 'package:get/get.dart';
import 'package:thaaja/Onboarding/onboarding_screens.dart';
import 'package:thaaja/login.dart';
import 'package:thaaja/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this import
import 'firebase_options.dart'; // This will be generated

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for Firebase initialization

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thaaja/CartController.dart';
import 'package:thaaja/Onboarding/onboarding_screens.dart';
import 'package:thaaja/favouritePage.dart';
import 'package:thaaja/login.dart';
import 'package:thaaja/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this import
import 'firebase_options.dart'; // This will be generated

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for Firebase initialization

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteController());
    Get.put(CartController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
      ],
    );
  }
}
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thaaja/CartController.dart';
import 'package:thaaja/Onboarding/onboarding_screens.dart';
import 'package:thaaja/deep/SubscriptionPlans/GoldSubscription.dart';
import 'package:thaaja/favouritePage.dart';
import 'package:thaaja/home_screen/Explore/Explore.dart';
import 'package:thaaja/home_screen/HomePageScreen.dart'; // Import the HomePageScreen
import 'package:thaaja/home_screen/SubscriptionProducts/subscribeproduct.dart';
import 'package:thaaja/login.dart';
import 'package:thaaja/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase initialization
import 'package:firebase_auth/firebase_auth.dart'; // Firebase authentication import
import 'firebase_options.dart'; // Firebase options import
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding before initializing Firebase
  await GetStorage.init();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check if the user is already logged in
  User? user = FirebaseAuth.instance.currentUser;

  runApp(MyApp(user: user)); // Pass the current user to the MyApp widget
}

class MyApp extends StatelessWidget {
  final User? user;

  MyApp({required this.user});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    Get.put(FavoriteController());
    Get.put(CartController());
    Get.put(SubscriptionProductController());
    Get.put(GroceryController());
    Get.put(SubscriptionController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: user != null ? '/home' : '/splash', // Navigate based on user authentication
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomePageScreen()), // Direct route to HomePageScreen
      ],
    );
  }
}
