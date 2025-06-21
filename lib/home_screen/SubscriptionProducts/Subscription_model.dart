import 'package:flutter/cupertino.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  // Factory method to generate a product with auto ID
  factory ProductModel.autoId({
    required String name,
    required double price,
    required String imageUrl,
    required String description,
  }) {
    return ProductModel(
      id: UniqueKey().toString(),
      name: name,
      price: price,
      imageUrl: imageUrl,
      description: description,
    );
  }
}
List<ProductModel> subscriptionProducts = [
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  ProductModel.autoId(
      name: 'Milk Pack',
      price: 50,
      imageUrl: 'assets/milk.png',
      description: 'Fresh dairy milk'
  ),
  ProductModel.autoId(
      name: 'Monthly Vegetables',
      price: 1200,
      imageUrl: 'assets/vegetables.png',
      description: 'Seasonal vegetables bundle'
  ),
  ProductModel.autoId(
      name: 'Fruits Basket',
      price: 999,
      imageUrl: 'assets/vegetables.png',
      description: 'Assorted fresh fruits'
  ),
  ProductModel.autoId(
      name: 'Protein Pack',
      price: 1500,
      imageUrl: 'assets/milk.png',
      description: 'High protein food bundle'
  ),
  // Add more as needed
];