// ignore_for_file: file_names

import 'package:fair_bangla/Elemnts/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProduct {
  Products products;
  int quantity;

  CartProduct({
    required this.products,
    this.quantity = 1,
  });
}

class CartControler extends GetxController {
  var productsList = <CartProduct>[].obs;

  // Get total cart price
  double get total => productsList.fold(
      0, (sum, item) => sum + item.products.price * item.quantity);

  // Add a product to the cart
  void addProduct(Products product, BuildContext context) {
    final index =
        productsList.indexWhere((item) => item.products.id == product.id);
    if (index != -1) {
      productsList[index].quantity++;
    } else {
      productsList.add(CartProduct(products: product, quantity: 1));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return; // Prevent errors when widget is unmounted
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Success",
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: const Text("Item has been added to the cart"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    });
  }

  // Update product quantity
  void updateQuantity(String productId, int quantity) {
    final index =
        productsList.indexWhere((item) => item.products.id == productId);
    if (index != -1) {
      if (quantity == 0) {
        productsList.removeAt(index);
      } else {
        productsList[index].quantity = quantity;
        productsList.refresh();
      }
    }
  }

  final selectedColors = <String, String>{}.obs;
  final colors = <String, List<String>>{}.obs;

  // Remove product from cart
  void removeProduct(String productId) {
    productsList.removeWhere((item) => item.products.id == productId);
    selectedColors.remove(productId); // Remove associated color
  }

  // Set available colors for a product
  void setColors(String productId, List<String> newColors) {
    colors[productId] = newColors;
    if (newColors.isNotEmpty) {
      selectedColors[productId] = newColors.first; // Default first color
    }
  }

  // Update selected color when user changes it
  void updateSelectedColor(String productId, String color) {
    selectedColors[productId] = color;
    update(); // Notify UI
  }

  // Get selected color for a product
  String getSelectedColor(String productId) {
    return selectedColors[productId] ?? "Not Selected";
  }

  final seledtedSize = <String, String>{}.obs;
  final productsSize = <String, List<String>>{}.obs;

  void setProductsSize(String productId, List<String> setProdutsSize) {
    productsSize[productId] = setProdutsSize;
    if (setProdutsSize.isNotEmpty) {
      seledtedSize[productId] = setProdutsSize.first;
    }
  }

  void updateSize(String productsId, String size){
    seledtedSize[productsId] = size;
    update();

  }


    String getSelectedSize(String productId) {
    return seledtedSize[productId] ?? "Not Selected";
  }


  Color hexToColor(String hex) {
  hex = hex.replaceFirst('#', ''); // Remove the #
  int colorInt = int.parse(hex, radix: 16); // Convert to integer
  return Color(0xFF000000 | colorInt); // Ensure full opacity
}

}
