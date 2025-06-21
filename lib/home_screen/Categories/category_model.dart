import 'package:flutter/material.dart';

class Category {
  final String imagePath;  // Added this for the image path
  final String name;
  final Color color;

  Category({required this.imagePath, required this.name, this.color = Colors.green});
}

List<Category> categories = [
  Category(imagePath: 'assets/apple.png', name: 'Fruits', color: Colors.red),
  Category(imagePath: 'assets/vegetables.png', name: 'Vegetables', color: Colors.green),
  Category(imagePath: 'assets/milk.png', name: 'Dairy', color: Colors.blue),
  Category(imagePath: 'assets/fast-food.png', name: 'Food', color: Colors.orange),
  Category(imagePath: 'assets/rice.png', name: 'Rice', color: Colors.brown),
  Category(imagePath: 'assets/chicken-leg.png', name: 'Chicken', color: Colors.yellow),
  Category(imagePath: 'assets/fish.png', name: 'Fish', color: Colors.teal),
  Category(imagePath: 'assets/Biryani.png', name: 'Biryani', color: Colors.purple),
];

Widget buildCategoryCard(Category category) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: category.color.withOpacity(0.2),
          ),
          child: Center(
            child: Image.asset(
              category.imagePath,
              width: 40,  // Image size adjustment
              height: 40, // Image size adjustment
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          category.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
