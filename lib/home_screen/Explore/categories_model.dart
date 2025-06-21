// grocery_item_model.dart
class GroceryItem {
  final String id;
  final String imagePath;
  final String name;
  final double price;
  final String category;
  final int weight; // in grams
  bool isFavorite;

  GroceryItem({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.category,
    required this.weight,
    this.isFavorite = false,
  });

  // Helper method to create a copy with updated favorite status
  GroceryItem copyWith({bool? isFavorite}) {
    return GroceryItem(
      id: id,
      imagePath: imagePath,
      name: name,
      price: price,
      category: category,
      weight: weight,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

// Static counter for generating unique IDs
int _groceryCounter = 0;
String generateGroceryId() {
  _groceryCounter++;
  return 'grocery_$_groceryCounter';
}
// categories.dart
class GroceryCategories {
  static const String fruits = 'Fruits';
  static const String vegetables = 'Vegetables';
  static const String dairy = 'Dairy';
  static const String poojaItems = 'Pooja Items';
  static const String tiffins = 'Tiffins';
  static const String ayurvedic = 'Ayurvedic';
}

final List<GroceryItem> fruits = [
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/apple.avif',
    name: "Apple",
    price: 2.99,
    category: GroceryCategories.fruits,
    weight: 100, // average weight of an apple in grams
  ),
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/banana.avif',
    name: "Banana",
    price: 1.49,
    category: GroceryCategories.fruits,
    weight: 200, // average weight of a banana in grams
  ),
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/apple.avif',
    name: "Orange",
    price: 0.99,
    category: GroceryCategories.fruits,
    weight: 50,
  ),
];

final List<GroceryItem> vegetables = [
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/carrots.avif',
    name: "Carrots",
    price: 1.99,
    category: GroceryCategories.vegetables,
    weight: 100, // per carrot
  ),
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/tomato.avif',
    name: "Tomato",
    price: 0.79,
    category: GroceryCategories.vegetables,
    weight: 85,
  ),
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/potato.avif',
    name: "Potato",
    price: 0.69,
    category: GroceryCategories.vegetables,
    weight: 150,
  ),
];

final List<GroceryItem> dairy = [
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/milk.avif',
    name: "Milk",
    price: 2.49,
    category: GroceryCategories.dairy,
    weight: 1000, // 1 liter
  ),
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/cheese.avif',
    name: "Cheese",
    price: 3.99,
    category: GroceryCategories.dairy,
    weight: 200, // 200g pack
  ),
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/yogurt.avif',
    name: "Yogurt",
    price: 1.29,
    category: GroceryCategories.dairy,
    weight: 500, // 500g tub
  ),
];

final List<GroceryItem> poojaItems = [
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/incense.avif',
    name: "Incense Sticks",
    price: 0.99,
    category: GroceryCategories.poojaItems,
    weight: 50, // 50g pack
  ),
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/camphor.avif',
    name: "Camphor",
    price: 1.49,
    category: GroceryCategories.poojaItems,
    weight: 20, // 20g
  ),
];

final List<GroceryItem> tiffins = [
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/idli.avif',
    name: "Idli",
    price: 2.99,
    category: GroceryCategories.tiffins,
    weight: 150, // per piece
  ),
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/dosa.avif',
    name: "Dosa",
    price: 3.49,
    category: GroceryCategories.tiffins,
    weight: 200,
  ),
];

final List<GroceryItem> ayurvedic = [
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/ashwagandha.avif',
    name: "Ashwagandha",
    price: 4.99,
    category: GroceryCategories.ayurvedic,
    weight: 100, // 100g pack
  ),
  GroceryItem(
    id: generateGroceryId(),
    imagePath: 'assets/products/turmeric.avif',
    name: "Turmeric Powder",
    price: 2.49,
    category: GroceryCategories.ayurvedic,
    weight: 200,
  ),
];