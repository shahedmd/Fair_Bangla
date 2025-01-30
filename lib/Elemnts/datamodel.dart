import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String name;
  String url;
  double price;
  String id;
  List<String> colors;
  

  Products({required this.name,  required this.price, required this.url, required this.id, required this.colors});

  factory Products.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Products(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      url: data['url'] ?? '',
      colors: List<String>.from(data['color']??[])
    
    );
  }  
}