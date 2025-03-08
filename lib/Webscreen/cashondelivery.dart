import 'package:fair_bangla/Elemnts/datamodel.dart';
import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:fair_bangla/Elemnts/webElements.dart';
import 'package:fair_bangla/firebase.auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../usermodel.dart';

// ignore: must_be_immutable
class CashOnDelivery extends StatefulWidget {
  Products products;

  CashOnDelivery({super.key, required this.products});

  @override
  State<CashOnDelivery> createState() => _CashOnDeliveryState();
}

class _CashOnDeliveryState extends State<CashOnDelivery> {
  final elementControler = Elements();

  final auth = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 900.h,
              width: 1300.w,
              child: Stack(children: [
                elementControler.navbar(),
                Positioned(
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
                                child: Text('Error: ${snapshot.error}'));
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                                child: Text('No products found.'));
                          }

                          UserDAta userdata = snapshot.data!;

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0.w),
                            child: Row(
                              children: [
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
                            ),
                          );
                        })),
                Positioned(
                    child: Column(
                  children: [
                    CustomText(
                        inputText: "Order Details",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontsize: 20),
                        SizedBox(height: 20.h,),

                  ],
                ))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
