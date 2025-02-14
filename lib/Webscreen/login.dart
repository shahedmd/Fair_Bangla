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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.all(Radius.circular(30.r))),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
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
                                CustomText(
                                    inputText: "Enter Your Name",
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
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      controller: nameinfoecom,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(20.0),
                                          border: InputBorder.none),
                                    )),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomText(
                                    inputText: "Enter Your Email",
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
                                        RegExp regex = RegExp(_emailPattern);

                                        if (value == null ||
                                            !regex.hasMatch(value)) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      controller: emailinfoecom,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(20.0),
                                          border: InputBorder.none),
                                    )),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomText(
                                    inputText: "Enter Your Password",
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
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      controller: passwordcontroler,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(20.0),
                                          border: InputBorder.none),
                                    )),
                                SizedBox(
                                  height: 20.h,
                                ),
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
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      controller: addressinfoecom,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(20.0),
                                          border: InputBorder.none),
                                    )),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomText(
                                    inputText: "Enter Your Number",
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
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter correct number';
                                        }
                                        return null;
                                      },
                                      controller: phoneinfoecom,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(20.0),
                                          border: InputBorder.none),
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
                              CustomText(
                                  inputText: "Login Now",
                                  fontsize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Obx(() => authcontler.isloading.value
                            ? const CircularProgressIndicator()
                            : elementscontroller.customButton("Signup", Colors.black, () async { 
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
                ),
              ),
         SizedBox( height: 40.h),
             elementscontroller.bottomNavbar()
            ],
          ),
        ),
      ),
    );
  }
}
