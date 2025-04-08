import 'package:fair_bangla/Elemnts/webElements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../Elemnts/helpingwidgets.dart';
import '../myOrdermodel.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final elementscontroller = Elements();

  final OrderController controller = Get.put(OrderController());

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    controller.fetchOrders(user!.uid);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 1100.h,
                width: 1300.w,
                child: Stack(children: [
                  elementscontroller.navbar(),
                  Positioned(
                    top: 120.h,
                    left: 600.w,
                    child: CustomText(
                        inputText: "My Account Orders",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontsize: 22),
                  ),
                  Positioned(
                    top: 220.h,
                    left: 0,
                    right: 0,
                    bottom: 20.h,
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (controller.orders.isEmpty) {
                        return Center(child: Text("No orders found."));
                      }

                      return ListView.builder(
                        itemCount: controller.orders.length,
                        itemBuilder: (context, index) {
                          final order = controller.orders[index];

                          return Card(
                            margin: EdgeInsets.all(12),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Order ID: ${order.orderId}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("Total: \$${order.total}"),
                                  Text("Status: ${order.status}"),
                                  Text("Date: ${order.timestamp}"),
                                  SizedBox(height: 10),
                                  Text("Items:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  ...order.items.map((item) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          Image.network(item.imageUrl,
                                              width: 50, height: 50),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(item.name),
                                                Text("Price: \$${item.price}"),
                                                Text("Qty: ${item.quantity}"),
                                                Text(
                                                    "Color: ${item.selectedColor}"),
                                                Text(
                                                    "Size: ${item.selectedSize}"),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
