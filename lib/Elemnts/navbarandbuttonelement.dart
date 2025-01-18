import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return Align(  // Align the ListView.builder horizontally
      alignment: Alignment.center,  // Center it horizontally
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
}
