import 'package:flutter/material.dart';

class AppConstants {
  static const String productImageUrl =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';

  static List<String> categoriesList = [
    'Phones',
    'Laptops',
    'Electronics',
    'Watches',
    'Clothes',
    'Shoes',
    'Books',
    'Cosmetics',
    "Accessories",
  ];
  static List<DropdownMenuItem<String>>? get categoryProducts {
    List<DropdownMenuItem<String>> categoryItems =
        List<DropdownMenuItem<String>>.generate(categoriesList.length, (index) {
      return DropdownMenuItem(
        value: categoriesList[index],
        child: Text(
          categoriesList[index],
        ),
      );
    });
    return categoryItems;
  }
}
