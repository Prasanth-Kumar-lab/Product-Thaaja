class KitchenItems {
  final String id;        // Unique identifier for each product
  final String imagePath;
  final String name;
  final double price;
  KitchenItems({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.price,
  });
}
// Static counter for generating unique IDs
int _counter = 0;
String generateUniqueId() {
  _counter++;
  return 'product$_counter';
}
// Best Selling Product List with dynamically generated IDs based on a counter
List<KitchenItems> bestSellingKitchenItems = [
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/pizza.png', name: "Pizza", price: 12.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/cake.png', name: "Cake", price: 8.49),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/burger.png', name: "Burger", price: 6.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/greenChilli.avif', name: "Green chilli", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/pizza.png', name: "Pizza", price: 12.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/cake.png', name: "Cake", price: 8.49),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/apple.avif', name: "Apple", price: 6.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/banana.avif', name: "Banana", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/cabbage.jpg', name: "Cabbage", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/carrots.avif', name: "Carrots", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/grapes.avif', name: "Black grapes", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/greenChilli.avif', name: "Green chilli", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/greenGrapes.avif', name: "Green grapes", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/pineApple.avif', name: "Pineapple", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/pomegranate.avif', name: "Pomegranate", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/potato.avif', name: "Potato", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/tomato.avif', name: "Tomato", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/greenChilli.avif', name: "Green chilli", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/pizza.png', name: "Pizza", price: 12.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/cake.png', name: "Cake", price: 8.49),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/burger.png', name: "Burger", price: 6.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/greenChilli.avif', name: "Green chilli", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/pizza.png', name: "Pizza", price: 12.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/cake.png', name: "Cake", price: 8.49),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/apple.avif', name: "Apple", price: 6.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/banana.avif', name: "Banana", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/cabbage.jpg', name: "Cabbage", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/carrots.avif', name: "Carrots", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/grapes.avif', name: "Black grapes", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/greenChilli.avif', name: "Green chilli", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/greenGrapes.avif', name: "Green grapes", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/pineApple.avif', name: "Pineapple", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/pomegranate.avif', name: "Pomegranate", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/potato.avif', name: "Potato", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/tomato.avif', name: "Tomato", price: 3.99),
  KitchenItems(id: generateUniqueId(), imagePath: 'assets/products/greenChilli.avif', name: "Green chilli", price: 3.99),
];
