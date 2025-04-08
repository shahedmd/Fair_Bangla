import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;
  final String selectedColor;
  final String selectedSize;

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.selectedColor,
    required this.selectedSize,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'],
      name: map['name'],
      price: (map['price'] as num).toDouble(),
      quantity: map['quantity'],
      imageUrl: map['imageUrl'],
      selectedColor: map['selectedColor'],
      selectedSize: map['selectedSize'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
    };
  }
}


class OrderModel {
  final String orderId;
  final List<OrderItem> items;
  final double total;
  final String status;
  final DateTime? timestamp;

  OrderModel({
    required this.orderId,
    required this.items,
    required this.total,
    required this.status,
    this.timestamp,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'],
      items: (map['items'] as List<dynamic>)
          .map((item) => OrderItem.fromMap(item))
          .toList(),
      total: (map['total'] as num).toDouble(),
      status: map['status'],
      timestamp: (map['timestamp'] != null)
          ? (map['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'items': items.map((item) => item.toMap()).toList(),
      'total': total,
      'status': status,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}




class OrderController extends GetxController {
  var orders = <OrderModel>[].obs;
  var isLoading = true.obs;

  Future<void> fetchOrders(String userId) async {
    isLoading.value = true;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('orderId', isEqualTo: userId)
        .get();

    orders.value = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return OrderModel.fromMap({...data, 'timestamp': data['timestamp']});
    }).toList();

    isLoading.value = false;
  }
}

