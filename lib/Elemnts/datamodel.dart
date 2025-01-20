import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Products {
  String name;
  String url;
  double price;
  

  Products({required this.name,  required this.price, required this.url});

  factory Products.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Products(
      name: data['name'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      url: data['imageUrl'] ?? '',
    
    );
  }  
}