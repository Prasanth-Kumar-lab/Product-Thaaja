import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thaaja/deep/SubscriptionPlans/GoldSubscription.dart';
import 'package:thaaja/deep/SubscriptionPlans/PlatinumSubscription.dart';
import 'package:thaaja/deep/SubscriptionPlans/SilverSubscription.dart';
class SubscriptionPlans extends StatefulWidget {
  const SubscriptionPlans({super.key});
  @override
  _SubscriptionPlansState createState() => _SubscriptionPlansState();
}
class _SubscriptionPlansState extends State<SubscriptionPlans> {
  // Variable to keep track of the selected item
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SubscriptionProducts Plans',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  categoryCard('Gold', Icons.grid_view, 0), // Gold Plan
                  categoryCard('Platinum', Icons.currency_exchange, 1), // Platinum Plan
                  categoryCard('Silver', CupertinoIcons.cart, 2), // Silver Plan
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget categoryCard(String title, IconData icon, int index) {
    // Determine whether this item is selected based on selectedIndex
    bool isSelected = selectedIndex == index;
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 1,
      child: GestureDetector(
        onTap: () {
          // Separate navigation based on the plan type
          if (title == 'Gold') {
            Get.to(() => GoldSubscription());
          } else if (title == 'Platinum') {
            Get.to(() => PlatinumSubscription());
          } else if (title == 'Silver') {
            Get.to(() => SilverSubscription());
          }
          setState(() {
            // Update selectedIndex to reflect which tile was tapped
            if (selectedIndex == index) {
              selectedIndex = null; // Deselect if the same tile is tapped
            } else {
              selectedIndex = index;
            }
          });
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green.shade100,
            child: Icon(icon, color: Colors.red),
          ),
          title: Text(title),
          tileColor: isSelected ? Colors.green[50] : null,  // Change background when selected
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isSelected ? Colors.green : Colors.transparent,  // Set border color based on selection
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}