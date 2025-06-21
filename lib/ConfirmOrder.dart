import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:thaaja/CartController.dart';
import 'package:thaaja/Profile/addAddress.dart';
import 'package:thaaja/deep/SubscriptionPlans/GoldSubscription.dart';
import 'package:thaaja/home_screen/Explore/Explore.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/subscribeproduct.dart';
import 'package:thaaja/payment/PaymentPage.dart';
import 'package:thaaja/home_screen/Products/productDetails.dart';
import 'package:thaaja/home_screen/Products/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thaaja/home_screen/Explore/categories_model.dart';
import 'package:thaaja/home_screen/ProductsAtta/product_model.dart' as atta;
import 'package:thaaja/home_screen/Dal_Pulses/product_model.dart' as dalPulses;
import 'package:thaaja/home_screen/Rice/product_model.dart' as rice;
import 'package:thaaja/home_screen/kitchenNeeds/product_model.dart';

class ConfirmOrderPage extends StatelessWidget {
  ConfirmOrderPage({Key? key}) : super(key: key);
  final cartController = Get.find<CartController>();
  final subscriptionController = Get.find<SubscriptionProductController>();
  final groceryController = Get.find<GroceryController>();
  final subController = Get.find<SubscriptionController>();

  Future<Map<String, dynamic>> _getAddress() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not authenticated');
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(user.phoneNumber ?? user.email)
          .get();
      if (!snapshot.exists) return {};
      return snapshot.data() as Map<String, dynamic>;
    } catch (e) {
      print('Error fetching address: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: const Text("Confirm Order", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getAddress(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final addressData = snapshot.data?['address'] ?? {};
          final houseNumber = addressData['hNo']?.toString() ?? '';
          final addressLine = addressData['address']?.toString() ?? '';
          final area = addressData['area']?.toString() ?? '';
          final city = addressData['city']?.toString() ?? '';
          final nearbyLocation = addressData['nearbyLocation']?.toString() ?? '';
          final currentLocation = addressData['currentLocation']?.toString() ?? '';

          return Obx(() {
            // Get all products from different sections
            final productsInCart = cartController.productCounts.keys
                .map((id) => bestSellingProducts.firstWhere((p) => p.id == id))
                .where((product) => cartController.getCount(product) > 0)
                .toList();

            final subscribedItems = subscriptionController.subscribedProducts;

            // Get grocery items
            final allCategoryItems = groceryController.categorizedItems.values.expand((list) => list).toList();
            final groceryItemsInCart = groceryController.cartItems.keys
                .map((id) => allCategoryItems.firstWhereOrNull((item) => item.id == id))
                .whereType<GroceryItem>()
                .toList();

            // Get atta products
            final attaItemsInCart = cartController.attaCounts.keys
                .map((id) => atta.bestSellingAttaProducts.firstWhere((p) => p.id == id))
                .where((product) => cartController.getCountAtta(product) > 0)
                .toList();

            // Get dal & pulses products
            final dalPulsesItemsInCart = cartController.dalPulsesCounts.keys
                .map((id) => dalPulses.bestSellingDalPulses.firstWhere((p) => p.id == id))
                .where((product) => cartController.getCountDalPulses(product) > 0)
                .toList();

            // Get rice products
            final riceItemsInCart = cartController.riceCounts.keys
                .map((id) => rice.bestSellingRice.firstWhere((p) => p.id == id))
                .where((product) => cartController.getCountRice(product) > 0)
                .toList();

            // Get kitchen items
            final kitchenItemsInCart = cartController.kitchenItemsCounts.keys
                .map((id) => bestSellingKitchenItems.firstWhere((p) => p.id == id))
                .where((product) => cartController.getCountKitchenItems(product) > 0)
                .toList();

            // Calculate subtotals
            double cartSubtotal = productsInCart.fold(
              0.0,
                  (total, product) => total + cartController.getCount(product) * product.price,
            );

            double subscriptionTotal = subscriptionController.totalSubscriptionPrice;
            double grocerySubtotal = groceryController.calculateTotalPrice();

            double attaSubtotal = attaItemsInCart.fold(
              0.0,
                  (total, product) => total + cartController.getCountAtta(product) * product.price,
            );

            double dalPulsesSubtotal = dalPulsesItemsInCart.fold(
              0.0,
                  (total, product) => total + cartController.getCountDalPulses(product) * product.price,
            );

            double riceSubtotal = riceItemsInCart.fold(
              0.0,
                  (total, product) => total + cartController.getCountRice(product) * product.price,
            );

            double kitchenItemsSubtotal = kitchenItemsInCart.fold(
              0.0,
                  (total, product) => total + cartController.getCountKitchenItems(product) * product.price,
            );

            double taxAndFees = 3.0;
            double delivery = 5.0;
            double total = cartSubtotal + subscriptionTotal + grocerySubtotal +
                attaSubtotal + dalPulsesSubtotal + riceSubtotal +
                kitchenItemsSubtotal + taxAndFees + delivery;

            List<Widget> children = [];

            // Add subscription info if active
            if (subController.isSubscribed.value) {
              children.add(
                Card(
                  margin: EdgeInsets.all(8),
                  color: Colors.green[50],
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            SizedBox(width: 8),
                            Text(
                              "Gold Subscription Active",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Vegetables Upto: ${subController.freeVegetables.value/1000}kg (Used: ${subController.usedVegetables.value/1000}kg)",
                        ),
                        Text(
                          "Fruits Upto: ${subController.freeFruits.value/1000}kg (Used: ${subController.usedFruits.value/1000}kg)",
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            children.addAll([
              // Address section (unchanged from your original code)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Shipping Address", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (houseNumber.isNotEmpty) Text(houseNumber, style: TextStyle(color: Colors.green)),
                              if (addressLine.isNotEmpty) Text(addressLine, style: TextStyle(color: Colors.green)),
                              if (area.isNotEmpty) Text(area, style: TextStyle(color: Colors.green)),
                              if (city.isNotEmpty) Text(city, style: TextStyle(color: Colors.green)),
                              if (nearbyLocation.isNotEmpty) Text(nearbyLocation, style: TextStyle(color: Colors.green)),
                              if (currentLocation.isNotEmpty)
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: "Current Location: ", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                      TextSpan(text: currentLocation, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Get.to(() => AddAddressPage()),
                          child: Text("Edit"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade100,
                            foregroundColor: Colors.green.shade700,
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              // Subscribed products (unchanged from your original code)
              if (subscribedItems.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Subscription Products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                SizedBox(height: 10),
                ...subscribedItems.entries.map((entry) {
                  final product = entry.key;
                  final price = entry.value;
                  return Slidable(
                    key: Key('sub_${product.id}'),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) {
                            subscriptionController.subscribedProducts.remove(product);
                            subscriptionController.update();
                          },
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: GestureDetector(
                          onTap: () {
                            Get.to(() => SubscriptionProduct(product: product));
                          },
                          child: Image.asset(product.imageUrl, width: 50, height: 50)),
                      title: Text(product.name),
                      subtitle: Text("\$${product.price.toStringAsFixed(2)} / unit"),
                      trailing: Text("\$${price.toStringAsFixed(2)}",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    ),
                  );
                }),
                Divider(),
              ],

              // Category Products (Grocery Items) section (unchanged from your original code)
              if (groceryItemsInCart.isNotEmpty) ...[
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Category Products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                SizedBox(height: 10),
                ...groceryItemsInCart.map((item) {
                  final count = groceryController.cartItems[item.id] ?? 0;
                  final itemTotal = subController.calculatePriceForItem(item, count);
                  final remainingFreeWeight = subController.remainingWeight(item.category);
                  final totalItemWeight = item.weight * count;
                  final isFree = subController.isSubscribed.value &&
                      (item.category == GroceryCategories.vegetables ||
                          item.category == GroceryCategories.fruits) &&
                      remainingFreeWeight > 0;
                  return Slidable(
                    key: Key('grocery_${item.id}'),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) {
                            // Update free quota when deleting items
                            if (item.category == GroceryCategories.vegetables) {
                              subController.usedVegetables.value -= item.weight * count;
                            } else if (item.category == GroceryCategories.fruits) {
                              subController.usedFruits.value -= item.weight * count;
                            }
                            subController.saveSubscription();

                            groceryController.cartItems.remove(item.id);
                            groceryController.saveCartToStorage();
                          },

                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(item.imagePath, width: 50, height: 50),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                SizedBox(height: 5),
                                Text("\$${item.price.toStringAsFixed(2)} / item", style: TextStyle(color: Colors.green)),
                                if (isFree)
                                  Text(
                                    "FREE",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text("\$${itemTotal.toStringAsFixed(2)}",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => groceryController.removeFromCart(item),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red.shade100,
                                      radius: 12,
                                      child: Icon(Icons.remove, size: 16, color: Colors.red),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text('$count', style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => groceryController.addToCart(item),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green.shade100,
                                      radius: 12,
                                      child: Icon(Icons.add, size: 16, color: Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
                Divider(),
              ],

              // Atta Products Section
              if (attaItemsInCart.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Atta Products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                SizedBox(height: 10),
                ...attaItemsInCart.map((product) {
                  final count = cartController.getCountAtta(product);
                  return _buildProductItem(
                    context,
                    product.name,
                    product.imagePath,
                    product.price,
                    count,
                    onDecrement: () => cartController.decrementCountAtta(product),
                    onIncrement: () => cartController.incrementCountAtta(product),
                    onRemove: () {
                      cartController.attaCounts.remove(product.id);
                      cartController.saveCartToStorage();
                      cartController.update();
                    },
                    key: Key('atta_${product.id}'),
                  );
                }),
                Divider(),
              ],

              // Dal & Pulses Section
              if (dalPulsesItemsInCart.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Dal & Pulses", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                SizedBox(height: 10),
                ...dalPulsesItemsInCart.map((product) {
                  final count = cartController.getCountDalPulses(product);
                  return _buildProductItem(
                    context,
                    product.name,
                    product.imagePath,
                    product.price,
                    count,
                    onDecrement: () => cartController.decrementCountDalPulses(product),
                    onIncrement: () => cartController.incrementCountDalPulses(product),
                    onRemove: () {
                      cartController.dalPulsesCounts.remove(product.id);
                      cartController.saveCartToStorage();
                      cartController.update();
                    },
                    key: Key('dal_${product.id}'),
                  );
                }),
                Divider(),
              ],

              // Rice Products Section
              if (riceItemsInCart.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Rice Products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                SizedBox(height: 10),
                ...riceItemsInCart.map((product) {
                  final count = cartController.getCountRice(product);
                  return _buildProductItem(
                    context,
                    product.name,
                    product.imagePath,
                    product.price,
                    count,
                    onDecrement: () => cartController.decrementCountRice(product),
                    onIncrement: () => cartController.incrementCountRice(product),
                    onRemove: () {
                      cartController.riceCounts.remove(product.id);
                      cartController.saveCartToStorage();
                      cartController.update();
                    },
                    key: Key('rice_${product.id}'),
                  );
                }),
                Divider(),
              ],

              // Kitchen Items Section
              if (kitchenItemsInCart.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Kitchen Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                SizedBox(height: 10),
                ...kitchenItemsInCart.map((product) {
                  final count = cartController.getCountKitchenItems(product);
                  return _buildProductItem(
                    context,
                    product.name,
                    product.imagePath,
                    product.price,
                    count,
                    onDecrement: () => cartController.decrementCountKitchenItems(product),
                    onIncrement: () => cartController.incrementCountKitchenItems(product),
                    onRemove: () {
                      cartController.kitchenItemsCounts.remove(product.id);
                      cartController.saveCartToStorage();
                      cartController.update();
                    },
                    key: Key('kitchen_${product.id}'),
                  );
                }),
                Divider(),
              ],

              // Regular Cart Items (unchanged from your original code)
              if (productsInCart.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Best Selling Products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                SizedBox(height: 10),
                ...productsInCart.map((product) {
                  final count = cartController.getCount(product);
                  return _buildProductItem(
                    context,
                    product.name,
                    product.imagePath,
                    product.price,
                    count,
                    onDecrement: () => cartController.decrementCount(product),
                    onIncrement: () => cartController.incrementCount(product),
                    onRemove: () {
                      cartController.productCounts.remove(product.id);
                      cartController.saveCartToStorage();
                      cartController.update();
                    },
                    key: Key('product_${product.id}'),
                  );
                }),
                Divider(),
              ],

              // Order summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text("Order Summary", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 10),
                    priceRow("Cart Subtotal", cartSubtotal),
                    if (subscriptionTotal > 0) priceRow("Subscription Total", subscriptionTotal),
                    if (grocerySubtotal > 0) priceRow("Category Products Total", grocerySubtotal),
                    if (attaSubtotal > 0) priceRow("Atta Products Total", attaSubtotal),
                    if (dalPulsesSubtotal > 0) priceRow("Dal & Pulses Total", dalPulsesSubtotal),
                    if (riceSubtotal > 0) priceRow("Rice Products Total", riceSubtotal),
                    if (kitchenItemsSubtotal > 0) priceRow("Kitchen Items Total", kitchenItemsSubtotal),
                    priceRow("Tax and Fees", taxAndFees),
                    priceRow("Delivery", delivery),
                    Divider(),
                    priceRow("Total", total, isBold: true),
                    SizedBox(height: 20),
                  ],
                ),
              ),

              // Place Order Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => PaymentPage(
                      orderSummary: [
                        ...productsInCart.map((product) {
                          final count = cartController.getCount(product);
                          return {
                            'name': product.name,
                            'quantity': count,
                            'price': product.price,
                            'type': 'product',
                          };
                        }),
                        ...subscribedItems.entries.map((entry) {
                          return {
                            'name': entry.key.name,
                            'quantity': 1,
                            'price': entry.value,
                            'type': 'subscription',
                          };
                        }),
                        ...groceryItemsInCart.map((item) {
                          final count = groceryController.cartItems[item.id] ?? 0;
                          final price = subController.calculatePriceForItem(item, count) / count;
                          return {
                            'name': item.name,
                            'quantity': count,
                            'price': price.isNaN ? 0 : price,
                            'type': 'grocery',
                          };
                        }),
                        ...attaItemsInCart.map((item) {
                          final count = cartController.getCountAtta(item);
                          return {
                            'name': item.name,
                            'quantity': count,
                            'price': item.price,
                            'type': 'atta',
                          };
                        }),
                        ...dalPulsesItemsInCart.map((item) {
                          final count = cartController.getCountDalPulses(item);
                          return {
                            'name': item.name,
                            'quantity': count,
                            'price': item.price,
                            'type': 'dal_pulses',
                          };
                        }),
                        ...riceItemsInCart.map((item) {
                          final count = cartController.getCountRice(item);
                          return {
                            'name': item.name,
                            'quantity': count,
                            'price': item.price,
                            'type': 'rice',
                          };
                        }),
                        ...kitchenItemsInCart.map((item) {
                          final count = cartController.getCountKitchenItems(item);
                          return {
                            'name': item.name,
                            'quantity': count,
                            'price': item.price,
                            'type': 'kitchen_items',
                          };
                        }),
                      ],
                      totalAmount: total,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text("Place Order", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
            ]);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            );
          });
        },
      ),
    );
  }

  // Helper method to build consistent product items
  Widget _buildProductItem(
      BuildContext context,
      String name,
      String imagePath,
      double price,
      int count, {
        required VoidCallback onDecrement,
        required VoidCallback onIncrement,
        required VoidCallback onRemove,
        Key? key,
      }) {
    return Slidable(
      key: key,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onRemove(),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imagePath, width: 50, height: 50),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  SizedBox(height: 5),
                  Text("\$${price.toStringAsFixed(2)} / item", style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
            Column(
              children: [
                Text("\$${(price * count).toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onDecrement,
                      child: CircleAvatar(
                        backgroundColor: Colors.red.shade100,
                        radius: 12,
                        child: Icon(Icons.remove, size: 16, color: Colors.red),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('$count', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: onIncrement,
                      child: CircleAvatar(
                        backgroundColor: Colors.green.shade100,
                        radius: 12,
                        child: Icon(Icons.add, size: 16, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget priceRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isBold ? TextStyle(fontWeight: FontWeight.bold) : null),
          Text("\$${value.toStringAsFixed(2)}", style: isBold ? TextStyle(fontWeight: FontWeight.bold) : null),
        ],
      ),
    );
  }
}
