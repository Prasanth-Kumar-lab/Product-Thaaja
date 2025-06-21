import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thaaja/deep/SubscriptionPlans/Databalse_helper_items.dart';
import 'package:thaaja/home_screen/Explore/categories_model.dart';
import 'package:thaaja/payment/paymentController.dart';
import 'package:intl/intl.dart';

class SubscriptionController extends GetxController {
  var isSubscribed = false.obs;
  var planDays = 0.obs;
  var planPrice = 0.obs;
  var freeVegetables = 0.obs; // in grams
  var freeFruits = 0.obs;     // in grams
  var usedVegetables = 0.obs; // in grams
  var usedFruits = 0.obs;     // in grams
  var subscriptionEndDate = DateTime.now().obs;
  final box = GetStorage();
  var lastFreeOrderDate = DateTime.now().obs;
  var todayFreeOrderUsed = false.obs;

  String get userId => FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void onInit() {
    super.onInit();
    loadSubscription();
    checkSubscriptionValidity();
    checkDailyFreeOrder();
  }

  void checkDailyFreeOrder() {
    final now = DateTime.now();
    // Reset if it's a new day after 8:00 PM
    if (now.day != lastFreeOrderDate.value.day ||
        (now.hour >= 20 && !todayFreeOrderUsed.value)) {
      todayFreeOrderUsed.value = false;
      lastFreeOrderDate.value = now;
      saveSubscription();
    }
  }

  void checkSubscriptionValidity() {
    if (isSubscribed.value && DateTime.now().isAfter(subscriptionEndDate.value)) {
      resetSubscription();
    }
  }

  void loadSubscription() {
    if (userId.isEmpty) return;

    final subData = box.read('subscriptions_$userId');
    if (subData != null) {
      isSubscribed.value = subData['isSubscribed'] ?? false;
      planDays.value = subData['planDays'] ?? 0;
      planPrice.value = subData['planPrice'] ?? 0;
      freeVegetables.value = subData['freeVegetables'] ?? 0;
      freeFruits.value = subData['freeFruits'] ?? 0;
      usedVegetables.value = subData['usedVegetables'] ?? 0;
      usedFruits.value = subData['usedFruits'] ?? 0;

      // Parse the end date safely
      try {
        lastFreeOrderDate.value = DateTime.parse(subData['lastFreeOrderDate'] ?? DateTime.now().toIso8601String());
      } catch (e) {
        lastFreeOrderDate.value = DateTime.now();
      }
      todayFreeOrderUsed.value = subData['todayFreeOrderUsed'] ?? false;

      try {
        subscriptionEndDate.value = DateTime.parse(subData['subscriptionEndDate']);
      } catch (e) {
        subscriptionEndDate.value = DateTime.now();
      }

      // Check validity immediately after loading
      checkSubscriptionValidity();
    }
  }

  void saveSubscription() {
    if (userId.isEmpty) return;

    box.write('subscriptions_$userId', {
      'isSubscribed': isSubscribed.value,
      'planDays': planDays.value,
      'planPrice': planPrice.value,
      'freeVegetables': freeVegetables.value,
      'freeFruits': freeFruits.value,
      'usedVegetables': usedVegetables.value,
      'usedFruits': usedFruits.value,
      'subscriptionEndDate': subscriptionEndDate.value.toIso8601String(),
      'lastFreeOrderDate': lastFreeOrderDate.value.toIso8601String(),
      'todayFreeOrderUsed': todayFreeOrderUsed.value,
    });
  }

  int remainingWeight(String category) {
    if (!isSubscriptionActive) return 0;

    if (category == GroceryCategories.vegetables) {
      return freeVegetables.value - usedVegetables.value;
    } else if (category == GroceryCategories.fruits) {
      return freeFruits.value - usedFruits.value;
    }
    return 0;
  }

  void setSubscription({
    required int planDays,
    required int planPrice,
    required int freeVegetables,
    required int freeFruits,
  }) {
    isSubscribed.value = true;
    this.planDays.value = planDays;
    this.planPrice.value = planPrice;
    this.freeVegetables.value = freeVegetables;
    this.freeFruits.value = freeFruits;
    usedVegetables.value = 0;
    usedFruits.value = 0;
    subscriptionEndDate.value = DateTime.now().add(Duration(days: planDays));
    saveSubscription();
  }

