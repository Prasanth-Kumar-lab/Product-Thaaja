
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:thaaja/payment/OrderModel.dart';
import 'package:thaaja/payment/orderDatabaseHelper.dart';
import 'package:thaaja/payment/paymentController.dart';
import 'package:intl/intl.dart';

import '../CartController.dart';
import '../deep/SubscriptionPlans/GoldSubscription.dart';
import '../home_screen/Explore/Explore.dart';
import '../home_screen/HomePageScreen.dart';
import '../home_screen/SubscriptionProducts/subscribeproduct.dart';

class PaymentPage extends StatelessWidget {
  final List<Map<String, dynamic>> orderSummary;
  final double totalAmount;

  final PaymentController controller = Get.put(PaymentController());

  PaymentPage({
    super.key,
    required this.orderSummary,
    required this.totalAmount,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionWithEdit("Order Summary", onEdit: () {}),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemCount: orderSummary.length,
                      separatorBuilder: (_, __) => const Divider(height: 16),
                      itemBuilder: (context, index) {
                        final item = orderSummary[index];
                        return _orderItem(
                          item['name'],
                          '${item['quantity']} x \$${item['price'].toStringAsFixed(2)}',
                          type: item['type'],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  _priceRow("Total: \$${totalAmount.toStringAsFixed(2)}"),
                  const Divider(height: 30),
                  _sectionWithEdit("Payment Method", onEdit: () {}),
                  GestureDetector(
                    onTap: () => _showPaymentOptions(context),
                    child: Obx(() => _paymentMethodCard(
                      controller.selectedPaymentMethod.value == 'razorpay'
                          ? "Razorpay"
                          : "Cash on Delivery",
                      controller.selectedPaymentMethod.value == 'razorpay'
                          ? "Tap to pay securely"
                          : "Pay when delivered",
                    )),
                  ),
                  const SizedBox(height: 20),
                  _sectionTitle("Delivery Time"),
                  _deliveryTimeRow("Estimated Delivery", "25 mins"),
                  const SizedBox(height: 20),
                  _payNowButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 160,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        const Positioned(
          top: 80,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'Payment',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _sectionWithEdit(String title, {required VoidCallback onEdit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _sectionTitle(title),
        GestureDetector(
          onTap: onEdit,
          child: const Text(
            "Edit",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _orderItem(String name, String quantity, {String? type}) {
    final icon = type == 'subscription'
        ? Icons.repeat
        : type == 'grocery'
        ? Icons.local_grocery_store
        : Icons.shopping_cart;
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(width: 10),
        Expanded(child: Text(name, style: const TextStyle(fontSize: 14))),
        Text(quantity, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _priceRow(String totalPrice) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        totalPrice,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _paymentMethodCard(String method, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            method == "Razorpay" ? Icons.account_balance_wallet : Icons.money,
            color: Colors.green,
          ),
          const SizedBox(width: 10),
          Text(method, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _deliveryTimeRow(String label, String time) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(time,
              style: const TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
  Widget _payNowButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          final isCOD = controller.selectedPaymentMethod.value == 'cod';
          final orderId = controller.generateOrderId();

          if (isCOD) {
            _showPaymentSuccessDialog(context, orderId); // Show success dialog for COD
          } else {
            bool success = await controller.openCheckout(totalAmount);
            if (success) {
              final formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
                final order = OrderModel(orderId: orderId, totalAmount: totalAmount, timestamp: formattedDate);_showPaymentSuccessDialog(context, orderId); // Same dialog for Razorpay success
              await OrderDatabaseHelper().insertOrder(order);
            }
            else {
              Get.snackbar("Payment Failed", "Please try again.",
                  backgroundColor: Colors.red.shade100,
                  snackPosition: SnackPosition.BOTTOM);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text("Pay Now",
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }


  /*
  void _showPaymentSuccessDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150,
                  child: Lottie.asset('assets/payment_success.json', repeat: false,),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Order Placed',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Order ID: $orderId',
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Get.back(); // Navigate back if needed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Continue", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
   */

  void _showPaymentSuccessDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150,
                  child: Lottie.asset('assets/payment_success.json', repeat: false),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Order Placed',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Order ID: $orderId',
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Clear all cart data
                    final cartController = Get.find<CartController>();
                    final groceryController = Get.find<GroceryController>();
                    final subscriptionController = Get.find<SubscriptionProductController>();
                    final subController = Get.find<SubscriptionController>();

                    // Clear regular products
                    cartController.productCounts.clear();
                    cartController.attaCounts.clear();
                    cartController.dalPulsesCounts.clear();
                    cartController.riceCounts.clear();
                    cartController.kitchenItemsCounts.clear();
                    cartController.saveCartToStorage();

                    // Clear grocery items
                    groceryController.cartItems.clear();
                    groceryController.saveCartToStorage();

                    // Clear subscription items
                    subscriptionController.subscribedProducts.clear();
                    subscriptionController.update();

                    // Reset free quotas if subscription is active
                    if (subController.isSubscriptionActive) {
                      subController.usedVegetables.value = 0;
                      subController.usedFruits.value = 0;
                      subController.saveSubscription();
                    }

                    Navigator.of(context).pop(); // Close dialog
                    Get.offAll(() => HomePageScreen()); // Navigate to home and clear all routes
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Continue", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPaymentOptions(BuildContext context) {
    Get.bottomSheet(
      Obx(() => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            RadioListTile<String>(
              value: 'razorpay',
              activeColor: Colors.green,
              groupValue: controller.selectedPaymentMethod.value,
              onChanged: (val) =>
              controller.selectedPaymentMethod.value = val!,
              title: const Text("Razorpay"),
              secondary: const Icon(Icons.account_balance_wallet,
                  color: Colors.green),
            ),
            RadioListTile<String>(
              value: 'cod',
              activeColor: Colors.green,
              groupValue: controller.selectedPaymentMethod.value,
              onChanged: (val) =>
              controller.selectedPaymentMethod.value = val!,
              title: const Text("Cash on Delivery"),
              secondary: const Icon(Icons.money, color: Colors.brown),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text("Continue"),
            ),
          ],
        ),
      )),
      isDismissible: false,
      enableDrag: true,
    );
  }
}

