class ProductRice {
  final String id;        // Unique identifier for each product
  final String imagePath;
  final String name;
  final double price;
  ProductRice({
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
List<ProductRice> bestSellingRice = [
  ProductRice(id: generateUniqueId(), imagePath: 'https://tse1.mm.bing.net/th?id=OIP.d9-8HLRkksbHR0lo3WVF5QHaGr&pid=Api&P=0&h=220', name: "Pizza", price: 12.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://pngfile.net/public/uploads/preview/daawat-basmati-rice-21590765524zag1ie6op9.png', name: "Cake", price: 8.49),
  ProductRice(id: generateUniqueId(), imagePath: 'https://mir-s3-cdn-cf.behance.net/project_modules/disp/1a5de829497017.55f6acd7133ff.png', name: "Burger", price: 6.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://www.daawat.com/media/images/product/image/super-basmati-1kg-merged-1640956746.png', name: "Green chilli", price: 3.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://d19oj5aeuefgv.cloudfront.net/0248217', name: "Pizza", price: 12.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://tildaricelive.s3.eu-central-1.amazonaws.com/wp-content/uploads/sites/5/2021/06/28110956/KJ49114_KSJ482619_3D-Pure-Basmati-Canada_HR_RGB-1300x1800.png', name: "Cake", price: 8.49),
  ProductRice(id: generateUniqueId(), imagePath: 'https://www.indiagatefoods.com/wp-content/uploads/2022/02/Jeera-Rice-1kg_1000x1000pxls_RD1_1.png', name: "Apple", price: 6.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://tse1.mm.bing.net/th?id=OIP.d9-8HLRkksbHR0lo3WVF5QHaGr&pid=Api&P=0&h=220', name: "Pizza", price: 12.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://pngfile.net/public/uploads/preview/daawat-basmati-rice-21590765524zag1ie6op9.png', name: "Cake", price: 8.49),
  ProductRice(id: generateUniqueId(), imagePath: 'https://mir-s3-cdn-cf.behance.net/project_modules/disp/1a5de829497017.55f6acd7133ff.png', name: "Burger", price: 6.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://www.daawat.com/media/images/product/image/super-basmati-1kg-merged-1640956746.png', name: "Green chilli", price: 3.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://d19oj5aeuefgv.cloudfront.net/0248217', name: "Pizza", price: 12.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://tildaricelive.s3.eu-central-1.amazonaws.com/wp-content/uploads/sites/5/2021/06/28110956/KJ49114_KSJ482619_3D-Pure-Basmati-Canada_HR_RGB-1300x1800.png', name: "Cake", price: 8.49),
  ProductRice(id: generateUniqueId(), imagePath: 'https://www.indiagatefoods.com/wp-content/uploads/2022/02/Jeera-Rice-1kg_1000x1000pxls_RD1_1.png', name: "Apple", price: 6.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://tse1.mm.bing.net/th?id=OIP.d9-8HLRkksbHR0lo3WVF5QHaGr&pid=Api&P=0&h=220', name: "Pizza", price: 12.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://pngfile.net/public/uploads/preview/daawat-basmati-rice-21590765524zag1ie6op9.png', name: "Cake", price: 8.49),
  ProductRice(id: generateUniqueId(), imagePath: 'https://mir-s3-cdn-cf.behance.net/project_modules/disp/1a5de829497017.55f6acd7133ff.png', name: "Burger", price: 6.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://www.daawat.com/media/images/product/image/super-basmati-1kg-merged-1640956746.png', name: "Green chilli", price: 3.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://d19oj5aeuefgv.cloudfront.net/0248217', name: "Pizza", price: 12.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://tildaricelive.s3.eu-central-1.amazonaws.com/wp-content/uploads/sites/5/2021/06/28110956/KJ49114_KSJ482619_3D-Pure-Basmati-Canada_HR_RGB-1300x1800.png', name: "Cake", price: 8.49),
  ProductRice(id: generateUniqueId(), imagePath: 'https://www.indiagatefoods.com/wp-content/uploads/2022/02/Jeera-Rice-1kg_1000x1000pxls_RD1_1.png', name: "Apple", price: 6.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://tse1.mm.bing.net/th?id=OIP.d9-8HLRkksbHR0lo3WVF5QHaGr&pid=Api&P=0&h=220', name: "Pizza", price: 12.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://pngfile.net/public/uploads/preview/daawat-basmati-rice-21590765524zag1ie6op9.png', name: "Cake", price: 8.49),
  ProductRice(id: generateUniqueId(), imagePath: 'https://mir-s3-cdn-cf.behance.net/project_modules/disp/1a5de829497017.55f6acd7133ff.png', name: "Burger", price: 6.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://www.daawat.com/media/images/product/image/super-basmati-1kg-merged-1640956746.png', name: "Green chilli", price: 3.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://d19oj5aeuefgv.cloudfront.net/0248217', name: "Pizza", price: 12.99),
  ProductRice(id: generateUniqueId(), imagePath: 'https://tildaricelive.s3.eu-central-1.amazonaws.com/wp-content/uploads/sites/5/2021/06/28110956/KJ49114_KSJ482619_3D-Pure-Basmati-Canada_HR_RGB-1300x1800.png', name: "Cake", price: 8.49),
  ProductRice(id: generateUniqueId(), imagePath: 'https://www.indiagatefoods.com/wp-content/uploads/2022/02/Jeera-Rice-1kg_1000x1000pxls_RD1_1.png', name: "Apple", price: 6.99),
];
