import 'package:fair_bangla/Elemnts/webElements.dart';
import 'package:fair_bangla/Webscreen/payment/paymentapi.dart';
import 'package:fair_bangla/cartPage/getxCartControler.dart';
import 'package:fair_bangla/firebase.auth.dart';
import 'package:fair_bangla/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Elemnts/helpingwidgets.dart';

class FinalOrder extends StatefulWidget {
  const FinalOrder({super.key});

  @override
  State<FinalOrder> createState() => _FinalOrderState();
}

class _FinalOrderState extends State<FinalOrder> {
  final cartController = Get.find<CartControler>();
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  final elements = Elements();
  final auth = AuthController();
  final pay = PaymentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Column(children: [
                  SizedBox(
                      height: 550.h,
                      width: 1300.w,
                      child: Stack(children: [
                        elements.navbar(),
                        Positioned(
                            left: 200.w,
                            top: 200.h,
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
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  }
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: Text('No products found.'));
                                  }

                                  UserDAta userdata = snapshot.data!;

                                  return Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        height: 300.h,
                                        width: 370.w,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
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
                                                fontsize: 18,
                                              ),
                                              SizedBox(height: 15.h),
                                              CustomText(
                                                  inputText: userdata.username
                                                      .toString(),
                                                  fontsize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              CustomText(
                                                  inputText: userdata.email,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontsize: 14),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              CustomText(
                                                  inputText:
                                                      "User ID: ${userdata.uid}",
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontsize: 14)
                                            ]),
                                      ),
                                      SizedBox(
                                        width: 150.w,
                                      ),
                                      Container(
                                        height: 300.h,
                                        width: 370.w,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
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
                                                height: 20.h,
                                              ),
                                              CustomText(
                                                  inputText: "Delivery Address",
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontsize: 18),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              CustomText(
                                                  inputText: userdata.address
                                                      .toString(),
                                                  fontsize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ]),
                                      )
                                    ],
                                  );
                                })),
                        Positioned(
                          top: 80.h,
                          child: Padding(
                            padding: EdgeInsets.only(left: 455.w),
                            child: elements.customDropdown(),
                          ),
                        )
                      ])),
                  CustomText(
                      inputText: "Order Details",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 20),
                  Obx(() {
                    if (cartController.productsList.isEmpty) {
                      return const Center(child: Text('Your cart is empty'));
                    }

                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        itemCount: cartController.productsList.length,
                        itemBuilder: (context, index) {
                          final item = cartController.productsList[index];
                          final productId = item.products.id;

                          return Padding(
                            padding: EdgeInsets.all(20.0.r),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 252, 242, 148),
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
                                      Text(cartController
                                          .selectedColors[productId]
                                          .toString()),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(cartController
                                          .seledtedSize[productId]
                                          .toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 80.w,
                                  ),
                                  Text(
                                    item.quantity.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  Obx(() => CustomText(
                        inputText: "Total: ${cartController.total.toString()}",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontsize: 20,
                      )),
                  SizedBox(
                    height: 25.h,
                  ),
                Obx(() => pay.isloading.value
    ? const Center(
        child: CircularProgressIndicator(),
      )
    : elements.customButton("Make payment", Colors.pink, () {
        final body = {
          "amount": cartController.total.toString(),
          "orderId": userUid,
          "customerData": {
            "name": "userName",
            "email": "userEmail",
            "phone": "userPhone",
            "add": "userAddress",
          },
          "items": cartController.productsList.map((cart) => {  
            "products": {
              "id": cart.products.id,
              "name": cart.products.name,
              "price": cart.products.price,
              "url": cart.products.url,
              "selectedColor": cartController.selectedColors[cart.products.id] ?? "Not Selected",
              "selectedSize": cartController.seledtedSize[cart.products.id] ?? "Not Selected",
            },
            "quantity": cart.quantity,
          }).toList(),
        };

       final rawItems = body['items'];
if (rawItems is List) {  
  pay.initiatePayment(
    body: body,
   
  );
} else {
  print('❌ body["items"] is not a valid List');
}

      }, Colors.white)),


                  SizedBox(
                    height: 30.h,
                  ),
                  elements.bottomNavbar()
                ]))));
  }
}
