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
            elmentsControler.navbar(),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 230.r),
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
                                itemCount: widget.products.colors.length,
                                itemBuilder: (context, index) {
                                  String colorHex =
                                      widget.products.colors[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // Update selected color using GetX controller
                                      cartController.updateSelectedColor(
                                          widget.products.id, colorHex);
                                    },
                                    child: Obx(() {
                                      // Highlight selected color
                                      return Container(
                                        margin: EdgeInsets.all(5.r),
                                        width: 20.w,
                                       
                                        decoration: BoxDecoration(
                                           color:
                                            cartController.hexToColor(colorHex),
                                          border: cartController
                                                      .getSelectedColor(
                                                          widget.products.id) ==
                                                  colorHex
                                              ? Border.all(
                                                  color: Colors.black,
                                                  width: 2) // Example highlight
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
                      ],
                    ),
                  ),
                  Container(
                    height: 650.h,
                    width: 400.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 25.h),
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.all(Radius.circular(20.r))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            inputText: "Product Type: Casual Loafer Half Shoe",
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontsize: 12),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomText(
                            inputText: "Material: Soft Fabric with Rubber Sole",
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
                        SizedBox(
                          height: 20.h,
                        ),
                        elmentsControler
                            .customButton("Add To Cart", Colors.black, () {
                          cartController.addProduct(widget.products, context);
                        }, Colors.white),
                        SizedBox(
                          width: 30.w,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
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
