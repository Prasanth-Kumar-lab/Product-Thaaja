// allProductsPage.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thaaja/CartController.dart';
import 'package:thaaja/home_screen/Products/product_model.dart';
import 'package:thaaja/home_screen/Products/selling_section.dart';
class AllProductsPage extends StatelessWidget {
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
        itemCount: bestSellingProducts.length,
        itemBuilder: (context, index) {
          var product = bestSellingProducts[index];
          return buildBestSellingCard(product);
        },
      ),
    );
  }
}
