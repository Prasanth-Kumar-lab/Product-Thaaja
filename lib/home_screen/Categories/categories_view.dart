import 'package:flutter/material.dart';
import 'package:thaaja/home_screen/Categories/category_model.dart';
class FullCategoryPage extends StatefulWidget {

  @override
  State<FullCategoryPage> createState() => _FullCategoryPageState();
}

class _FullCategoryPageState extends State<FullCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Categories')),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return buildCategoryCard(categories[index]);
        },
      ),
    );
  }
}

