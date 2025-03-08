// ignore_for_file: unused_import

import 'dart:async';
import 'package:fair_bangla/Elemnts/datamodel.dart';
import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:fair_bangla/Webscreen/login.dart';
import 'package:fair_bangla/cartPage/cartPage.dart';
import 'package:fair_bangla/cartPage/getxCartControler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Elemnts/homePageProductsFetchControler.dart';
import '../Elemnts/webElements.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WebHomePage extends StatefulWidget {
  const WebHomePage({super.key});

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  final elmentsControler = Get.find<Elements>();

  late PageController pageController;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);

    // Timer to auto-scroll pages smoothly
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (pageController.hasClients) {
        int nextPage = ((pageController.page ?? 0).toInt() + 1) %
            elmentsControler.urlList.length;
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 900.h,
              width: 1300.w,
              child: Stack(
                children: [
                  elmentsControler.navbar(),
                  Positioned(
                    top: 120.h,
                    left: 0.w,
                    right: 0.w,
                    bottom: 0.h,
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          elmentsControler.landingBody(),
                          SizedBox(
                            width: 300.w,
                          ),
                          SizedBox(
                            width: 500.w,
                            height: 600.h,
                            child: Obx(() {
                              if (elmentsControler.urlList.isEmpty) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              return  PageView.builder(
                                controller: pageController,
                                itemCount: elmentsControler.urlList.length,
                                itemBuilder: (context, index) {
                                  // Loop the index smoothly
                                  int loopIndex = index % elmentsControler.urlList.length;
                                  return Image.network(
                                    elmentsControler.urlList[loopIndex],
                                    fit: BoxFit.scaleDown,
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 455.w),
                      child: elmentsControler.customDropdown(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100.h),
            elmentsControler.brandBanner(),
            SizedBox(
              height: 50.h,
            ),
            CustomText(
                inputText: "YOUNG'S FAV!",
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontsize: 26),
            SizedBox(
              height: 30.h,
            ),
            elmentsControler.homePageProductList(),
            SizedBox(
              height: 50.h,
            ),
            elmentsControler.bottomNavbar(),
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
            if (elmentsControler.user.value == null) {
              Get.to(SignUpPage(
                getpage: const FairBanlgCart(),
              ));
            }
            if (elmentsControler.user.value != null) {
              Get.to(const FairBanlgCart());
            }
          }),
    );
  }
}
