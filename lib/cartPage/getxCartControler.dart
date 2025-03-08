// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fair_bangla/Elemnts/datamodel.dart';
import 'package:url_launcher/url_launcher.dart';

class CartProduct {
  Products products;
  int quantity;

  CartProduct({
    required this.products,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
        "products": products.toJson(),
        "quantity": quantity,
      };

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      products: Products.fromJson(json["products"]),
      quantity: json["quantity"],
    );
  }
}

class CartControler extends GetxController {
  var productsList = <CartProduct>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  double get total => productsList.fold(
      0, (sum, item) => sum + item.products.price * item.quantity);

  void addProduct(Products product, BuildContext context) {
    final index =
        productsList.indexWhere((item) => item.products.id == product.id);
    if (index != -1) {
      productsList[index].quantity++;
    } else {
      productsList.add(CartProduct(products: product, quantity: 1));
    }

    saveCart();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
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
      saveCart();
    }
  }

  void removeProduct(String productId) {
    productsList.removeWhere((item) => item.products.id == productId);
    selectedColors.remove(productId);
    saveCart();
  }

  final selectedColors = <String, String>{}.obs;
  final colors = <String, List<String>>{}.obs;

  void setColors(String productId, List<String> newColors) {
    colors[productId] = newColors;
    if (newColors.isNotEmpty) {
      selectedColors[productId] = newColors.first;
    } else {
      selectedColors.remove(productId); // Remove if no colors available
    }

    saveCart();
  }

  void updateSelectedColor(String productId, String color) {
    selectedColors[productId] = color;
    saveCart();
    update();
  }

  String getSelectedColor(String productId) {
    String selectedColor = selectedColors[productId] ?? "Not Selected";
    return selectedColor;
  }

  final seledtedSize = <String, String>{}.obs;
  final productsSize = <String, List<String>>{}.obs;

  void setProductsSize(String productId, List<String> setProdutsSize) {
    productsSize[productId] = setProdutsSize;
    if (setProdutsSize.isNotEmpty) {
      seledtedSize[productId] = setProdutsSize.first;
    }

    saveCart();
  }

  void updateSize(String productsId, String size) {
    seledtedSize[productsId] = size;
    saveCart();
    update();
  }

  String getSelectedSize(String productId) {
    return seledtedSize[productId] ?? "Not Selected";
  }

  void saveCart() {
    List<Map<String, dynamic>> cartData =
        productsList.map((item) => item.toJson()).toList();
    box.write("cart", jsonEncode(cartData));
    box.write("selectedColors", jsonEncode(selectedColors));
    box.write("selectedSize", jsonEncode(seledtedSize));
  }

  void loadCart() {
    String? storedCart = box.read("cart");
    String? storedColors = box.read("selectedColors");
    String? storeSize = box.read("selectedSize");

    if (storedCart != null) {
      List<dynamic> decoded = jsonDecode(storedCart);
      productsList
          .assignAll(decoded.map((e) => CartProduct.fromJson(e)).toList());
    }

    if (storedColors != null) {
      selectedColors
          .assignAll(Map<String, String>.from(jsonDecode(storedColors)));
    }
    if (storeSize != null) {
      seledtedSize.assignAll(Map<String, String>.from(jsonDecode(storeSize)));
    }
  }

  Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    int colorInt = int.parse(hex, radix: 16);
    return Color(0xFF000000 | colorInt);
  }

  void sendtomessenger(BuildContext context) async {
    final Uri url = Uri.parse("https://m.me/61573828326251");

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              content: const Text("Something went wrong cant send message"),
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

   
  }








    void sendtowhatsapp(BuildContext context) async {
    final Uri url = Uri.parse("https://wa.me/8801995767837");

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              content: const Text("Something went wrong cant send message"),
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

   
  }
}
