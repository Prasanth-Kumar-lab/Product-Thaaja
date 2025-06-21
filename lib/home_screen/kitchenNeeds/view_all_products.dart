// allProductsPage.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thaaja/CartController.dart';
import 'package:thaaja/home_screen/Rice/product_model.dart';
import 'package:thaaja/home_screen/Rice/selling_section.dart';
import 'package:thaaja/home_screen/kitchenNeeds/product_model.dart';
import 'package:thaaja/home_screen/kitchenNeeds/selling_section.dart';
class AllKitchenItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>(); // Get the CartController instance
    return Scaffold(
      appBar: AppBar(title: Text('Products', style: TextStyle(fontWeight: FontWeight.bold))),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: bestSellingKitchenItems.length,
        itemBuilder: (context, index) {
          var kitchenItems = bestSellingKitchenItems[index];
          return buildBestKichenItemsCard(kitchenItems);
        },
      ),
    );
  }
}
