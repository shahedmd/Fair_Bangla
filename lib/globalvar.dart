import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cartPage/getxCartControler.dart';

var myorderslist = <CartProduct>[].obs;

var isloading = false.obs;

User? user = FirebaseAuth.instance.currentUser;
void sendtocashonDelivery(
  String name,
  String add,
  String email,
  String phone,
  String productname,
  String productsize,
  String productsColor,
  String price,
  String totalbill,
  String quantity,
  BuildContext context
) async {
  isloading.value = true;

  await FirebaseFirestore.instance.collection("CashOnDelivery").doc().set({
    "name": name,
    "address": add,
    "email": email,
    "phone": phone,
    "orders": {
      "productname": productname,
      "size": productsize,
      "color": productsColor,
      "price": price,
      "totalbill": totalbill,
      "quantity": quantity
    },
    "orderId": user!.uid,
    "timestamp": FieldValue.serverTimestamp()
  });

  isloading.value = false;

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
