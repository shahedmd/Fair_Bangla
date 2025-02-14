// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cartPage/getxCartControler.dart';

class ColorDropdown extends StatelessWidget {
  final String productId;

  ColorDropdown({super.key, required this.productId});

  final cartController = Get.find<CartControler>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var productColors = cartController.colors[productId] ?? [];
      var selectedColor = cartController.selectedColors[productId] ?? '';

      return DropdownButton<String>(
        
        value: productColors.contains(selectedColor) ? selectedColor : null,
        hint: const Text("Select Color"),
        dropdownColor: Colors.white,
        items: productColors.map((color) {
          return DropdownMenuItem<String>(
            value: color,
            child: Text(color), // Show color as text
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            cartController.updateSelectedColor(productId, value);
          }
        },
      );
    });
  }
}
