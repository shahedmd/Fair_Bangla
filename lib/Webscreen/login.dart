import 'package:fair_bangla/Webscreen/signinpage.dart';
import 'package:fair_bangla/firebase.auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Elemnts/helpingwidgets.dart';
import '../Elemnts/webElements.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  Widget getpage;
  SignUpPage({super.key, required this.getpage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailinfoecom = TextEditingController();
  TextEditingController nameinfoecom = TextEditingController();
  TextEditingController addressinfoecom = TextEditingController();
  TextEditingController phoneinfoecom = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();

  final authcontler = AuthController();
  final elementscontroller = Elements();

  final String _emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              elementscontroller.navbar(),
              Container(
                                padding:  EdgeInsets.symmetric(vertical: 30.h),

                decoration: BoxDecoration(
                    color: Colors.yellow.shade300,
                    borderRadius: BorderRadius.all(Radius.circular(30.r))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                        inputText: "Sign Up",
                        fontsize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 20.h,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            
                            SizedBox(
                                width: 400.w,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: nameinfoecom,
                                  style:
                                      const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    labelText: 'Enter your name',
                                                                            labelStyle: TextStyle(color: Colors.black),

                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black), 
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                                width: 400.w,
                                child: TextFormField(
                                  validator: (value) {
                                    RegExp regex = RegExp(_emailPattern);

                                    if (value == null ||
                                        !regex.hasMatch(value)) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: emailinfoecom,
                                  style:
                                      const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    labelText: 'Enter your email',
                                                                            labelStyle: TextStyle(color: Colors.black),

                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black), 
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                                width: 400.w,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: passwordcontroler,
                                  style:
                                      const TextStyle(color: Colors.black),
                                   decoration: const InputDecoration(
                                    labelText: 'Enter your password',
                                                                            labelStyle: TextStyle(color: Colors.black),

                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black), 
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                                width:400.w,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: addressinfoecom,
                                  style:
                                      const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    labelText: 'Enter your address',
                                                                            labelStyle: TextStyle(color: Colors.black),

                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black), 
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                                width: 400.w,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter correct number';
                                    }
                                    return null;
                                  },
                                  controller: phoneinfoecom,
                                  style:
                                      const TextStyle(color: Colors.black),
                                 decoration: const InputDecoration(
                                    labelText: 'Enter your phone',
                                                                            labelStyle: TextStyle(color: Colors.black),

                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black), 
                                    ),
                                  ),
                                )),
                          ],
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                      width: 600.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                              inputText: "Already have an account",
                              fontsize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 20.w,
                          ),
                          InkWell(
                            onTap: ()=> Get.to(()=>  const Login()),
                            child: CustomText(
                                inputText: "Login Now",
                                fontsize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Obx(() => authcontler.isloading.value
                        ? const CircularProgressIndicator()
                        : elementscontroller
                            .customButton("Signup", Colors.black, () async {
                            if (_formKey.currentState!.validate()) {
                              await authcontler.signUp(
                                  emailinfoecom.text,
                                  passwordcontroler.text,
                                  nameinfoecom.text,
                                  phoneinfoecom.text,
                                  addressinfoecom.text,
                                  context,
                                  widget.getpage);
                            }
                          }, Colors.yellow))
                  ],
                ),
              ),
              SizedBox(height: 70.h),
              elementscontroller.bottomNavbar()
            ],
          ),
        ),
      ),
    );
  }
}
