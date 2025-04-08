// Import statements...
// ignore_for_file: file_names

import 'package:fair_bangla/Webscreen/finalorder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Elemnts/helpingwidgets.dart';
import '../Elemnts/webElements.dart';
import 'getxCartControler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FairBanlgCart extends StatefulWidget {
  const FairBanlgCart({super.key});

  @override
  State<FairBanlgCart> createState() => _FairBanlgCartState();
}

class _FairBanlgCartState extends State<FairBanlgCart> {
  final cartControler = Get.find<CartControler>();
  final elementControler = Get.find<Elements>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            elementControler.navbar(),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (cartControler.productsList.isEmpty) {
                    return const Center(child: Text('Your cart is empty'));
                  }

                  return SizedBox(
                    height: 750.h,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      itemCount: cartControler.productsList.length,
                      itemBuilder: (context, index) {
                        final item = cartControler.productsList[index];
                        final productId = item.products.id;

                        return Padding(
                          padding: EdgeInsets.all(20.0.r),
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 252, 242, 148),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.r))),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 200.h,
                                  width: 200.w,
                                  child: Image.network(item.products.url),
                                ),
                                SizedBox(
                                  width: 100.w,
                                ),
                                Column(
                                  children: [
                                    CustomText(
                                        inputText: item.products.name,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontsize: 15),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomText(
                                        inputText:
                                            '\$${item.products.price.toStringAsFixed(2)}',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontsize: 15)
                                  ],
                                ),
                                SizedBox(
                                  width: 100.w,
                                ),
                                Column(
                                  children: [
                                    Text(cartControler.selectedColors[productId]
                                        .toString()),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(cartControler.seledtedSize[productId]
                                        .toString()),
                                  ],
                                ),
                                SizedBox(
                                  width: 80.w,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    cartControler.updateQuantity(
                                        productId, item.quantity - 1);
                                  },
                                ),
                                Text(
                                  item.quantity.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    cartControler.updateQuantity(
                                        productId, item.quantity + 1);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    cartControler.removeProduct(productId);
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
                SizedBox(width: 50.w),
                Column(
                  children: [
                    Container(
                      height: 400.h,
                      width: 280.w,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 252, 242, 148),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            return CustomText(
                              inputText:
                                  'Total: \$${cartControler.total.toStringAsFixed(2)}',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontsize: 25,
                            );
                          }),
                          SizedBox(height: 15.h),
                          CustomText(
                            inputText:
                                "Total Items: ${cartControler.productsList.length}",
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontsize: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    elementControler.customButton("Order Now", Colors.black,
                        () {
                      Get.to(() => const FinalOrder());
                    }, Colors.yellow)
                  ],
                ),
              ],
            ),
            SizedBox(height: 40.h),
            elementControler.bottomNavbar()
          ],
        ),
      ),
    );
  }
}
