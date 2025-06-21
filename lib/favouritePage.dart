import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:thaaja/CartController.dart';
import 'package:thaaja/home_screen/Dal_Pulses/product_model.dart' as dalPulses;
import 'package:thaaja/home_screen/Rice/product_model.dart' as rice;
import 'package:thaaja/home_screen/KitchenNeeds/product_model.dart' as kitchenItems;
import 'package:thaaja/home_screen/Products/productDetails.dart';
import 'package:thaaja/home_screen/Products/product_model.dart';
import 'package:thaaja/home_screen/ProductsAtta/product_model.dart';
import 'package:thaaja/home_screen/kitchenNeeds/product_model.dart';

class FavoriteController extends GetxController {
  // Regular product favorites
  var favoriteProducts = <Product>[].obs;

  void toggleFavorite(Product product) {
    if (favoriteProducts.contains(product)) {
      favoriteProducts.remove(product);
    } else {
      favoriteProducts.add(product);
    }
  }

  bool isFavorite(Product product) {
    return favoriteProducts.contains(product);
  }

  // Atta product favorites
  var favoriteAttaProducts = <ProductAtta>[].obs;

  void toggleAttaFavorite(ProductAtta atta) {
    if (favoriteAttaProducts.contains(atta)) {
      favoriteAttaProducts.remove(atta);
    } else {
      favoriteAttaProducts.add(atta);
    }
  }

  bool isAttaFavorite(ProductAtta atta) {
    return favoriteAttaProducts.contains(atta);
  }

  var favoriteDalProducts = <dalPulses.ProductDalPulses>[].obs;

  void toggleDalFavorite(dalPulses.ProductDalPulses dalPulses) {
    if (favoriteDalProducts.contains(dalPulses)) {
      favoriteDalProducts.remove(dalPulses);
    } else {
      favoriteDalProducts.add(dalPulses);
    }
  }

  bool isDalFavorite(dalPulses.ProductDalPulses dalPulses) {
    return favoriteDalProducts.contains(dalPulses);
  }

  var favoriteRiceProducts = <rice.ProductRice>[].obs;

  void toggleRiceFavorite(rice.ProductRice rice) {
    if (favoriteRiceProducts.contains(rice)) {
      favoriteRiceProducts.remove(rice);
    } else {
      favoriteRiceProducts.add(rice);
    }
  }

  bool isRiceFavorite(rice.ProductRice rice) {
    return favoriteRiceProducts.contains(rice);
  }

  var favoriteKitchenItems = <KitchenItems>[].obs;

  void toggleKitchenItemsFavorite(KitchenItems kitchenItems) {
    if (favoriteKitchenItems.contains(kitchenItems)) {
      favoriteKitchenItems.remove(kitchenItems);
    } else {
      favoriteKitchenItems.add(kitchenItems);
    }
  }

  bool isKitchenItemsFavorite(KitchenItems kitchenItems) {
    return favoriteKitchenItems.contains(kitchenItems);
  }

}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.find<FavoriteController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        final hasFavorites = favoriteController.favoriteProducts.isNotEmpty ||
            favoriteController.favoriteAttaProducts.isNotEmpty;

        if (!hasFavorites) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/Animation - 1747025642980.json', repeat: false),
                Text('No favourites added!', style: TextStyle(fontSize: 30)),
              ],
            ),
          );
        }

        return ListView(
          children: [
            // Favorite Regular Products
            if (favoriteController.favoriteProducts.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Favorite Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...favoriteController.favoriteProducts.map((product) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductDetails(product: product));
                  },
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text("\$${product.price}"),
                    leading: Image.asset(
                      product.imagePath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        favoriteController.toggleFavorite(product);
                      },
                    ),
                  ),
                );
              }).toList(),
            ],

            // Favorite Atta Products
            if (favoriteController.favoriteAttaProducts.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Favorite Atta Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...favoriteController.favoriteAttaProducts.map((atta) {
                return ListTile(
                  title: Text(atta.name),
                  subtitle: Text("\$${atta.price}"),
                  leading: Image.asset(
                    atta.imagePath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      favoriteController.toggleAttaFavorite(atta);
                    },
                  ),
                );
              }).toList(),
            ],
          ],
        );
      }),
    );
  }
}
