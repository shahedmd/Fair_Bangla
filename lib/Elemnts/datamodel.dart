// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Products {
  String name;
  String url;
  double price;
  String id;
  List<String> colors;
  List<String> size;

  Products({
    required this.name,
    required this.price,
    required this.url,
    required this.id,
    required this.colors,
    required this.size,
  });

  factory Products.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Products(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      url: data['url'] ?? '',
      colors: List<String>.from(data['color'] ?? []),
      size: List<String>.from(data['size'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'url': url,
      'color': colors,
      'size': size,
    };
  }

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      url: json['url'],
      colors: List<String>.from(json['color']),
      size: List<String>.from(json['size']),
    );
  }
}
