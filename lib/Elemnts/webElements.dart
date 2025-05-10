 
import 'package:fair_bangla/Elemnts/datamodel.dart';
import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:fair_bangla/Elemnts/homePageProductsFetchControler.dart';
import 'package:fair_bangla/Webscreen/login.dart';
import 'package:fair_bangla/Webscreen/producsDetails.dart';
import 'package:fair_bangla/Webscreen/signinpage.dart';
import 'package:fair_bangla/Webscreen/webshomepage.dart';
import 'package:fair_bangla/cartPage/getxCartControler.dart';
import 'package:fair_bangla/firebase.auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Webscreen/aboutuspage.dart';
import '../Webscreen/fashion pages/babyproducts.dart';
import '../Webscreen/fashion pages/beautyproducts.dart';
import '../Webscreen/fashion pages/femalecollection.dart';
import '../Webscreen/fashion pages/gentscollection.dart';
import '../Webscreen/userprofile.dart';
import 'package:flutter/material.dart';

class Elements extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList urlList = <String>[].obs;

final homePageProductController = Get.put(HomePageProductFetchControler());

  final cartControler = Get.find<CartControler>();
  final authController = Get.find<AuthController>();
  Rx<User?> user = Rx<User?>(FirebaseAuth.instance.currentUser);

  RxBool bool1 = false.obs;
  RxBool bool2 = false.obs;
  RxBool bool3 = false.obs;
  RxBool bool4 = false.obs;

  RxBool isHover1 = false.obs;
  RxBool isHover2 = false.obs;
  RxBool isHover3 = false.obs;
  RxBool isHover4 = false.obs;

  void onHoverd(RxBool boolValue) {
    boolValue.value = true;
  }

  Future<void> fetchUrls() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('LandingPageSlideImage').get();

      List<String> urls =
          querySnapshot.docs.map((doc) => doc['url'] as String).toList();

      urlList.value = urls;
    } catch (e) {}
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
    } catch (e) {}
  }

  @override
  void onInit() {
    super.onInit();
    fetchUrls();
    fetchdataBrandlogolist();

    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      user.value = newUser;
    });
  }

  Widget customButton(String textinput, Color colors, VoidCallback voidCallback,
      Color textColor) {
    return InkWell(
      onTap: voidCallback,
      child: Container(
        height: 60.h,
        width: 140.w,
        decoration: BoxDecoration(
            color: colors,
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        child: Center(
          child: CustomText(
              inputText: textinput,
              color: textColor,
              fontWeight: FontWeight.bold,
              fontsize: 15),
        ),
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
            InkWell(
              onTap: () => Get.to(const WebHomePage()),
              child: CustomText(
                  inputText: "FAIR BANGLA",
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontsize: 24),
            ),
            SizedBox(
              width: 200.w,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => onHoverd(bool1),
              onExit: (_) {
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (!isHover1.value) {
                    bool1.value = false;
                  }
                });
              },
              child: CustomText(
                  inputText: "FASHION",
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontsize: 18),
            ),
            SizedBox(
              width: 70.w,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => onHoverd(bool2),
              onExit: (_) {
                Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    if (!isHover2.value) {
                      bool2.value = false;
                    }
                  },
                );
              },
              child: CustomText(
                  inputText: "FOOD",
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontsize: 18),
            ),
            SizedBox(
              width: 70.w,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => onHoverd(bool3),
              onExit: (_) {
                Future.delayed(const Duration(milliseconds: 200), () {
                  if (!isHover3.value) {
                    bool3.value = false;
                  }
                });
              },
              child: CustomText(
                  inputText: "ELECTRONICS",
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontsize: 18),
            ),
            SizedBox(
              width: 70.w,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => bool4.value = true,
              onExit: (_) {
                Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    if (!isHover4.value) {
                      bool4.value = false;
                    }
                  },
                );
              },
              child: CustomText(
                  inputText: "About Us",
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontsize: 18),
            ),
            SizedBox(
              width: 70.w,
            ),
            user.value == null
                ? customButton("Log In", Colors.yellow, () {
                    Get.to(const Login());
                  }, Colors.black)
                : InkWell(
                    onTap: () {
                      Get.to(() => const UserProfile());
                    },
                    child: CustomText(
                        inputText: "User Profile",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontsize: 18))
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
            SizedBox(
              height: 80.h,
            ),
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
            customButton("Shop Now", Colors.yellow, () {}, Colors.black)
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
          SizedBox(
            width: 450.w,
          ),
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
          SizedBox(
            width: 130.w,
          ),
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
          SizedBox(
            width: 130.w,
          ),
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

