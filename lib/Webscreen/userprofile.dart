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

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final elementscontroller = Elements();
  final auth = AuthController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController address = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final elmentsControler = Elements();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          elementscontroller.navbar(),
          SizedBox(
            height: 18.h,
          ),
          CustomText(
              inputText: "Manage My Account",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontsize: 22),
          SizedBox(
            height: 35.h,
          ),
          FutureBuilder(
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

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 300.h,
                    width: 370.w,
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.r))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              inputText: userdata.username.toString(),
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
                        borderRadius: BorderRadius.all(Radius.circular(15.r))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          elementscontroller.customButton(
                              "Change Address", Colors.yellow, () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Change Address",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  content: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        CustomText(
                                            inputText: "Enter Your Address",
                                            fontsize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Container(
                                            color: Colors.black,
                                            width: 620.w,
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              },
                                              controller: address,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(20.0),
                                                  border: InputBorder.none),
                                            )),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await firestore
                                                .collection('fairbanglaUser')
                                                .doc(userdata.uid)
                                                .update({
                                              'address': '${address.text}',
                                            });
                                          }
                                        },
                                        child: CustomText(
                                            inputText: "Done",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontsize: 18)),
                                  ],
                                );
                              },
                            );
                          }, Colors.black)
                        ]),
                  ),
                  SizedBox(width: 80.w,),
                                    Container(
                    height: 300.h,
                    width: 370.w,
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.r))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              SizedBox(height: 20.h,),
                              elementscontroller.customButton("Add Method", Colors.yellow, () { }, Colors.black)
                         
                      
                        ]),
                  ),
                ],
              );
            },
          ) , 
          SizedBox(height: 40.h),
          elementscontroller.bottomNavbar()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.shop, color: Colors.black,),
        onPressed: ()async{
         if(elmentsControler.user.value == null){
          Get.to( SignUpPage(getpage: const FairBanlgCart(),));
         }
         if(elmentsControler.user.value != null){
           Get.to( const FairBanlgCart());
         }
       
      }),
    );
  }
}
