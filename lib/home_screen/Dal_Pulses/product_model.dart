class ProductDalPulses {
  final String id;        // Unique identifier for each product
  final String imagePath;
  final String name;
  final double price;
  ProductDalPulses({
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
List<ProductDalPulses> bestSellingDalPulses = [
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://tse1.mm.bing.net/th?id=OIP.WhEBV8rT0jeOXsKGQKUxewHaHa&pid=Api&P=0&h=220', name: "Pizza", price: 12.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://www.tatanutrikorner.com/cdn/shop/products/Tata-Sampann-Chana-Dal-1kg-_FOP_-with-Sanjeev-kapoor.png?v=1660200948', name: "Cake", price: 8.49),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://www.goodsdelivery.co.in/wp-content/uploads/2020/06/Masoor-Dal-1kg-FOP_1024x1024-1.png', name: "Burger", price: 6.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://mlbuihlmum5a.i.optimole.com/w:auto/h:auto/q:mauto/f:avif/https://aranyaorganic.com/wp-content/uploads/2022/07/Moong-Dal.png', name: "Green chilli", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://knackpackaging.com/img/cl/Pulses/1.png', name: "Pizza", price: 12.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://5.imimg.com/data5/ECOM/Default/2023/2/VJ/YM/VY/13510045/mix-dal-1000x1000.png', name: "Cake", price: 8.49),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://4.imimg.com/data4/LN/QB/MY-24528965/dal-1000x1000.png', name: "Apple", price: 6.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://tse4.mm.bing.net/th?id=OIP.47qUEywpRCgS8wJrSVGnrgAAAA&pid=Api&P=0&h=220', name: "Banana", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://tse2.mm.bing.net/th?id=OIP.knzSbTWBZCI-P_FFxqO90gHaHa&pid=Api&P=0&h=220', name: "Cabbage", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://tse1.mm.bing.net/th?id=OIP.Ez_FkIXIMoWyNMLEqJT4IwHaHa&pid=Api&P=0&h=220', name: "Carrots", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://png.pngtree.com/png-vector/20231220/ourmid/pngtree-wooden-bowl-of-urad-dal-black-gram-and-vigna-mungo-on-png-image_11177551.png', name: "Black grapes", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://tse1.mm.bing.net/th?id=OIP.WhEBV8rT0jeOXsKGQKUxewHaHa&pid=Api&P=0&h=220', name: "Pizza", price: 12.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://www.tatanutrikorner.com/cdn/shop/products/Tata-Sampann-Chana-Dal-1kg-_FOP_-with-Sanjeev-kapoor.png?v=1660200948', name: "Cake", price: 8.49),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://www.goodsdelivery.co.in/wp-content/uploads/2020/06/Masoor-Dal-1kg-FOP_1024x1024-1.png', name: "Burger", price: 6.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://mlbuihlmum5a.i.optimole.com/w:auto/h:auto/q:mauto/f:avif/https://aranyaorganic.com/wp-content/uploads/2022/07/Moong-Dal.png', name: "Green chilli", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://knackpackaging.com/img/cl/Pulses/1.png', name: "Pizza", price: 12.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://5.imimg.com/data5/ECOM/Default/2023/2/VJ/YM/VY/13510045/mix-dal-1000x1000.png', name: "Cake", price: 8.49),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://4.imimg.com/data4/LN/QB/MY-24528965/dal-1000x1000.png', name: "Apple", price: 6.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://tse4.mm.bing.net/th?id=OIP.47qUEywpRCgS8wJrSVGnrgAAAA&pid=Api&P=0&h=220', name: "Banana", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://tse2.mm.bing.net/th?id=OIP.knzSbTWBZCI-P_FFxqO90gHaHa&pid=Api&P=0&h=220', name: "Cabbage", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://tse1.mm.bing.net/th?id=OIP.Ez_FkIXIMoWyNMLEqJT4IwHaHa&pid=Api&P=0&h=220', name: "Carrots", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://png.pngtree.com/png-vector/20231220/ourmid/pngtree-wooden-bowl-of-urad-dal-black-gram-and-vigna-mungo-on-png-image_11177551.png', name: "Black grapes", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://tse1.mm.bing.net/th?id=OIP.WhEBV8rT0jeOXsKGQKUxewHaHa&pid=Api&P=0&h=220', name: "Pizza", price: 12.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://www.tatanutrikorner.com/cdn/shop/products/Tata-Sampann-Chana-Dal-1kg-_FOP_-with-Sanjeev-kapoor.png?v=1660200948', name: "Cake", price: 8.49),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://www.goodsdelivery.co.in/wp-content/uploads/2020/06/Masoor-Dal-1kg-FOP_1024x1024-1.png', name: "Burger", price: 6.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://mlbuihlmum5a.i.optimole.com/w:auto/h:auto/q:mauto/f:avif/https://aranyaorganic.com/wp-content/uploads/2022/07/Moong-Dal.png', name: "Green chilli", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://knackpackaging.com/img/cl/Pulses/1.png', name: "Pizza", price: 12.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://5.imimg.com/data5/ECOM/Default/2023/2/VJ/YM/VY/13510045/mix-dal-1000x1000.png', name: "Cake", price: 8.49),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://4.imimg.com/data4/LN/QB/MY-24528965/dal-1000x1000.png', name: "Apple", price: 6.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://tse4.mm.bing.net/th?id=OIP.47qUEywpRCgS8wJrSVGnrgAAAA&pid=Api&P=0&h=220', name: "Banana", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://tse2.mm.bing.net/th?id=OIP.knzSbTWBZCI-P_FFxqO90gHaHa&pid=Api&P=0&h=220', name: "Cabbage", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://tse1.mm.bing.net/th?id=OIP.Ez_FkIXIMoWyNMLEqJT4IwHaHa&pid=Api&P=0&h=220', name: "Carrots", price: 3.99),
  ProductDalPulses(id: generateUniqueId(), imagePath: 'https://png.pngtree.com/png-vector/20231220/ourmid/pngtree-wooden-bowl-of-urad-dal-black-gram-and-vigna-mungo-on-png-image_11177551.png', name: "Black grapes", price: 3.99),
];