Widget homePageProductList() {
  final orientation = MediaQuery.of(Get.context!).orientation;

  return Column(
    children: [
      Padding(
          padding: EdgeInsets.all(30.0.r),
          child: TextField(
            onChanged: (value) =>
                homePageProductController.filterSearchResults(value),
            decoration: InputDecoration(
              hintText: "Search products...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      Obx(() {
        if (homePageProductController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (homePageProductController.filteredProducts.isEmpty) {
          return const Center(child: Text('No products found.'));
        }

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (180.w / 280.h),
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 4,
            crossAxisSpacing: 30.w,
            mainAxisSpacing: 30.h,
          ),
          itemCount: homePageProductController.filteredProducts.length,
          itemBuilder: (context, index) {
            Products product =
                homePageProductController.filteredProducts[index];
            return Padding(
              padding: EdgeInsets.all(20.r),
              child: InkWell(
                onTap: () {
                  if (user.value == null) {
                    Get.to(SignUpPage(
                        getpage: ProductsDetails(products: product)));
                  } else {
                    Get.to(ProductsDetails(products: product));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 220.h,
                        width: 160.w,
                        child: Image.network(
                          product.url,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/placeholder.png',
                              height: 220.h,
                              width: 160.w,
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                          inputText: product.name,
                          fontsize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      CustomText(
                          inputText: product.price.toString(),
                          fontsize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      SizedBox(height: 10.h),
                      customButton(
                          "Shop Now", Colors.black, () {}, Colors.yellow),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    ],
  );
}


  Widget customContainer(
      Color color, double height, List<Map<String, dynamic>> items) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 4,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      curve: Curves.bounceIn,
      height: height.h * items.length.h,
      width: 200.w,
      duration: const Duration(seconds: 2),
      child: Padding(
        padding: EdgeInsets.all(30.r),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.map((item) {
              return Column(
                children: [
                  InkWell(
                    onTap: () => Get.to(() => item['route'] as Widget),
                    child: CustomText(
                      inputText: item['text'],
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 15,
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              );
            }).toList()),
      ),
    );
  }

  Widget customDropdown() {
  return SizedBox(
    height: 900.h,
    width: 700.w,
    child: Stack(
      children: [
        // Dropdown 1
        MouseRegion(
          onEnter: (_) => isHover1.value = true,
          onExit: (_) {
            Future.delayed(const Duration(milliseconds: 300), () {
              isHover1.value = false;
              bool1.value = false;
            });
          },
          child: Obx(() => AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                offset: bool1.value ? const Offset(0, 0) : const Offset(0, -0.05),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: bool1.value ? 1.0 : 0.0,
                  child: Visibility(
                    visible: bool1.value,
                    child: customContainer(
                      Colors.yellow,
                      120,
                      [
                        {'text': 'Gents Collection', 'route': const GentsCollection()},
                        {'text': 'Fe-male Collection', 'route': const FemaleCollection()},
                        {'text': 'Beauty Products', 'route': const BeautyProducts()},
                        {'text': 'Baby Products', 'route': const BabyProducts()},
                      ],
                    ),
                  ),
                ),
              )),
        ),

        // Dropdown 2
        Positioned(
          left: 146.w,
          child: MouseRegion(
            onEnter: (_) => isHover2.value = true,
            onExit: (_) {
              Future.delayed(const Duration(milliseconds: 300), () {
                isHover2.value = false;
                bool2.value = false;
              });
            },
            child: Obx(() => AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  offset: bool2.value ? const Offset(0, 0) : const Offset(0, -0.05),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: bool2.value ? 1.0 : 0.0,
                    child: Visibility(
                      visible: bool2.value,
                      child: customContainer(
                        Colors.yellow,
                        120,
                        [
                          {'text': 'Organic Oils', 'route': const GentsCollection()},
                          {'text': 'Honey', 'route': const FemaleCollection()},
                          {'text': 'Seeds & Dry Powders', 'route': const BeautyProducts()},
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),

        // Dropdown 3
        Positioned(
          left: 270.w,
          child: MouseRegion(
            onEnter: (_) => isHover3.value = true,
            onExit: (_) {
              Future.delayed(const Duration(milliseconds: 300), () {
                isHover3.value = false;
                bool3.value = false;
              });
            },
            child: Obx(() => AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  offset: bool3.value ? const Offset(0, 0) : const Offset(0, -0.05),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: bool3.value ? 1.0 : 0.0,
                    child: Visibility(
                      visible: bool3.value,
                      child: customContainer(
                        Colors.yellow,
                        120,
                        [
                          {'text': 'Laptops', 'route': const GentsCollection()},
                          {'text': 'Computer Items', 'route': const FemaleCollection()},
                          {'text': 'Mobile Phone', 'route': const BeautyProducts()},
                          {'text': 'Gadget', 'route': const BeautyProducts()},
                          {'text': 'Home Accessories', 'route': const BeautyProducts()},
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),

        // Dropdown 4
        Positioned(
          left: 470.w,
          child: MouseRegion(
            onEnter: (_) => isHover4.value = true,
            onExit: (_) {
              Future.delayed(const Duration(milliseconds: 300), () {
                isHover4.value = false;
                bool4.value = false;
              });
            },
            child: Obx(() => AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  offset: bool4.value ? const Offset(0, 0) : const Offset(0, -0.05),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: bool4.value ? 1.0 : 0.0,
                    child: Visibility(
                      visible: bool4.value,
                      child: customContainer(
                        Colors.yellow,
                        120,
                        [
                          {'text': 'Contact Us', 'route': const AboutUsPage()},
                          {'text': 'Privacy and Policy', 'route': const FemaleCollection()},
                          {'text': 'Return Policy', 'route': const BeautyProducts()},
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ],
    ),
  );
}




  
}
