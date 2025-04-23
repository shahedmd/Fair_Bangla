// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:fair_bangla/Elemnts/webElements.dart';
import 'package:fair_bangla/firebase.auth.dart';
import 'package:fair_bangla/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fair_bangla/cartPage/cartPage.dart';

import 'login.dart';
import 'myOrders.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final elementsController = Get.find<Elements>();

  final auth = AuthController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController address = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final isloading = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 900.h,
              width: 1300.w,
              child: Stack(children: [
                elementsController.navbar(),
                Positioned(
                  top: 120.h,
                  left: 600.w,
                  child: CustomText(
                      inputText: "Manage My Account",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 22),
                ),
                Positioned(
                  top: 220.h,
                  child: FutureBuilder(
                    future: auth.getuser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: Text('No products found.'));
                      }

                      UserDAta userdata = snapshot.data!;

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 300.h,
                                width: 370.w,
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                decoration: BoxDecoration(
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
                                        height: 25.h,
                                      ),
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
                                          inputText: "User ID: ${userdata.uid}",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontsize: 15)
                                    ]),
                              ),
                              SizedBox(width: 80.w),
                              Container(
                                height: 300.h,
                                width: 370.w,
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                decoration: BoxDecoration(
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
                                          Icons.location_off,
                                          size: 80.r,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      CustomText(
                                          inputText: userdata.address,
                                          fontsize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      elementsController.customButton(
                                          "Change Address", Colors.yellow, () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "Change Address",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              content: Form(
                                                key: _formKey,
                                                child: SizedBox(
                                                  height: 300.h,
                                                  child: Column(
                                                    children: [
                                                      CustomText(
                                                          inputText:
                                                              "Enter Your Address",
                                                          fontsize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Container(
                                                          color: Colors.black,
                                                          width: 620.w,
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Please enter some text';
                                                              }
                                                              return null;
                                                            },
                                                            controller: address,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                            decoration: const InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20.0),
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      isloading.value = true;
                                                      await firestore
                                                          .collection(
                                                              'fairbanglaUser')
                                                          .doc(userdata.uid)
                                                          .update({
                                                        'address': address.text,
                                                      });
                                                      isloading.value = false;
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                  child: Obx(() => isloading
                                                          .value
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : CustomText(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontsize: 13,
                                                          color: Colors.black,
                                                          inputText: "Done")),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      }, Colors.black)
                                    ]),
                              ),
                              SizedBox(
                                width: 80.w,
                              ),
                              Container(
                                height: 300.h,
                                width: 370.w,
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                decoration: BoxDecoration(
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
                                          Icons.money,
                                          size: 80.r,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      CustomText(
                                          inputText: "No payment method added",
                                          fontsize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      elementsController.customButton(
                                          "Add Method",
                                          Colors.yellow,
                                          () {},
                                          Colors.black)
                                    ]),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 300.h,
                                width: 370.w,
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                decoration: BoxDecoration(
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
                                          Icons.shopping_bag,
                                          size: 80.r,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      CustomText(
                                          inputText: "My Orders",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontsize: 15),
                                      SizedBox(height: 15.h),
                                      elementsController.customButton(
                                          "View", Colors.yellow, () {
                                        Get.to(() => const MyOrders());
                                      }, Colors.black)
                                    ]),
                              ),
                              SizedBox(
                                width: 150.w,
                              ),
                              Container(
                                height: 300.h,
                                width: 370.w,
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                decoration: BoxDecoration(
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
                                          Icons.logout,
                                          size: 80.r,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      CustomText(
                                          inputText: "Logout your account",
                                          fontsize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      elementsController.customButton(
                                          "Logout", Colors.yellow, () {
                                        auth.signOut();
                                      }, Colors.black)
                                    ]),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 80.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: 475.w),
                    child: elementsController.customDropdown(),
                  ),
                )
              ]),
            ),
            SizedBox(height: 40.h),
            elementsController.bottomNavbar()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow,
          child: const Icon(
            Icons.shop,
            color: Colors.black,
          ),
          onPressed: () async {
            if (elementsController.user.value == null) {
              Get.to(SignUpPage(
                getpage: const FairBanlgCart(),
              ));
            }
            if (elementsController.user.value != null) {
              Get.to(const FairBanlgCart());
            }
          }),
    );
  }
}
