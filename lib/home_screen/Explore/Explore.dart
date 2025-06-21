import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thaaja/deep/SubscriptionPlans/GoldSubscription.dart';
import 'package:thaaja/home_screen/Explore/categories_model.dart';
class GroceryController extends GetxController {
  final RxMap<String, List<GroceryItem>> categorizedItems = <String, List<GroceryItem>>{}.obs;
  final RxMap<String, int> cartItems = <String, int>{}.obs;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    loadCartFromStorage();
    categorizedItems.value = {
      GroceryCategories.fruits: fruits,
      GroceryCategories.vegetables: vegetables,
      GroceryCategories.dairy: dairy,
      GroceryCategories.poojaItems: poojaItems,
      GroceryCategories.tiffins: tiffins,
      GroceryCategories.ayurvedic: ayurvedic,
    };
  }
  void loadCartFromStorage() {
    Map<String, dynamic>? savedCart = box.read('cartItems');
    if (savedCart != null) {
      cartItems.value = Map<String, int>.from(savedCart);
    }
  }
  void saveCartToStorage() {
    box.write('cartItems', cartItems);
  }

  void addToCart(GroceryItem item) {
    final subController = Get.find<SubscriptionController>();
    final now = DateTime.now();
    bool usedFreeQuota = false;

    // Check if we can use free quota (before 8PM and not used today)
    if (now.hour < 20 && !subController.todayFreeOrderUsed.value &&
        subController.isSubscriptionActive &&
        (item.category == GroceryCategories.vegetables ||
            item.category == GroceryCategories.fruits)) {

      // Check if we have remaining free quota
      if (subController.canAddForFree(item.category, item.weight)) {
        subController.updateUsedQuantity(item.category, item.weight);
        usedFreeQuota = true;
        Get.snackbar(
          "Free Item Added",
          "This item is free as part of your daily subscription benefits",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
      // Only show limit exceeded if trying to use free quota but can't
      else if (subController.remainingWeight(item.category) > 0) {
        Get.snackbar(
          "Limit Exceeded",
          "You've used all your free ${item.category} allowance for today",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    }

    // Always add to cart (will be charged if not free)
    _addToCartNormally(item);
  }

  void _addToCartNormally(GroceryItem item) {
    if (cartItems.containsKey(item.id)) {
      cartItems[item.id] = cartItems[item.id]! + 1;
    } else {
      cartItems[item.id] = 1;
    }
    saveCartToStorage();
  }
  void removeFromCart(GroceryItem item) {
    final subController = Get.find<SubscriptionController>();

    if (cartItems.containsKey(item.id) && cartItems[item.id]! > 0) {
      cartItems[item.id] = cartItems[item.id]! - 1;
      // Only update subscription usage if subscribed
      if (subController.isSubscribed.value &&
          (item.category == GroceryCategories.vegetables ||
              item.category == GroceryCategories.fruits)) {
        subController.updateUsedQuantity(item.category, -item.weight);
      }
      if (cartItems[item.id] == 0) {
        cartItems.remove(item.id);
      }
    }
    saveCartToStorage();
  }
  double calculateTotalPrice() {
    final subController = Get.find<SubscriptionController>();
    double total = 0;
    cartItems.forEach((id, quantity) {
      final item = allItems.firstWhere((item) => item.id == id);
      total += subController.isSubscribed.value
          ? subController.calculatePriceForItem(item, quantity)
          : item.price * quantity;
    });
    return total;
  }
  List<GroceryItem> get allItems {
    return categorizedItems.values.expand((list) => list).toList();
  }
}
class ExplorePage extends StatelessWidget {
  ExplorePage({Key? key}) : super(key: key) {
    Get.lazyPut(() => SubscriptionController());
    Get.put(GroceryController());
  }

  final List<String> categories = [
    GroceryCategories.fruits,
    GroceryCategories.vegetables,
    GroceryCategories.dairy,
    GroceryCategories.poojaItems,
    GroceryCategories.tiffins,
    GroceryCategories.ayurvedic,
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green.shade900,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 2.5,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: categories.map((cat) {
              IconData icon;
              switch (cat) {
                case GroceryCategories.fruits:
                  icon = Icons.apple;
                  break;
                case GroceryCategories.vegetables:
                  icon = Icons.grass;
                  break;
                case GroceryCategories.dairy:
                  icon = Icons.local_drink;
                  break;
                case GroceryCategories.poojaItems:
                  icon = Icons.spa;
                  break;
                case GroceryCategories.tiffins:
                  icon = Icons.lunch_dining;
                  break;
                case GroceryCategories.ayurvedic:
                  icon = Icons.eco;
                  break;
                default:
                  icon = Icons.help;
              }
              return Tab(
                icon: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(icon, color: Colors.white),
                ),
                text: cat,
              );
            }).toList(),
          ),
        ),
        body: Obx(() {
          return TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: categories.map((category) {
              final items = Get.find<GroceryController>().categorizedItems[category] ?? [];
              return _CategoryListView(items: items);
            }).toList(),
          );
        }),
      ),
    );
  }
}

class _CategoryListView extends StatelessWidget {
  final List<GroceryItem> items;
  const _CategoryListView({required this.items});

  @override
  Widget build(BuildContext context) {
    final groceryController = Get.find<GroceryController>();
    final subController = Get.find<SubscriptionController>();

    if (items.isEmpty) {
      return const Center(child: Text('No items available'));
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.7,
      ),
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        final count = groceryController.cartItems[item.id] ?? 0;

        // Only show free if subscribed and item is eligible
        bool showFree = subController.isSubscribed.value &&
            (item.category == GroceryCategories.vegetables ||
                item.category == GroceryCategories.fruits) &&
            subController.canAddForFree(item.category, item.weight);

        return GestureDetector(
          onTap: () {
            if (showFree) {
              Get.snackbar(
                "Free Item",
                "This item is free as part of your subscription",
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            }
          },
          child: Card(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                  color: showFree ? Colors.amber : Colors.green,
                  width: 2
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 60,
                        child: Image.asset(
                          item.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        item.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /*
                              Text(
                                '\$${item.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: showFree ? Colors.grey : Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  decoration: showFree ? TextDecoration.lineThrough : null,
                                ),
                              ),*/

                              Text(
                                '\$${item.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                '${item.weight}g',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => groceryController.removeFromCart(item),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.remove, size: 18, color: Colors.red),
                            ),
                          ),
                          SizedBox(width: 10),
                          Obx(() {
                            int currentCount = groceryController.cartItems[item.id] ?? 0;
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "$currentCount",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            );
                          }),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              // Always allow adding to cart, regardless of subscription
                              groceryController.addToCart(item);
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: showFree ? Colors.amber : Colors.green.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: showFree ? Colors.white : Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                /*if (showFree)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "FREE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),*/
              ],
            ),
          ),
        );
      },
    );
  }
}