import 'package:fair_bangla/Webscreen/login.dart';
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

  var obsText = true.obs;

  void togglePasswordVisibility() {
    obsText.value = !obsText.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              elementsController.navbar(),
              SizedBox(
                height: 120.h,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(30.r))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.h),
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
                          height: 40.h,
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
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
                                        labelText: 'Enter your e-mail',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  height: 40.h,
                                ),
                                SizedBox(
                                    width: 400.w,
                                    child: Obx(
                                      () => TextFormField(
                                        obscureText: obsText.value,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        controller: passwordcontroller,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: togglePasswordVisibility,
                                            icon: Icon(
                                              obsText.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                          ),
                                          labelText: 'Enter your password',
                                          labelStyle: const TextStyle(
                                              color: Colors.black),
                                          border: const OutlineInputBorder(),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            )),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          width: 600.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  inputText: "Doesn't have an account ",
                                  fontsize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                width: 20.w,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => SignUpPage(
                                        getpage: const WebHomePage(),
                                      ));
                                },
                                child: CustomText(
                                    inputText: "Create Now",
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
              SizedBox(height: 150.h),
              elementsController.bottomNavbar()
            ],
          ),
        ),
      ),
    );
  }
}
