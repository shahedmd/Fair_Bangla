// Import statements...
// ignore_for_file: file_names

import 'package:fair_bangla/Webscreen/productSize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Elemnts/helpingwidgets.dart';
import '../Elemnts/webElements.dart';
import '../Webscreen/colorsSelection.dart';
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ListView.builder(
                      itemCount: cartControler.productsList.length,
                      itemBuilder: (context, index) {
                        final item = cartControler.productsList[index];
                        final productId = item.products.id;

                        return ListTile(
                          leading: Image.network(item.products.url),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.products.name),
                              Text('\$${item.products.price.toStringAsFixed(2)}'),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              
                              ColorDropdown(productId: productId), 
                              SizedBox(width: 10.w,),
                              SizeDropDown(productId: productId)
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  cartControler.updateQuantity(productId, item.quantity - 1);
                                },
                              ),
                              Text(
                                item.quantity.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  cartControler.updateQuantity(productId, item.quantity + 1);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  cartControler.removeProduct(productId);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),

                SizedBox(width: 50.w),

                Container(
                  height: 400.h,
                  width: 280.w,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        return CustomText(
                          inputText: 'Total: \$${cartControler.total.toStringAsFixed(2)}',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontsize: 25,
                        );
                      }),
                      SizedBox(height: 15.h),
                      CustomText(
                        inputText: "Total Items: ${cartControler.productsList.length}",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontsize: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
