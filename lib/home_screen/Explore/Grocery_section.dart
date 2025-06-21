import 'package:flutter/material.dart';
Widget buildGroceryCard(String imagePath, String text) {
  return Container(
    height: 60,
    width: 120,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
            child: Image.asset(imagePath,)),
        SizedBox(height: 5),
        Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}