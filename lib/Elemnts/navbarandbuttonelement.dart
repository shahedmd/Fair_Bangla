import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Elements extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList urlList = <String>[].obs;

  Future<void> fetchUrls() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('LandingPageSlideImage').get();

      List<String> urls =
          querySnapshot.docs.map((doc) => doc['url'] as String).toList();

      urlList.value = urls;
    } catch (e) {
      print('Error fetching URLs: $e');
    }
  }

  final FirebaseFirestore firestoreinstance = FirebaseFirestore.instance;
  RxList brandBannerList = <String>[].obs;

  Future<void> fetchdataBrandlogolist() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('BrandLIsting').get();

      List<String> urls =
          querySnapshot.docs.map((doc) => doc['url'] as String).toList();

      brandBannerList.value = urls;
    } catch (e) {
      print('Error fetching URLs: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchUrls();
    // Fetch data when the controller is initialized
    fetchdataBrandlogolist();
  }

  Widget customButton(String textinput) {
    return Container(
      height: 60.h,
      width: 140.w,
      decoration: BoxDecoration(
          color: Colors.yellow.shade800,
          borderRadius: BorderRadius.all(Radius.circular(12.r))),
      child: Center(
        child: CustomText(
            inputText: textinput,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontsize: 18),
      ),
    );
  }

  Widget navbar() {
    return SizedBox(
      height: 100.h,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
                inputText: "FAIR BANGLA",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontsize: 24),
            SizedBox(
              width: 200.w,
            ),
            CustomText(
                inputText: "CATALOGUE",
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              width: 70.w,
            ),
            CustomText(
                inputText: "FASHION",
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              width: 70.w,
            ),
            CustomText(
                inputText: "FOOD",
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              width: 70.w,
            ),
            CustomText(
                inputText: "ELECTRONICS",
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              width: 70.w,
            ),
            customButton("Log In")
          ]),
    );
  }

  Widget landingBody() {
    return Padding(
      padding: EdgeInsets.all(40.r),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                inputText: "LET'S",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontsize: 50),
            SizedBox(
              height: 15.h,
            ),
            CustomText(
                inputText: "EXPLORE",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontsize: 50),
            SizedBox(
              height: 15.h,
            ),
            Container(
              padding: EdgeInsets.all(20.r),
              color: Colors.yellow,
              child: CustomText(
                  inputText: "UNIQUE",
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontsize: 50),
            ),
            SizedBox(height: 35.h),
            CustomText(
                inputText: "Live for influential & innovative accessories",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontsize: 17),
            SizedBox(
              height: 25.h,
            ),
            customButton("Shop Now")
          ],
        ),
      ),
    );
  }

  Widget brandBanner() {
    return Container(
      width: double.infinity,
      height: 220.h,
      color: Colors.yellow,
      child: Obx(() {
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 900.w,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brandBannerList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(35.r),
                  child: SizedBox(
                    height: 170.h,
                    width: 170.w,
                    child: Image.network(brandBannerList[index]),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget bottomNavbar() {
    return Container(
      width: double.infinity,
      height: 450.h,
      color: Colors.black,
      child: Row(
       
        children: [
          customeSizedBox(250, [
            CustomText(
                inputText: "FAIR BANGLA",
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontsize: 25),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              width: 280.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.facebook,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.instagram,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.whatsapp,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.twitter,
                      )),
                ],
              ),
            )
          ]),

          SizedBox(width: 450.w,),
          customeSizedBox(300, [
            CustomText(
                inputText: "COMPANY",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontsize: 18),
            SizedBox(
              height: 35.h,
            ),
            CustomText(
                inputText: "About Us",
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
                inputText: "Products",
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
                inputText: "Supports",
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
                inputText: "Careers",
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontsize: 18),
          ]),

          SizedBox(width: 130.w,),
          customeSizedBox(300, [
            CustomText(
                inputText: "LINKS",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontsize: 18),
            SizedBox(
              height: 35.h,
            ),
            CustomText(
                inputText: "Share Location",
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
                inputText: "Order Tracking",
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
                inputText: "Size Guide",
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
                inputText: "FAQs",
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontsize: 18),
          ]),
                    SizedBox(width: 130.w,),

          customeSizedBox(300, [
            CustomText(
                inputText: "LEGAL",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontsize: 18),
            SizedBox(
              height: 35.h,
            ),
            CustomText(
                inputText: "Privacy & Policy",
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
                inputText: "Terms & Condition",
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
                inputText: "Supports",
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontsize: 18),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
                inputText: "Careers",
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontsize: 18),
          ]),
        ],
      ),
    );
  }

  Widget customeSizedBox(double height, List<Widget> Widget) {
    return SizedBox(
      height: height.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: Widget,
      ),
    );
  }
}
