
// ignore_for_file: file_names

import 'package:fair_bangla/Elemnts/webElements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Elemnts/helpingwidgets.dart';
import '../myOrdermodel.dart';
import '../Webscreen/pdf/pdfapi.dart';
class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final elementscontroller = Elements();
  final OrderController controller = Get.put(OrderController());
  User? user = FirebaseAuth.instance.currentUser;
  final pdfcontroller = Get.put(PDFcontroller());

  @override
  void initState() {
    super.initState();
    if (user != null) {
      controller.fetchOrders(user!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return const SizedBox(
                    height: 400,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final height = controller.orders.length * 800.h;

                return SizedBox(
                  height: height,
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
                        fontsize: 22,
                      ),
                    ),
                    Positioned(
                      top: 220.h,
                      left: 0,
                      right: 0,
                      bottom: 20.h,
                      child: controller.orders.isEmpty
                          ? const Center(child: Text("No orders found."))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.orders.length,
                              itemBuilder: (context, index) {
                                final order = controller.orders[index];
                  
                                return Container(
                                  margin: EdgeInsets.all(30.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.yellow.shade100,
                                        Colors.yellow.shade300,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.r),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Order ID: ${order.orderId}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  order.status,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),
                                                elementscontroller
                                                    .customButton(
                                                        "Download Bill",
                                                        Colors.black,
                                                        () {
                                                           pdfcontroller.generateAndPrintOrderPDF(order);
                                                        },
                                                        Colors.yellow)
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          "Total: \$${order.total}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "Date: ${order.timestamp}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                  
                                        // Item list header
                                        const Text(
                                          "Items:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                  
                                        ...order.items.map((item) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 6.h),
                                            padding: EdgeInsets.all(10.r),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              border: Border.all(
                                                  color: Colors.black12),
                                            ),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  child: Image.network(
                                                    item.imageUrl,
                                                    width: 50.w,
                                                    height: 50.h,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(width: 12.w),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(item.name,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15.sp,
                                                              color: Colors
                                                                  .black)),
                                                      Text(
                                                          "Price: \$${item.price}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                      Text(
                                                          "Qty: ${item.quantity}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                      Text(
                                                          "Color: ${item.selectedColor}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                      Text(
                                                          "Size: ${item.selectedSize}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    Positioned(
                      top: 80.h,
                      child: Padding(
                        padding: EdgeInsets.only(left: 455.w),
                        child: elementscontroller.customDropdown(),
                      ),
                    )
                  ]),
                );
              }),
              SizedBox(height: 80.h),
              elementscontroller.bottomNavbar()
            ],
          ),
        ),
      ),
    );
  }
} 