  void resetSubscription() {
    isSubscribed.value = false;
    planDays.value = 0;
    planPrice.value = 0;
    freeVegetables.value = 0;
    freeFruits.value = 0;
    usedVegetables.value = 0;
    usedFruits.value = 0;
    saveSubscription();
  }

  bool get isSubscriptionActive =>
      isSubscribed.value && !DateTime.now().isAfter(subscriptionEndDate.value);



  bool canAddForFree(String category, int weight) {
    if (!isSubscribed.value) return false;

    // Check if it's before 8:00 PM and free order not used today
    final now = DateTime.now();
    if (now.hour >= 20 || todayFreeOrderUsed.value) {
      return false;
    }

    if (category == GroceryCategories.vegetables) {
      return (usedVegetables.value + weight) <= freeVegetables.value;
    } else if (category == GroceryCategories.fruits) {
      return (usedFruits.value + weight) <= freeFruits.value;
    }
    return false;
  }



  void updateUsedQuantity(String category, int weight) {
    final now = DateTime.now();
    if (now.hour < 20 && !todayFreeOrderUsed.value) {
      todayFreeOrderUsed.value = true;
      lastFreeOrderDate.value = now;
    }

    if (category == GroceryCategories.vegetables) {
      usedVegetables.value += weight;
    } else if (category == GroceryCategories.fruits) {
      usedFruits.value += weight;
    }
    saveSubscription();
    update();
  }

  String get subscriptionStatus {
    if (!isSubscribed.value) return "Not Subscribed";
    if (!isSubscriptionActive) return "Subscription Expired";
    final remainingDays = subscriptionEndDate.value.difference(DateTime.now()).inDays;
    return "Subscribed ($remainingDays days remaining)";
  }

  double calculatePriceForItem(GroceryItem item, int quantity) {
    if (!isSubscribed.value) return item.price * quantity;

    final now = DateTime.now();
    final isAfterCutoff = now.hour >= 20;
    final totalWeight = item.weight * quantity;

    if (item.category == GroceryCategories.vegetables) {
      if (usedVegetables.value >= freeVegetables.value ||
          todayFreeOrderUsed.value ||
          isAfterCutoff) {
        // Full price if no free quota available
        return item.price * quantity;
      } else if (usedVegetables.value + totalWeight <= freeVegetables.value) {
        // Completely free if within remaining quota
        return 0;
      } else {
        // Partially free (some items free, rest paid)
        final freeWeight = freeVegetables.value - usedVegetables.value;
        final paidQuantity = ((totalWeight - freeWeight) / item.weight).ceil();
        return paidQuantity * item.price;
      }
    }
    else if (item.category == GroceryCategories.fruits) {
      if (usedFruits.value >= freeFruits.value ||
          todayFreeOrderUsed.value ||
          isAfterCutoff) {
        // Full price if no free quota available
        return item.price * quantity;
      } else if (usedFruits.value + totalWeight <= freeFruits.value) {
        // Completely free if within remaining quota
        return 0;
      } else {
        // Partially free (some items free, rest paid)
        final freeWeight = freeFruits.value - usedFruits.value;
        final paidQuantity = ((totalWeight - freeWeight) / item.weight).ceil();
        return paidQuantity * item.price;
      }
    }

    // Full price for non-eligible categories
    return item.price * quantity;
  }

}

class GoldSubscription extends StatefulWidget {
  const GoldSubscription({super.key});

  @override
  _GoldSubscriptionState createState() => _GoldSubscriptionState();
}

