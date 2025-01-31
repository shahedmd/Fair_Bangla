import 'package:fair_bangla/Elemnts/datamodel.dart';
import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
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

  double get total => productsList.fold(
      0, (sum, item) => sum + item.products.price * item.quantity);

   addProduct(Products product, BuildContext context) {
    final index =
        productsList.indexWhere((item) => item.products.id == product.id);
    if (index != -1) {
      productsList[index].quantity++;
    } else {
      productsList.add(CartProduct(products: product, quantity: 1));
    }
WidgetsBinding.instance.addPostFrameCallback((_) {
  if (!context.mounted) return; // Prevents showing dialog if the widget is unmounted
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: CustomText(
            inputText: "Success",
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontsize: 20),
        content: CustomText(
          inputText: "Item has been added to the cart",
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontsize: 16,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: CustomText(
              inputText: "OK",
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontsize: 14,
            ),
          ),
        ],
      );
    },
  );
});
;
  }

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

  void removeProduct(String productId) {
    productsList.removeWhere((item) => item.products.id == productId);
  }

  final selectedColor = ''.obs; // Observable for the selected color
  final colors = <String>[].obs; // Observable list of colors

  // Method to update the selected color
  void updateSelectedColor(String color) {
    selectedColor.value = color;
  }

  // Method to update the colors list
  void setColors(List<String> newColors) {
    colors.value = newColors;
    if (newColors.isNotEmpty) {
      selectedColor.value = newColors[0]; // Default to the first color
    }
  }

  final productSize = ''.obs;
  final sizeList = <String>[].obs;

  void changeProductSize(String size) {
    productSize.value = size;
  }

  void changeSizeList(List<String> neWsizeList) {
    sizeList.value = neWsizeList;
    if (neWsizeList.isNotEmpty) {
      productSize.value = neWsizeList[0];
    }
  }
}
