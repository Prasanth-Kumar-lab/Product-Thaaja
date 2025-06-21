import 'package:flutter/material.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/SubscriptionDetailsPage.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/Subscription_model.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/subscribeproduct.dart';
Widget buildSubscriptionCard(ProductModel product, BuildContext context) {
  return SubscriptionCard(product: product);
}
class SubscriptionCard extends StatelessWidget {
  final ProductModel product;

  const SubscriptionCard({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SubscriptionDetailsPage(product: product),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.green, width: 2),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Center(
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "₹${product.price}",
                style: TextStyle(color: Colors.green),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // Navigate to SubscriptionDetailsPage instead of showing SnackBar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubscriptionProduct(product: product),
                      ),
                    );
                  },
                  child: Text("Subscribe Now"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
