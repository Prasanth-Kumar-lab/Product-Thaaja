// best_selling_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:thaaja/CartController.dart';
import 'package:thaaja/favouritePage.dart';
import 'package:thaaja/home_screen/Dal_Pulses/productDetails.dart';
import 'package:thaaja/home_screen/Dal_Pulses/product_model.dart';
Widget buildBestDalPulseCard(ProductDalPulses dalPulses) {
  return BestDalPulseCard(dalPulses: dalPulses);
}
class BestDalPulseCard extends StatelessWidget {
  final ProductDalPulses dalPulses;
  const BestDalPulseCard({Key? key, required this.dalPulses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>(); // Get the CartController instance
    return GestureDetector(
      onTap: () {
        // Navigate to ProductDetails
        Get.to(() => DalPulsesDetails(dalPulses: dalPulses,));
      },
      child: Card(
        color:Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.green, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 70,
                    child: Image.network(dalPulses.imagePath),
                  ),
                  SizedBox(height: 8),
                  Text(
                    dalPulses.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Obx(() {
                    int count = cartController.getCountDalPulses(dalPulses);
                    double totalPrice = count * dalPulses.price; // Calculate total price
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          count == 0
                              ? "\$${dalPulses.price.toStringAsFixed(2)}" // Default price when count is 0
                              : "\$${totalPrice.toStringAsFixed(2)}", // Display total price when count > 0
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        count == 0
                            ? GestureDetector(
                          onTap: () {
                            cartController.incrementCountDalPulses(dalPulses);
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add, size: 18, color: Colors.green),
                          ),
                        )
                            : Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                cartController.decrementCountDalPulses(dalPulses);
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.remove, size: 18, color: Colors.red),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.green,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                "$count",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                cartController.incrementCountDalPulses(dalPulses);
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add, size: 18, color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ],
              ),
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () {
                    final favoriteController = Get.find<FavoriteController>();
                    favoriteController.toggleDalFavorite(dalPulses); // Toggle favorite
                  },
                  child: Obx(() {
                    return Icon(
                      Get.find<FavoriteController>().isDalFavorite(dalPulses)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                      size: 20,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
