import 'package:flutter/material.dart';
import 'package:thaaja/home_screen/Products/product_model.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/Subscription_model.dart';

class SubscriptionDetailsPage extends StatelessWidget {
  final ProductModel product;

  SubscriptionDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product.imageUrl,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "₹${product.price}",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              product.description ?? "No description available.",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // Handle subscription logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Subscribed to ${product.name}")),
                  );
                },
                child: Text("Subscribe Now", style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