class _GoldSubscriptionState extends State<GoldSubscription> {
  final subController = Get.find<SubscriptionController>();
  final user = FirebaseAuth.instance.currentUser;
  String? selectedDays = '7';
  final List<String> daysOptions = ['7', '15', '30', '45'];
  final Map<String, int> pricing = {
    '7': 499,
    '15': 799,
    '30': 1199,
    '45': 1499,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gold Subscription Plans',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.green[50]!,
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subController.isSubscriptionActive) ...[
                  _buildSubscriptionStatusCard(subController),
                  const SizedBox(height: 20),
                ] else ...[
                  if (!subController.isSubscriptionActive) ...[
                    const SizedBox(height: 20),
                    _buildSubscriptionOptions(subController),
                  ],

                ],
                const SizedBox(height: 20),
                _buildPremiumBanner(),
                const SizedBox(height: 20),

                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Items to be delivered with this plan:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildItemRow('Milk', '1 Litre'),
                        _buildItemRow('Eggs', '12 pieces'),
                        _buildItemRow('Bread', '500 gms'),
                        _buildItemRow('Vegetables', '2 kgs FREE'),
                        _buildItemRow('Fruits', '1.5 kgs FREE'),
                        _buildItemRow('Soft drink', '1 Litre'),
                        Align(
                          alignment: Alignment.center,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Your logic to add more items or show a list/modal
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.blue.shade900),
                            ),
                            icon: const Icon(Icons.add, color: Colors.blue),
                            label: const Text(
                              'More Items',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Plan Benefits:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildBenefitItem(Icons.check_circle, 'Daily fresh items delivery'),
                        _buildBenefitItem(Icons.check_circle, 'Premium quality products'),
                        _buildBenefitItem(Icons.check_circle, 'Flexible delivery schedule'),
                        _buildBenefitItem(Icons.check_circle, 'Exclusive member discounts'),
                        _buildBenefitItem(Icons.check_circle, 'Priority customer support'),
                        _buildBenefitItem(Icons.check_circle, 'Free delivery on all orders'),
                        _buildBenefitItem(Icons.check_circle, 'Early access to new products'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionStatusCard(SubscriptionController subController) {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              subController.isSubscriptionActive
                  ? 'Your Subscription Status'
                  : 'Subscription Plans',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),

            if (subController.isSubscriptionActive) ...[
              Text(
                'Plan: ${subController.planDays.value} Days',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                'Expires: ${DateFormat('MMM dd, yyyy').format(subController.subscriptionEndDate.value)}',
                style: const TextStyle(fontSize: 16),
              ),
            ] else ...[
              const Text(
                'You don\'t have an active subscription',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActiveSubscriptionCard(SubscriptionController subController) {
    final remainingDays = subController.subscriptionEndDate.value
        .difference(DateTime.now())
        .inDays;

    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Your Active Subscription',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$remainingDays days remaining',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Free Vegetables: ${subController.freeVegetables.value}g remaining',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Free Fruits: ${subController.freeFruits.value}g remaining',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionOptions(SubscriptionController subController) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green),
          ),
          child: DropdownButton<String>(
            value: selectedDays,
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
            items: daysOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text('$value Days Plan - ₹${pricing[value]}'),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedDays = newValue;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () async {
              final paymentController = Get.put(PaymentController());
              int? amount = pricing[selectedDays];

              if (amount != null) {
                bool success = await paymentController.openCheckout(amount.toDouble());

                if (success) {
                  subController.setSubscription(
                    planDays: int.parse(selectedDays!),
                    planPrice: amount,
                    freeVegetables: 5000, // 5kg vegetables
                    freeFruits: 5000,     // 5kg fruits
                  );

                  Get.snackbar(
                    "Subscription Successful!",
                    "You can now add free items as per your plan",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                }
              }
            },
            child: Text(
              'Subscribe Now - ₹${pricing[selectedDays]}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemRow(String item, String weight) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item, style: TextStyle(fontSize: 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(weight, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(width: 18),
              Icon(Icons.remove_circle, size: 25, color: Colors.red),
              SizedBox(width: 18),
              Icon(Icons.add_circle, size: 25, color: Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return Container(
      width: double.infinity,
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/Onboarding1.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black54,
            BlendMode.darken,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.amber,
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.star,
                color: Colors.amber,
                size: 30,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 20,
            child: Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red[700],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
              child: const Text(
                'LIMITED TIME',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                'GOLD MEMBERSHIP',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Vegetables - Upto 2kgs free',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Fruits - Upto 1kg free',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
