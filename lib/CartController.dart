import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:thaaja/Profile/addAddress.dart';
import 'package:thaaja/deep/SubscriptionPlans/GoldSubscription.dart';
import 'package:thaaja/home_screen/Explore/Explore.dart';
import 'package:thaaja/home_screen/Products/productDetails.dart';
import 'package:thaaja/home_screen/Products/product_model.dart';
import 'package:thaaja/home_screen/ProductsAtta/product_model.dart' as atta;
import 'package:thaaja/home_screen/Dal_Pulses/product_model.dart' as dalPulses;
import 'package:thaaja/home_screen/Rice/product_model.dart' as rice;
import 'package:thaaja/home_screen/SubscriptionProducts/subscribeproduct.dart';
import 'package:thaaja/home_screen/Explore/categories_model.dart';
import 'package:thaaja/home_screen/kitchenNeeds/product_model.dart';
class CartController extends GetxController {
  var productCounts = <String, int>{}.obs;
  var attaCounts = <String, int>{}.obs;
  var dalPulsesCounts = <String, int>{}.obs;
  var riceCounts = <String, int>{}.obs;
  var kitchenItemsCounts = <String, int>{}.obs;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    loadCartFromStorage();
  }
  void saveCartToStorage() {
    box.write('cart', productCounts);
    box.write('attaCart', attaCounts);
    box.write('dalPulses', dalPulsesCounts);
    box.write('rice', riceCounts);
    box.write('kitchenItems', kitchenItemsCounts);
  }
  void loadCartFromStorage() {
    Map<String, dynamic>? storedCart = box.read('cart');
    Map<String, dynamic>? storedAttaCart = box.read('attaCart');
    Map<String, dynamic>? storedDalPulsesCart = box.read('attaCart');
    Map<String, dynamic>? storedRiceCart = box.read('riceCart');
    Map<String, dynamic>? storedKitchenItemsCart = box.read('kitchenItemsCart');
    if (storedCart != null) {
      productCounts.value = Map<String, int>.from(storedCart);
    }
    if (storedAttaCart != null) {
      attaCounts.value = Map<String, int>.from(storedAttaCart);
    }
    if (storedDalPulsesCart != null) {
      dalPulsesCounts.value = Map<String, int>.from(storedDalPulsesCart);
    }
    if (storedRiceCart != null) {
      riceCounts.value = Map<String, int>.from(storedRiceCart);
    }
    if (storedKitchenItemsCart != null) {
      kitchenItemsCounts.value = Map<String, int>.from(storedKitchenItemsCart);
    }
  }
  int getCount(Product product) {
    return productCounts[product.id] ?? 0;
  }
  void incrementCount(Product product) {
    if (productCounts.containsKey(product.id)) {
      productCounts[product.id] = productCounts[product.id]! + 1;
    } else {
      productCounts[product.id] = 1;
    }
    saveCartToStorage();
    update();
  }
  void decrementCount(Product product) {
    if (productCounts.containsKey(product.id) && productCounts[product.id]! > 0) {
      productCounts[product.id] = productCounts[product.id]! - 1;
      if (productCounts[product.id] == 0) {
        productCounts.remove(product.id);
      }
    }
    saveCartToStorage();
    update();
  }
  int getCountAtta(atta.ProductAtta atta) => attaCounts[atta.id] ?? 0;

  void incrementCountAtta(atta.ProductAtta atta) {
    attaCounts[atta.id] = (attaCounts[atta.id] ?? 0) + 1;
    saveCartToStorage();
    update();
  }

  void decrementCountAtta(atta.ProductAtta atta) {
    if (attaCounts.containsKey(atta.id) && attaCounts[atta.id]! > 0) {
      attaCounts[atta.id] = attaCounts[atta.id]! - 1;
      if (attaCounts[atta.id] == 0) {
        attaCounts.remove(atta.id);
      }
      saveCartToStorage();
      update();
    }
  }

  int getCountDalPulses(dalPulses.ProductDalPulses dalPulses) => dalPulsesCounts[dalPulses.id] ?? 0;

  void incrementCountDalPulses(dalPulses.ProductDalPulses dalPulses) {
    dalPulsesCounts[dalPulses.id] = (dalPulsesCounts[dalPulses.id] ?? 0) + 1;
    saveCartToStorage();
    update();
  }

  void decrementCountDalPulses(dalPulses.ProductDalPulses dalPulses) {
    if (dalPulsesCounts.containsKey(dalPulses.id) && dalPulsesCounts[dalPulses.id]! > 0) {
      dalPulsesCounts[dalPulses.id] = dalPulsesCounts[dalPulses.id]! - 1;
      if (dalPulsesCounts[dalPulses.id] == 0) {
        dalPulsesCounts.remove(dalPulses.id);
      }
      saveCartToStorage();
      update();
    }
  }

  int getCountRice(rice.ProductRice rice) => riceCounts[rice.id] ?? 0;

  void incrementCountRice(rice.ProductRice rice) {
    riceCounts[rice.id] = (riceCounts[rice.id] ?? 0) + 1;
    saveCartToStorage();
    update();
  }

  void decrementCountRice(rice.ProductRice rice) {
    if (riceCounts.containsKey(rice.id) && riceCounts[rice.id]! > 0) {
      riceCounts[rice.id] = riceCounts[rice.id]! - 1;
      if (riceCounts[rice.id] == 0) {
        riceCounts.remove(rice.id);
      }
      saveCartToStorage();
      update();
    }
  }

  int getCountKitchenItems(KitchenItems kitchenItems) => kitchenItemsCounts[kitchenItems.id] ?? 0;

  void incrementCountKitchenItems(KitchenItems kitchenItems) {
    kitchenItemsCounts[kitchenItems.id] = (kitchenItemsCounts[kitchenItems.id] ?? 0) + 1;
    saveCartToStorage();
    update();
  }

  void decrementCountKitchenItems(KitchenItems kitchenItems) {
    if (kitchenItemsCounts.containsKey(kitchenItems.id) && kitchenItemsCounts[kitchenItems.id]! > 0) {
      kitchenItemsCounts[kitchenItems.id] = kitchenItemsCounts[kitchenItems.id]! - 1;
      if (kitchenItemsCounts[kitchenItems.id] == 0) {
        kitchenItemsCounts.remove(kitchenItems.id);
      }
      saveCartToStorage();
      update();
    }
  }

  void removeProductIfZero(Product product) {
    if (productCounts[product.id] == 0) {
      productCounts.remove(product.id);
      saveCartToStorage();
      update();
    }
  }
}
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final subscriptionController = Get.find<SubscriptionProductController>();
    final groceryController = Get.find<GroceryController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: Colors.green,
      ),
      body: Obx(() {
        // Get all cart items from different categories
        final cartItems = cartController.productCounts;
        final subscriptionItems = subscriptionController.subscribedProducts;
        final groceryCartItems = groceryController.cartItems;
        final attaCartItems = cartController.attaCounts;
        final dalPulsesCartItems = cartController.dalPulsesCounts;
        final riceCartItems = cartController.riceCounts;
        final kitchenItemsCartItems = cartController.kitchenItemsCounts;

        // Get all available products from each category
        final allCategoryItems = groceryController.categorizedItems.values.expand((list) => list).toList();

        // Filter products that are actually in cart with count > 0
        List<Product> productsInCart = cartItems.keys
            .map((id) => bestSellingProducts.firstWhere((product) => product.id == id))
            .where((product) => cartController.getCount(product) > 0)
            .toList();

        List<GroceryItem> itemsInGroceryCart = groceryCartItems.keys
            .map((id) => allCategoryItems.firstWhereOrNull((item) => item.id == id))
            .whereType<GroceryItem>()
            .toList();

        List<atta.ProductAtta> attaItemsInCart = attaCartItems.keys
            .map((id) => atta.bestSellingAttaProducts.firstWhere((product) => product.id == id))
            .where((product) => cartController.getCountAtta(product) > 0)
            .toList();

        List<dalPulses.ProductDalPulses> dalPulsesItemsInCart = dalPulsesCartItems.keys
            .map((id) => dalPulses.bestSellingDalPulses.firstWhere((product) => product.id == id))
            .where((product) => cartController.getCountDalPulses(product) > 0)
            .toList();

        List<rice.ProductRice> riceItemsInCart = riceCartItems.keys
            .map((id) => rice.bestSellingRice.firstWhere((product) => product.id == id))
            .where((product) => cartController.getCountRice(product) > 0)
            .toList();

        List<KitchenItems> kitchenItemsInCart = kitchenItemsCartItems.keys
            .map((id) => bestSellingKitchenItems.firstWhere((product) => product.id == id))
            .where((product) => cartController.getCountKitchenItems(product) > 0)
            .toList();

        // Calculate totals for each category
        double cartTotal = productsInCart.fold(
            0, (sum, item) => sum + (item.price * cartController.getCount(item)));

        double subscriptionTotal = subscriptionController.totalSubscriptionPrice;

        double groceryTotal = itemsInGroceryCart.fold(
            0, (sum, item) => sum + ((groceryController.cartItems[item.id] ?? 0) * item.price));

        double attaTotal = attaItemsInCart.fold(
            0, (sum, item) => sum + (item.price * cartController.getCountAtta(item)));

        double dalPulsesTotal = dalPulsesItemsInCart.fold(
            0, (sum, item) => sum + (item.price * cartController.getCountDalPulses(item)));

        double riceTotal = riceItemsInCart.fold(
            0, (sum, item) => sum + (item.price * cartController.getCountRice(item)));

        double kitchenItemsTotal = kitchenItemsInCart.fold(
            0, (sum, item) => sum + (item.price * cartController.getCountKitchenItems(item)));

        // Calculate grand total
        double grandTotal = cartTotal + subscriptionTotal + groceryTotal +
            attaTotal + dalPulsesTotal + riceTotal + kitchenItemsTotal;

        // Empty cart check
        if (cartItems.isEmpty &&
            subscriptionItems.isEmpty &&
            groceryCartItems.isEmpty &&
            attaCartItems.isEmpty &&
            dalPulsesCartItems.isEmpty &&
            riceCartItems.isEmpty &&
            kitchenItemsCartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/EmptyCart.json', repeat: false),
                Text('Your cart is empty!', style: TextStyle(fontSize: 30)),
              ],
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // Subscription Products Section
                  if (subscriptionItems.isNotEmpty) ...[

                    ...subscriptionItems.entries.map((entry) {
                      final product = entry.key;
                      final total = entry.value;
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
                          leading: Image.asset(product.imageUrl, width: 40, height: 40),
                          title: Text(product.name),
                          subtitle: Text("Subscribed: \$${product.price.toStringAsFixed(2)}"),
                          trailing: Text("\$${total.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      );
                    }).toList(),
                    //Divider(thickness: 1),
                  ],

                  // Grocery Products Section
                  if (itemsInGroceryCart.isNotEmpty) ...[

                    ...itemsInGroceryCart.map((item) {
                      int count = groceryController.cartItems[item.id] ?? 0;
                      double total = count * item.price;
                      return Slidable(
                        key: Key('cat_${item.id}'),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                // Update free quota when deleting items
                                if (item.category == GroceryCategories.vegetables) {
                                  final subController = Get.find<SubscriptionController>();
                                  subController.usedVegetables.value -= item.weight * count;
                                  subController.saveSubscription();
                                } else if (item.category == GroceryCategories.fruits) {
                                  final subController = Get.find<SubscriptionController>();
                                  subController.usedFruits.value -= item.weight * count;
                                  subController.saveSubscription();
                                }

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
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Image.asset(item.imagePath, width: 50, height: 50),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      Text("\$${item.price.toStringAsFixed(2)}"),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove, color: Colors.red),
                                      onPressed: () => groceryController.removeFromCart(item),
                                    ),
                                    Text("$count", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    IconButton(
                                      icon: Icon(Icons.add, color: Colors.green),
                                      onPressed: () => groceryController.addToCart(item),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Text("\$${total.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    //Divider(thickness: 1),
                  ],

                  // Atta Products Section
                  if (attaItemsInCart.isNotEmpty) ...[

                    ...attaItemsInCart.map((attaProduct) {
                      final count = cartController.getCountAtta(attaProduct);
                      final total = count * attaProduct.price;
                      return Slidable(
                        key: ValueKey('atta_${attaProduct.id}'),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) async {
                                cartController.attaCounts.remove(attaProduct.id);
                                cartController.update();
                              },
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Image.network(attaProduct.imagePath, width: 50, height: 50),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(attaProduct.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      Text("\$${attaProduct.price.toStringAsFixed(2)}"),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove, color: Colors.red),
                                      onPressed: () {
                                        cartController.decrementCountAtta(attaProduct);
                                        if (cartController.getCountAtta(attaProduct) == 0) {
                                          cartController.attaCounts.remove(attaProduct.id);
                                          cartController.saveCartToStorage();
                                        }
                                        cartController.update();
                                      },
                                    ),
                                    Text("$count", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    IconButton(
                                      icon: Icon(Icons.add, color: Colors.green),
                                      onPressed: () => cartController.incrementCountAtta(attaProduct),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Text("\$${total.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    //Divider(thickness: 1),
                  ],

                  // Dal & Pulses Section
                  if (dalPulsesItemsInCart.isNotEmpty) ...[

                    ...dalPulsesItemsInCart.map((dalPulseProduct) {
                      final count = cartController.getCountDalPulses(dalPulseProduct);
                      final total = count * dalPulseProduct.price;
                      return Slidable(
                        key: ValueKey('dal_${dalPulseProduct.id}'),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) async {
                                cartController.dalPulsesCounts.remove(dalPulseProduct.id);
                                cartController.update();
                              },
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Image.network(dalPulseProduct.imagePath, width: 50, height: 50),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(dalPulseProduct.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      Text("\$${dalPulseProduct.price.toStringAsFixed(2)}"),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove, color: Colors.red),
                                      onPressed: () {
                                        cartController.decrementCountDalPulses(dalPulseProduct);
                                        if (cartController.getCountDalPulses(dalPulseProduct) == 0) {
                                          cartController.dalPulsesCounts.remove(dalPulseProduct.id);
                                          cartController.saveCartToStorage();
                                        }
                                        cartController.update();
                                      },
                                    ),
                                    Text("$count", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    IconButton(
                                      icon: Icon(Icons.add, color: Colors.green),
                                      onPressed: () => cartController.incrementCountDalPulses(dalPulseProduct),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Text("\$${total.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    //Divider(thickness: 1),
                  ],

                  // Rice Products Section
                  if (riceItemsInCart.isNotEmpty) ...[

                    ...riceItemsInCart.map((riceProduct) {
                      final count = cartController.getCountRice(riceProduct);
                      final total = count * riceProduct.price;
                      return Slidable(
                        key: ValueKey('rice_${riceProduct.id}'),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) async {
                                cartController.riceCounts.remove(riceProduct.id);
                                cartController.update();
                              },
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Image.network(riceProduct.imagePath, width: 50, height: 50),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(riceProduct.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      Text("\$${riceProduct.price.toStringAsFixed(2)}"),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove, color: Colors.red),
                                      onPressed: () {
                                        cartController.decrementCountRice(riceProduct);
                                        if (cartController.getCountRice(riceProduct) == 0) {
                                          cartController.riceCounts.remove(riceProduct.id);
                                          cartController.saveCartToStorage();
                                        }
                                        cartController.update();
                                      },
                                    ),
                                    Text("$count", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    IconButton(
                                      icon: Icon(Icons.add, color: Colors.green),
                                      onPressed: () => cartController.incrementCountRice(riceProduct),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Text("\$${total.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    //Divider(thickness: 1),
                  ],

                  // Kitchen Items Section
                  if (kitchenItemsInCart.isNotEmpty) ...[

                    ...kitchenItemsInCart.map((kitchenItem) {
                      final count = cartController.getCountKitchenItems(kitchenItem);
                      final total = count * kitchenItem.price;
                      return Slidable(
                        key: ValueKey('kitchen_${kitchenItem.id}'),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) async {
                                cartController.kitchenItemsCounts.remove(kitchenItem.id);
                                cartController.update();
                              },
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Image.asset(kitchenItem.imagePath, width: 50, height: 50),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(kitchenItem.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      Text("\$${kitchenItem.price.toStringAsFixed(2)}"),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove, color: Colors.red),
                                      onPressed: () {
                                        cartController.decrementCountKitchenItems(kitchenItem);
                                        if (cartController.getCountKitchenItems(kitchenItem) == 0) {
                                          cartController.kitchenItemsCounts.remove(kitchenItem.id);
                                          cartController.saveCartToStorage();
                                        }
                                        cartController.update();
                                      },
                                    ),
                                    Text("$count", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    IconButton(
                                      icon: Icon(Icons.add, color: Colors.green),
                                      onPressed: () => cartController.incrementCountKitchenItems(kitchenItem),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Text("\$${total.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    //Divider(thickness: 1),
                  ],

                  // Regular Cart Items Section
                  if (productsInCart.isNotEmpty) ...[

                    ...productsInCart.map((product) {
                      final count = cartController.getCount(product);
                      final total = count * product.price;
                      return Slidable(
                        key: Key(product.id),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                cartController.productCounts.remove(product.id);
                                cartController.saveCartToStorage();
                                cartController.update();
                              },
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Image.asset(product.imagePath, width: 50, height: 50),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      Text("\$${product.price.toStringAsFixed(2)}"),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove, color: Colors.red),
                                      onPressed: () {
                                        cartController.decrementCount(product);
                                        cartController.removeProductIfZero(product);
                                      },
                                    ),
                                    Text("$count", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    IconButton(
                                      icon: Icon(Icons.add, color: Colors.green),
                                      onPressed: () => cartController.incrementCount(product),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Text("\$${total.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ],
              ),
            ),

            // Total and Checkout Section
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height * 0.75,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: AddAddressPage(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Proceed to Checkout",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CartItem extends StatelessWidget {
  final Product product;
  final int count;
  final CartController cartController;
  const CartItem({
    Key? key,
    required this.product,
    required this.count,
    required this.cartController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double totalPrice = count * product.price;
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetails(product: product));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    product.imagePath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "\$${product.price}",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (count > 0) {
                        cartController.decrementCount(product);
                        cartController.removeProductIfZero(product);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 20,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.green,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      "$count",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      cartController.incrementCount(product);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "\$${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}