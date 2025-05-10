// HomePageProductFetchController.dart
// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'datamodel.dart';
import 'package:flutter/material.dart';
class HomePageProductFetchControler extends GetxController {
  var allProducts = <Products>[].obs;
  var filteredProducts = <Products>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final snapshot = await FirebaseFirestore.instance
          .collection('HomepageProductDataBase')
          .get();
      allProducts.value =
          snapshot.docs.map((doc) => Products.fromFirestore(doc)).toList();
      filteredProducts.value = allProducts; // initially show all
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      filteredProducts.value = allProducts;
    } else {
      filteredProducts.value = allProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
