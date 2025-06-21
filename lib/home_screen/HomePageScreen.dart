import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:thaaja/CartController.dart';
import 'package:thaaja/Profile/detaiilsPage.dart';
import 'package:thaaja/favouritePage.dart';
import 'package:thaaja/home_screen/Dal_Pulses/product_model.dart';
import 'package:thaaja/home_screen/Dal_Pulses/selling_section.dart';
import 'package:thaaja/home_screen/Dal_Pulses/view_all_products.dart';
import 'package:thaaja/home_screen/Explore/Explore.dart';
import 'package:thaaja/home_screen/Explore/Grocery_section.dart';
import 'package:thaaja/home_screen/Categories/categories_view.dart';
import 'package:thaaja/home_screen/Categories/category_model.dart';
import 'package:thaaja/home_screen/Products/product_model.dart';
import 'package:thaaja/home_screen/Products/selling_section.dart';
import 'package:thaaja/home_screen/Products/view_all_products.dart';
import 'package:thaaja/Profile/profilePage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:thaaja/home_screen/ProductsAtta/product_model.dart';
import 'package:thaaja/home_screen/ProductsAtta/selling_section.dart';
import 'package:thaaja/home_screen/ProductsAtta/view_all_products.dart';
import 'package:thaaja/home_screen/Rice/product_model.dart';
import 'package:thaaja/home_screen/Rice/selling_section.dart';
import 'package:thaaja/home_screen/Rice/view_all_products.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/Subscription_model.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/allSubscriptionCards.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/subscribeproduct.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/subscriptionSection.dart';
import 'package:thaaja/home_screen/kitchenNeeds/product_model.dart';
import 'package:thaaja/home_screen/kitchenNeeds/selling_section.dart';
import 'package:thaaja/home_screen/kitchenNeeds/view_all_products.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}
class _HomePageScreenState extends State<HomePageScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  bool showAll = false; // Tracks whether all products are displayed
  String _currentAddress = "Fetching location...";
  Position? _currentPosition;
  String userName = '';
  bool isLoading = true;
  bool isGoogleUser = false;
  bool showAllSubscription = false;
  int _currentCarouselIndex = 0; // Add this in your State class
  File? _image;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchUserName();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled. Please enable the services')),
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.'),
        ),
      );
      return false;
    }
    return true;
  }
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

  Future<void> _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });

      // Get address from coordinates
      await _getAddressFromLatLng(position);
    } catch (e) {
      debugPrint("Error getting location: $e");
      setState(() {
        _currentAddress = "Unable to fetch location";
      });
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        // Combine locality parts
        String location = [
          if (place.subLocality != null && place.subLocality!.isNotEmpty) place.subLocality,
          if (place.locality != null && place.locality!.isNotEmpty) place.locality,
          if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) place.administrativeArea,
        ].join(', ');

        // Truncate if too long
        if (location.length > 30) {
          location = location.substring(0, 30) + '...';
        }

        setState(() {
          _currentAddress = location;
        });
      } else {
        setState(() {
          _currentAddress = "Unknown location";
        });
      }
    } catch (e) {
      debugPrint("Error getting address: $e");
      setState(() {
        _currentAddress = "Couldn't get address";
      });
    }
  }


  String getGreetingMessage() {
    final indiaTimeZone = DateTime.now().toUtc().add(Duration(hours: 5, minutes: 30));
    final hour = indiaTimeZone.hour;

    if (hour < 12) {
      return 'Good morning,';
    } else if (hour < 17) {
      return 'Good afternoon,';
    } else {
      return 'Good evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    int maxVisibleItems = 4; // Default number of visible products
    final cartController = Get.find<CartController>(); // Get the CartController instance

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 120,
        backgroundColor: Colors.transparent, // Set to transparent for gradient
        automaticallyImplyLeading: false,
        leadingWidth: 70,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFEDF7F6), // Light teal
                Colors.greenAccent,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24), // You can adjust radius size
              bottomRight: Radius.circular(24),
            ),
          ),
        ),

        leading: Obx(() {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => ProfilePage());
              },
              child: CircleAvatar(
                radius: 24,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : profileController.profileImage.value.isNotEmpty
                    ? NetworkImage(profileController.profileImage.value)
                    : const AssetImage('assets/Profile.jpg') as ImageProvider,
              ),
            ),
          );
        }),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Text(
              getGreetingMessage(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            if (!isLoading)
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),*/
            Row(
              children: [
                Text(
                  getGreetingMessage(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                if (!isLoading)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                _getCurrentLocation();
              },
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 18, color: Colors.teal),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      _currentAddress,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.teal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Colors.teal),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Add an image to the left of the search icon
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/Thaaja App icon.jpg', // Replace with your asset path
                      width: 24,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.search, color: Colors.grey, size: 20),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal,
              ),
              child: IconButton(
                icon: const Icon(Icons.my_location, color: Colors.white, size: 22),
                onPressed: () {
                  _getCurrentLocation();
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            onPressed: () {
              Get.to(() => CartPage()); // Navigate to cart
            },
            backgroundColor: Colors.green,
            shape: CircleBorder(),
            child: Icon(
              CupertinoIcons.cart,
              size: 28,
              color: Colors.white,
            ),
          ),
          Positioned(
            right: -4,
            top: -4,
            child: Builder(builder: (context) {
              final cartController = Get.find<CartController>();
              final subscriptionController = Get.find<SubscriptionProductController>();
              final groceryController = Get.find<GroceryController>();

              return Obx(() {
                int cartItemCount = cartController.productCounts.values.fold(0, (sum, count) => sum + count);
                int subscriptionItemCount = subscriptionController.subscribedProducts.length;
                int groceryItemCount = groceryController.cartItems.values.fold(0, (sum, count) => sum + count);
                int attaItemCount = cartController.attaCounts.values.fold(0, (sum, count) => sum + count);
                int dalPulsesItemCount = cartController.dalPulsesCounts.values.fold(0, (sum, count) => sum + count);
                int riceItemCount = cartController.riceCounts.values.fold(0, (sum, count) => sum + count);
                int kitchenItemCount = cartController.kitchenItemsCounts.values.fold(0, (sum, count) => sum + count);

                int totalCount = cartItemCount + attaItemCount + dalPulsesItemCount+ riceItemCount+ kitchenItemCount+ subscriptionItemCount + groceryItemCount;

                return totalCount > 0
                    ? Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Center(
                    child: Text(
                      '$totalCount',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                    : SizedBox.shrink();
              });
            }),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Shop',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Get.to(() => HomePageScreen()); // Navigate to the HomePageScreen
              break;
            case 1:
              Get.to(() => ExplorePage()); // Navigate to the ExplorePage
              break;
            case 2:
              Get.to(() => FavoritePage()); // Navigate to the FavoritePage
              break;
            case 3:
              Get.to(() => ProfilePage()); // Navigate to the ProfilePage
              break;
          }
        },
      ),
      body: Container(
        //color: Colors.green.shade100,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 5,),
              Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 200,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCarouselIndex = index;
                        });
                      },
                    ),
                    items: [
                      'assets/Banner/Alternative medicine.jpg',
                      'assets/Banner/fresh and healthy.jpg',
                      'assets/Banner/Lunch ideas.png',
                      'assets/Banner/Quick and easy.png',
                      'assets/Banner/watch now.png',
                    ].map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentCarouselIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              // Categories Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    if (categories.length > maxVisibleItems)
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullCategoryPage(),
                            ),
                          );
                        },
                        child: Text('View more', style: TextStyle(color: Colors.green)),
                      ),
                  ],
                ),
              ),
              /*SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.take(4).map((category) => buildCategoryCard(category)).toList(),
                ),
              ),
               */
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) => buildCategoryCard(category)).toList(),
                ),
              ),
              // Best Selling Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Best Selling',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        // You can navigate to another page or show a snackbar here
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllProductsPage()),
                        );
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500, // Height to fit two vertical cards
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      (bestSellingProducts.length / 2).ceil(), // One column for every 2 products
                          (columnIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            width: 180,
                            child: Column(
                              children: List.generate(2, (rowIndex) {
                                int productIndex = columnIndex * 2 + rowIndex;
                                if (productIndex >= bestSellingProducts.length) return SizedBox();
                                var product = bestSellingProducts[productIndex];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: buildBestSellingCard(product),
                                );
                              }),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Subscription Products Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SubscriptionProducts Products',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    if (subscriptionProducts.length >= maxVisibleItems)
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AllSubscriptionProductsPage(subscriptionProducts: subscriptionProducts),
                            ),
                          );
                        },
                        child: Text(
                          "View More",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                  ],
                ),
              ),

              GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: showAllSubscription ? subscriptionProducts.length : maxVisibleItems,
                itemBuilder: (context, index) {
                  var product = subscriptionProducts[index];
                  return SubscriptionCard(product: product,);
                },
              ),
              SizedBox(height: 10,),

              // Atta Products
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Atta',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        // You can navigate to another page or show a snackbar here
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllAttaProductsPage()),
                        );
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500, // Height to fit two vertical cards
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      (bestSellingAttaProducts.length / 2).ceil(), // One column for every 2 products
                          (columnIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            width: 180,
                            child: Column(
                              children: List.generate(2, (rowIndex) {
                                int productIndex = columnIndex * 2 + rowIndex;
                                if (productIndex >= bestSellingAttaProducts.length) return SizedBox();
                                var atta = bestSellingAttaProducts[productIndex];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: buildBestAttaCard(atta),
                                );
                              }),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dal & Pulses',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        // You can navigate to another page or show a snackbar here
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllDalPulsesPage()),
                        );
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500, // Height to fit two vertical cards
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      (bestSellingDalPulses.length / 2).ceil(), // One column for every 2 products
                          (columnIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            width: 180,
                            child: Column(
                              children: List.generate(2, (rowIndex) {
                                int productIndex = columnIndex * 2 + rowIndex;
                                if (productIndex >= bestSellingDalPulses.length) return SizedBox();
                                var atta = bestSellingDalPulses[productIndex];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: buildBestDalPulseCard(atta),
                                );
                              }),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rice',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        // You can navigate to another page or show a snackbar here
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllRicePage()),
                        );
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500, // Height to fit two vertical cards
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      (bestSellingRice.length / 2).ceil(), // One column for every 2 products
                          (columnIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            width: 180,
                            child: Column(
                              children: List.generate(2, (rowIndex) {
                                int productIndex = columnIndex * 2 + rowIndex;
                                if (productIndex >= bestSellingRice.length) return SizedBox();
                                var rice = bestSellingRice[productIndex];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: buildBestRiceCard(rice),
                                );
                              }),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cooking needs',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllKitchenItems()),
                        );
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Display items in 2 columns, multiple rows (no scroll)
                Column(
                  children: List.generate(
                    (bestSellingKitchenItems.length / 2).ceil(),
                        (rowIndex) {
                      int firstIndex = rowIndex * 2;
                      int secondIndex = firstIndex + 1;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: buildBestKichenItemsCard(bestSellingKitchenItems[firstIndex]),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: secondIndex < bestSellingKitchenItems.length
                                  ? buildBestKichenItemsCard(bestSellingKitchenItems[secondIndex])
                                  : SizedBox(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          /*
          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cooking needs',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        // You can navigate to another page or show a snackbar here
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllKitchenItems()),
                        );
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500, // Height to fit two vertical cards
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      (bestSellingKitchenItems.length / 2).ceil(), // One column for every 2 products
                          (columnIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            width: 180,
                            child: Column(
                              children: List.generate(2, (rowIndex) {
                                int productIndex = columnIndex * 2 + rowIndex;
                                if (productIndex >= bestSellingKitchenItems.length) return SizedBox();
                                var kItems = bestSellingKitchenItems[productIndex];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: buildBestKichenItemsCard(kItems),
                                );
                              }),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
           */

          SizedBox(height: 10,),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black45,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          // Replace each Image.asset path with your own assets
                          _buildCard('https://tse3.mm.bing.net/th?id=OIP.rYHv5TUN9xUcHHO001DCQgHaE7&pid=Api&P=0&h=220', 'Fruits'),
                          _buildCard('http://www.allinharidwar.com/library/timthumb.php?src=/wp-content/uploads/2014/07/products-img.png&h=380&zc=0&q=80', 'Dairy'),
                          _buildCard('http://pluspng.com/img-png/vegetable-png-vegetable-png-photos-1600.png','Vegetables' ),
                          _buildCard('https://clipground.com/images/drinks-png-11.png', 'Soft drinks'),
                          _buildCard('https://www.mhfoods.in/images/pooja-samagri-product.png', 'Pooja Items'),
                          _buildCard('https://ahaliaayurvedic.org/college/wp-content/uploads/sites/3/2020/07/bams-png.png', 'Ayurvedic'),
                          // Add more if needed
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30,),

              _buildContainerWithTextsAndImage()
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildContainerWithTextsAndImage() {
    return Container(
      width: double.infinity,  // Full screen width
      height: 210,             // Fixed height of 200
      color: Colors.transparent, // Background color (optional)
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,  // Center the column
        children: [
          Text(
            'Shop your monthly products\n and save extra',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade400),
            textAlign: TextAlign.center,  // Center align text
          ),
          SizedBox(height: 20),  // Add space between the first text and the image
          Center(
            child: Align(
              alignment: Alignment.bottomRight,  // Align image to the right end
              child: Image.network(
                'https://pngimg.com/uploads/shopping_cart/shopping_cart_PNG50.png', // Your image URL
                width: 140,  // Set width of the image
                height: 80, // Set height of the image
                fit: BoxFit.contain, // Image fit
              ),
            ),
          ),
          SizedBox(height: 10),  // Add space between the image and the second text
          Text(
            '❤️ from India',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String assetPath, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 250,
          height: 91,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.network(
                assetPath,
                width: double.infinity,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

}

