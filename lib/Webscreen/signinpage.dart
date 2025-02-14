import 'package:fair_bangla/Webscreen/webshomepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Elemnts/helpingwidgets.dart';
import '../Elemnts/webElements.dart';
import '../firebase.auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailinfoecom = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final authcontler = AuthController();
  final elementsController = Elements();

  final String _emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              elementsController.navbar(),
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
                            inputText: "Log In",
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
                                      controller: passwordcontroller,
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
                        Obx(() => authcontler.isloading.value
                            ? const CircularProgressIndicator()
                            : elementsController
                                .customButton("Login", Colors.black, () {
                                if (_formKey.currentState!.validate()) {
                                  authcontler.signIn(
                                      emailinfoecom.text,
                                      passwordcontroller.text,
                                      const WebHomePage(),
                                      context);
                                }
                              }, Colors.yellow))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox( height: 40.h),
              elementsController.bottomNavbar()
            ],
          ),
        ),
      ),
    );
  }
}
