// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cartPage/getxCartControler.dart';

class SizeDropDown extends StatelessWidget {
  final String productId;

  SizeDropDown({super.key, required this.productId});

  final cartController = Get.find<CartControler>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var productSize = cartController.productsSize[productId] ?? [];
      var selectedSize = cartController.seledtedSize[productId] ?? '';

      return DropdownButton<String>(
        value: productSize.contains(selectedSize) ? selectedSize : null,
        hint: const Text("Select Color"),
        dropdownColor: Colors.white,
        items: productSize.map((color) {
          return DropdownMenuItem<String>(
            value: color,
            child: Text(color), // Show color as text
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            cartController.updateSize(productId, value);
          }
        },
      );
    });
  }
}
