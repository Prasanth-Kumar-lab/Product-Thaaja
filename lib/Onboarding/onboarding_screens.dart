import 'package:flutter/material.dart';
import 'package:get/get.dart';
class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Fresh groceries to your doorstep!",
      "description":
      "Get fresh groceries delivered straight to your doorstep—convenient, fast, and hassle-free!",
      "image": "assets/Onboarding1.png"
    },
    {
      "title": "Order Anytime, Anywhere",
      "description":
      "Shop for your favorite groceries 24/7 and get them delivered on time!",
      "image": "assets/Onboarding2.png"
    },
    {
      "title": "Fast & Secure Payments",
      "description":
      "We offer multiple secure payment options for a hassle-free shopping experience.",
      "image": "assets/Onboarding3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // PageView for Onboarding Screens
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              currentPage.value = index;
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Image.asset(
                      onboardingData[index]["image"]!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ClipPath(
                      clipper: CurvedBottomClipper(),
                      child: Container(
                        width: double.infinity,
                        height: screenHeight * 0.35,
                        color: Colors.white,
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              onboardingData[index]["title"]!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              onboardingData[index]["description"]!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                onboardingData.length,
                                    (i) => Obx(() {
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPage.value == i
                                          ? Colors.green
                                          : Colors.grey[300],
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (currentPage.value < onboardingData.length - 1) {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  Get.offAllNamed('/login');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              ),
                              child: Obx(() => Text(
                                currentPage.value == onboardingData.length - 1
                                    ? "Get Started"
                                    : "Next",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              )),
                            ),

                            TextButton(
                              onPressed: () {
                                Get.offAllNamed('/login');
                              },
                              child: Text(
                                "Skip",
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for the Curved Bottom Section
class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2, size.height, size.width, size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
