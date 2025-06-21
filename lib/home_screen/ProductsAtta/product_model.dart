class ProductAtta {
  final String id;        // Unique identifier for each product
  final String imagePath;
  final String name;
  final double price;
  ProductAtta({
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
List<ProductAtta> bestSellingAttaProducts = [
  ProductAtta(id: generateUniqueId(), imagePath: 'https://indianspices.de/image/cache/catalog/Ashirwad/126906-2_6-aashirvaad-atta-whole-wheat-670x570.png', name: "Pizza", price: 12.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://www.pngkit.com/png/full/419-4191084_aashirvaad-select-atta-aashirvaad-select-atta-10kg-price.png', name: "Cake", price: 8.49),
  ProductAtta(id: generateUniqueId(), imagePath: 'http://rajdhanigroup.com/cdn/services/ATTA-10KG-FRONT1.png', name: "Burger", price: 6.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://tsfoods.de/img/p/1/1/3/3/1133-large_default.jpg', name: "Green chilli", price: 3.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://miro.medium.com/v2/resize:fit:1024/0*6S55cEpGWPUwlZ3U.png', name: "Pizza", price: 12.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'http://kamadhenufoods.com/wp-content/uploads/2019/11/ATTA-11.png', name: "Cake", price: 8.49),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://www.patanjaliayurved.net/assets/product_images/400x500/1690179166maizeattta1kg1.png', name: "Apple", price: 6.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://tse2.mm.bing.net/th?id=OIP.rn7KE78M33WHq9g4qakpbAAAAA&pid=Api&P=0&h=220', name: "Banana", price: 3.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://aws.patanjaliayurved.net/assets/product_images/400x500/1690017777GlutenFreeAtta-1kg1.png', name: "Cabbage", price: 3.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://www.roxynivah.com/admin/images/nivah-pure-sharbati-atta-1-kg-15032024085117.png', name: "Carrots", price: 3.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://indianspices.de/image/cache/catalog/Ashirwad/126906-2_6-aashirvaad-atta-whole-wheat-670x570.png', name: "Pizza", price: 12.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://www.pngkit.com/png/full/419-4191084_aashirvaad-select-atta-aashirvaad-select-atta-10kg-price.png', name: "Cake", price: 8.49),
  ProductAtta(id: generateUniqueId(), imagePath: 'http://rajdhanigroup.com/cdn/services/ATTA-10KG-FRONT1.png', name: "Burger", price: 6.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://tsfoods.de/img/p/1/1/3/3/1133-large_default.jpg', name: "Green chilli", price: 3.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://miro.medium.com/v2/resize:fit:1024/0*6S55cEpGWPUwlZ3U.png', name: "Pizza", price: 12.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'http://kamadhenufoods.com/wp-content/uploads/2019/11/ATTA-11.png', name: "Cake", price: 8.49),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://www.patanjaliayurved.net/assets/product_images/400x500/1690179166maizeattta1kg1.png', name: "Apple", price: 6.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://tse2.mm.bing.net/th?id=OIP.rn7KE78M33WHq9g4qakpbAAAAA&pid=Api&P=0&h=220', name: "Banana", price: 3.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://aws.patanjaliayurved.net/assets/product_images/400x500/1690017777GlutenFreeAtta-1kg1.png', name: "Cabbage", price: 3.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://www.roxynivah.com/admin/images/nivah-pure-sharbati-atta-1-kg-15032024085117.png', name: "Carrots", price: 3.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://indianspices.de/image/cache/catalog/Ashirwad/126906-2_6-aashirvaad-atta-whole-wheat-670x570.png', name: "Pizza", price: 12.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://www.pngkit.com/png/full/419-4191084_aashirvaad-select-atta-aashirvaad-select-atta-10kg-price.png', name: "Cake", price: 8.49),
  ProductAtta(id: generateUniqueId(), imagePath: 'http://rajdhanigroup.com/cdn/services/ATTA-10KG-FRONT1.png', name: "Burger", price: 6.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://tsfoods.de/img/p/1/1/3/3/1133-large_default.jpg', name: "Green chilli", price: 3.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://miro.medium.com/v2/resize:fit:1024/0*6S55cEpGWPUwlZ3U.png', name: "Pizza", price: 12.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'http://kamadhenufoods.com/wp-content/uploads/2019/11/ATTA-11.png', name: "Cake", price: 8.49),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://www.patanjaliayurved.net/assets/product_images/400x500/1690179166maizeattta1kg1.png', name: "Apple", price: 6.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://tse2.mm.bing.net/th?id=OIP.rn7KE78M33WHq9g4qakpbAAAAA&pid=Api&P=0&h=220', name: "Banana", price: 3.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://aws.patanjaliayurved.net/assets/product_images/400x500/1690017777GlutenFreeAtta-1kg1.png', name: "Cabbage", price: 3.99),
  ProductAtta(id: generateUniqueId(), imagePath: 'https://www.roxynivah.com/admin/images/nivah-pure-sharbati-atta-1-kg-15032024085117.png', name: "Carrots", price: 3.99),
];
