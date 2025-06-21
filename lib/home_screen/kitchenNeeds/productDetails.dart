import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:thaaja/CartController.dart';
import 'package:thaaja/favouritePage.dart';
import 'package:thaaja/home_screen/Rice/product_model.dart';
import 'package:thaaja/home_screen/kitchenNeeds/product_model.dart';
class KitchenItemDetails extends StatelessWidget {
  final KitchenItems kitchenItems;
  const KitchenItemDetails({Key? key, required this.kitchenItems}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>(); // Get the CartController instance
    final favoriteController = Get.find<FavoriteController>(); // Get the FavoriteController instance
    return Scaffold(
      appBar: AppBar(
        title: Text(kitchenItems.name),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Obx(() {
              return Icon(
                favoriteController.isKitchenItemsFavorite(kitchenItems)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              );
            }),
            onPressed: () {
              favoriteController.toggleKitchenItemsFavorite(kitchenItems); // Toggle favorite
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(kitchenItems.imagePath),
                ),
                SizedBox(height: 20),
                Text(
                  kitchenItems.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          highlightColor: Colors.red.shade100,
                          onPressed: () {
                            cartController.decrementCountKitchenItems(kitchenItems);
                          },
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green, width: 1.5),
                          ),
                          child: Obx(() {
                            int count = cartController.getCountKitchenItems(kitchenItems);
                            double totalPrice = count * kitchenItems.price; // Calculate total price
                            return Row(
                              children: [
                                Text(
                                  '$count', // Display product count
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            );
                          }),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          highlightColor: Colors.green.shade100,
                          onPressed: () {
                            cartController.incrementCountKitchenItems(kitchenItems);
                          },
                        ),
                      ],
                    ),
                    Obx(() {
                      int count = cartController.getCountKitchenItems(kitchenItems);
                      // Calculate total price, show base price when count is 0
                      double totalPrice = count > 0 ? count * kitchenItems.price : kitchenItems.price;
                      return Text(
                        "\$${totalPrice.toStringAsFixed(2)}", // Display total price in the correct location
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Product Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Apples are nutritious. Apples may be good for weight loss. Apples may be good for your heart, as part of a healthy and varied diet.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFeatureCard(Icons.eco, "100% Organic"),
                    _buildFeatureCard(Icons.calendar_today, "1 Year Expiration"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFeatureCard(Icons.star, "4.8 Reviews"),
                    _buildFeatureCard(Icons.local_fire_department, "80 kcal 100g"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            // Add your checkout logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            "Add to Cart",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
  Widget _buildFeatureCard(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.green),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    );
  }
}


