// ignore_for_file: file_names

import 'package:fair_bangla/Elemnts/datamodel.dart';
import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:fair_bangla/cartPage/getxCartControler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Elemnts/webElements.dart';
import '../cartPage/cartPage.dart';
import 'cashondelivery.dart';

// ignore: must_be_immutable
class ProductsDetails extends StatefulWidget {
  Products products;
  ProductsDetails({super.key, required this.products});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  final elmentsControler = Get.find<Elements>();
  final cartController = Get.find<CartControler>();
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController.setColors(widget.products.id, widget.products.colors);
      cartController.setProductsSize(widget.products.id, widget.products.size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 900.h,
              width: 1300.w,
              child: Stack(
                children: [
                  elmentsControler.navbar(),
                  Positioned(
                    top: 170.h,
                    width: 1200.w,
                    child: Padding(
                      padding: EdgeInsets.only(left: 130.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    inputText: widget.products.name,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 35),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomText(
                                    inputText:
                                        "Price: ${widget.products.price.toString()}",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 23),
                                SizedBox(
                                  height: 25.h,
                                ),
                                SizedBox(
                                    height: 450.h,
                                    width: 450.h,
                                    child: Image.network(
                                      widget.products.url,
                                      fit: BoxFit.contain,
                                    )),
                                Row(
                                  children: [
                                    CustomText(
                                        inputText: "Product Colors",
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontsize: 15),
                                    SizedBox(width: 20.w),
                                    SizedBox(
                                      height: 30.h,
                                      width: 120.w,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            widget.products.colors.length,
                                        itemBuilder: (context, index) {
                                          final colorHex =
                                              widget.products.colors[index];
                                          return GestureDetector(
                                            onTap: () {
                                              // Update selected color using GetX controller
                                              cartController
                                                  .updateSelectedColor(
                                                      widget.products.id,
                                                      colorHex);
                                            },
                                            child: Obx(() {
                                              // Highlight selected color
                                              return Container(
                                                margin: EdgeInsets.all(5.r),
                                                width: 20.w,
                                                decoration: BoxDecoration(
                                                  color: cartController
                                                      .hexToColor(colorHex),
                                                  border: cartController
                                                              .getSelectedColor(
                                                                  widget
                                                                      .products
                                                                      .id) ==
                                                          colorHex
                                                      ? Border.all(
                                                          color: Colors.black,
                                                          width:
                                                              2) // Example highlight
                                                      : null,
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                        inputText: "Product Size",
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontsize: 15),
                                    SizedBox(width: 20.w),
                                    SizedBox(
                                      height: 30.h,
                                      width: 120.w,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: widget.products.size.length,
                                        itemBuilder: (context, index) {
                                          final size =
                                              widget.products.size[index];
                                          return GestureDetector(
                                            onTap: () {
                                              cartController.updateSize(
                                                  widget.products.id, size);
                                            },
                                            child: Obx(() {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.w),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    border: cartController
                                                                .getSelectedSize(
                                                                    widget
                                                                        .products
                                                                        .id) ==
                                                            size
                                                        ? Border.all(
                                                            color: Colors.black,
                                                            width:
                                                                2) // Example highlight
                                                        : null,
                                                  ),
                                                  child: CustomText(
                                                      inputText: size,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontsize: 18),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 800.h,
                            width: 400.w,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 25.h),
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.r))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: CustomText(
                                      inputText: "Product Details",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontsize: 20),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomText(
                                    inputText: "About Products",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 15),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  width: 250.w,
                                  child: CustomText(
                                      inputText:
                                          "The Air Jordan shoe is an iconic sneaker line by Nike, originally designed for basketball legend Michael Jordan. Known for its stylish designs, premium materials, and cutting-edge technology, Air Jordans have become a cultural phenomenon, blending sports, fashion, and streetwear. Each release features unique colorways and innovations, making them highly sought-after by sneaker enthusiasts worldwide.",
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontsize: 12),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomText(
                                    inputText: "Brand Name : Nike",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 12),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomText(
                                    inputText: "Model/Serise :  Air-Jorder 5",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 12),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomText(
                                    inputText: "Warrenty :  7 days Replacement",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 12),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomText(
                                    inputText:
                                        "Product Type: Casual Loafer Half Shoe",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 12),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomText(
                                    inputText:
                                        "Material: Soft Fabric with Rubber Sole",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 12),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomText(
                                    inputText: "Weight: Very Light and Durable",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 12),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomText(
                                    inputText: "Gender: Men & Female",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 12),
                                
                                elmentsControler.customButton(
                                    "Add To Cart", Colors.black, () {
                                  cartController.addProduct(
                                      widget.products, context);
                                }, Colors.white),
                                
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 475.w),
                      child: elmentsControler.customDropdown(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            CustomText(
                inputText: "Order Now",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontsize: 25),
            SizedBox(
              height: 40.h,
            ),
            ordernow(() {
              cartController.sendtomessenger(context);
            }, "Message us on facebook"),
            SizedBox(
              height: 30.h,
            ),
            ordernow(() {
              cartController.sendtowhatsapp(context);
            }, "Message us on Whatsapp"),
            SizedBox(
              height: 30.h,
            ),
            ordernow(() {
              Get.to(() => CashOnDelivery(
                    products: widget.products,
                    selectedColor: cartController.selectedColors,
                    selectedSize: cartController.seledtedSize,
                  ));
            }, "Cash On Delivery"),
            SizedBox(
              height: 80.h,
            ),
            elmentsControler.bottomNavbar()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow,
          child: const Icon(
            Icons.shop,
            color: Colors.black,
          ),
          onPressed: () {
            Get.to(const FairBanlgCart());
          }),
    );
  }
}

Widget ordernow(VoidCallback voidCallback, String title) {
  return InkWell(
    onTap: voidCallback,
    child: Container(
      height: 100.h,
      width: 700.w,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 4,
              offset: const Offset(0, 6),
            ),
          ],
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      child: Center(
        child: CustomText(
            inputText: title,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontsize: 20),
      ),
    ),
  );
}
