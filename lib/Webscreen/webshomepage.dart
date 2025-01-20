import 'dart:async';
import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Elemnts/navbarandbuttonelement.dart';

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

    // Set up the timer to change the page every 4 seconds
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (pageController.hasClients) {
        int nextPage = ((pageController.page ?? 0).toInt() + 1) % elmentsControler.urlList.length;
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
            elmentsControler.navbar(),
            Row(
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
                      return const Center(child: CircularProgressIndicator());
                    }

                    return PageView.builder(
                      controller: pageController,
                      itemCount: elmentsControler.urlList.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          elmentsControler.urlList[index], // Correct image URL
                          fit: BoxFit.contain,
                        );
                      },
                    );
                  }),
                ),
               
              ],
            ),
             SizedBox(height: 100.h),
            elmentsControler.brandBanner(),
            SizedBox(height: 50.h,),

            CustomText(inputText: "YOUNG'S FAV!", color: Colors.yellow, fontWeight: FontWeight.bold, fontsize: 26),

            

           elmentsControler.bottomNavbar()
          ],
        ),
      ),
    );
  }
}
