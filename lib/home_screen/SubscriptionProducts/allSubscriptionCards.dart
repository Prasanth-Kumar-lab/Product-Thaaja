import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thaaja/CartController.dart';
import 'package:thaaja/home_screen/Products/product_model.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/subscriptionSection.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/SubscriptionDetailsPage.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/Subscription_model.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/allSubscriptionCards.dart'; // Where your buildSubscriptionCard is

class AllSubscriptionProductsPage extends StatelessWidget {
  final List<ProductModel> subscriptionProducts;

  AllSubscriptionProductsPage({required this.subscriptionProducts});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('All SubscriptionProducts Products', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: subscriptionProducts.length,
        itemBuilder: (context, index) {
          var product = subscriptionProducts[index];
          return SubscriptionCard(product: product,);
        },
      ),
    );
  }

}

