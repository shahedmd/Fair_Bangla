// ignore_for_file: invalid_use_of_protected_member

import 'package:fair_bangla/Elemnts/datamodel.dart';
import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:fair_bangla/Elemnts/webElements.dart';
import 'package:fair_bangla/cartPage/getxCartControler.dart';
import 'package:fair_bangla/firebase.auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../globalvar.dart';
import '../usermodel.dart';

// ignore: must_be_immutable
class CashOnDelivery extends StatefulWidget {
  Products products;
  RxMap selectedSize;
  RxMap selectedColor;

  CashOnDelivery(
      {super.key,
      required this.products,
      required this.selectedSize,
      required this.selectedColor});

  @override
  State<CashOnDelivery> createState() => _CashOnDeliveryState();
}

class _CashOnDeliveryState extends State<CashOnDelivery> {
  final elementControler = Elements();
  final cartController = CartControler();

  final auth = AuthController();

  var quantity = 1.obs;

  var totalbill = 0.obs;

  var userData = Rxn<UserDAta>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cartController.setColors(widget.products.id, widget.products.colors);
      cartController.setProductsSize(widget.products.id, widget.products.size);

      totalbill.value = (quantity.value * widget.products.price).toInt();

      ever(quantity, (_) {
        totalbill.value = (quantity.value * widget.products.price).toInt();
      });
      userData.value = await auth.getuser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 550.h,
                width: 1300.w,
                child: Stack(children: [
                  elementControler.navbar(),
                  Positioned(
                      top: 200.h,
                      left: 250.w,
                      child: FutureBuilder(
                          future: auth.getuser(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: Text('No products found.'));
                            }

                            UserDAta userdata = snapshot.data!;

                            return Row(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  height: 300.h,
                                  width: 370.w,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 10,
                                          spreadRadius: 4,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.r))),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                        Center(
                                          child: Icon(
                                            Icons.person_pin,
                                            size: 80.r,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        CustomText(
                                          inputText: "Customer Details",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontsize: 20,
                                        ),
                                        SizedBox(height: 15.h),
                                        CustomText(
                                            inputText:
                                                userdata.username.toString(),
                                            fontsize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        CustomText(
                                            inputText: userdata.email,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontsize: 15),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        CustomText(
                                            inputText:
                                                "User ID: ${userdata.uid}",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontsize: 15)
                                      ]),
                                ),
                                SizedBox(
                                  width: 150.w,
                                ),
                                Container(
                                  height: 300.h,
                                  width: 370.w,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 10,
                                          spreadRadius: 4,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.r))),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                        Center(
                                          child: Icon(
                                            Icons.place,
                                            size: 80.r,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                        CustomText(
                                            inputText: "Delivery Address",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontsize: 20),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        CustomText(
                                            inputText:
                                                userdata.address.toString(),
                                            fontsize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ]),
                                )
                              ],
                            );
                          })),
                  Positioned(
                    top: 80.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 475.w),
                      child: elementControler.customDropdown(),
                    ),
                  )
                ]),
              ),
              Column(
                children: [
                  CustomText(
                      inputText: "Order Details",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 25),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                      padding: EdgeInsets.all(25.r),
                      width: 1100.w,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 4,
                          offset: const Offset(0, 6),
                        ),
                      ]),
                      child: Column(
                        children: [
                          Container(
                            width: 650.w,
                            padding: EdgeInsets.symmetric(horizontal: 50.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 220.h,
                                  width: 250.w,
                                  child: Image.network(widget.products.url),
                                ),
                                SizedBox(
                                  height: 270.h,
                                  width: 250.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          inputText: widget.products.name,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontsize: 16),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      CustomText(
                                          inputText:
                                              widget.products.price.toString(),
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontsize: 16),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Obx(
                                        () {
                                          if (cartController
                                              .seledtedSize.isEmpty) {
                                            return const Text(
                                                "No size selected");
                                          }
                                          return CustomText(
                                              inputText: widget
                                                  .selectedSize.values
                                                  .join(', '),
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontsize: 16);
                                        },
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Obx(
                                        () {
                                          if (cartController
                                              .seledtedSize.isEmpty) {
                                            return const Text("No size colors");
                                          }
                                          return CustomText(
                                              inputText: widget
                                                  .selectedColor.values
                                                  .join(', '),
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontsize: 16);
                                        },
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              color: Colors.black,
                                              onPressed: () {
                                                quantity.value =
                                                    quantity.value + 1;
                                              },
                                              icon: const Icon(Icons.add)),
                                          Obx(() => CustomText(
                                              inputText:
                                                  quantity.value.toString(),
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontsize: 15)),
                                          IconButton(
                                              color: Colors.black,
                                              onPressed: () {
                                                quantity.value =
                                                    quantity.value - 1;
                                              },
                                              icon: const Icon(Icons.remove)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Obx(
                                        () => CustomText(
                                            inputText: totalbill.toString(),
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontsize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h),
                          SizedBox(
                            width: 650.w,
                            child: CustomText(
                                inputText:
                                    "The Air Jordan shoe is an iconic sneaker line by Nike, originally designed for basketball legend Michael Jordan. Known for its stylish designs, premium materials, and cutting-edge technology, Air Jordans have become a cultural phenomenon, blending sports, fashion, and streetwear. Each release features unique colorways and innovations, making them highly sought-after by sneaker enthusiasts worldwide.",
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontsize: 14),
                          ),
                          SizedBox(height: 30.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                      inputText:
                                          "Warrenty :  7 days Replacement",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontsize: 12),
                                ],
                              ),
                              SizedBox(
                                width: 150.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                      inputText:
                                          "Weight: Very Light and Durable",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontsize: 12),
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                  SizedBox(
                    height: 50.h,
                  ),
                  ordernow(() {
                    sendtocashonDelivery(
                        userData.value!.username,
                        userData.value!.address,
                        userData.value!.email,
                        userData.value!.phone,
                        widget.products.name,
                        widget.selectedSize.value.toString(),
                        widget.selectedColor.value.toString(),
                        widget.products.price.toString(),
                        totalbill.toString(),
                        quantity.toString(),
                        context
                        );
                  }, "Order Now"),
                  SizedBox(
                    height: 80.h,
                  ),
                  elementControler.bottomNavbar()
                ],
              )
            ],
          ),
        ),
      ),
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
        child: Obx(
          () => isloading.value
              ? const CircularProgressIndicator()
              : CustomText(
                  inputText: title,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontsize: 20),
        ),
      ),
    ),
  );
}
