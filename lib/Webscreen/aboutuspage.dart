import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:fair_bangla/Elemnts/webElements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Elemnts/aboutuselements.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final elementsController = Elements();
  final aboutuscontroller = AboutusController();

  final emailinfo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
           SizedBox(height: 600.w, width: 1300.w,
            child: Stack(
              children: [
                 elementsController.navbar(),
           
          Positioned(top: 150.h,
            child: aboutuscontroller.widget(
                "Welcome to Fair Bangla, the ultimate online shopping destination where fashion meets technology. We bring you a premium collection of footwear and electronic gadgets, carefully selected to meet your style and tech needs. Whether you're looking for trendy sneakers, formal shoes, or sports footwear, or need the latest smartphones, laptops, headphones, and accessories, we have it all under one roof. \n  Wide Range of Footwear – From stylish sneakers to durable sports shoes and elegant formal footwear, we provide options for every occasion. \n🔌 Latest Electronic Devices  Discover top-brand smartphones, high-performance laptops, high-quality audio devices, and smart gadgets designed to enhance your lifestyle. \n 🎁 Exclusive Deals & Discounts – Enjoy unbeatable prices, special offers, and seasonal discounts to make your shopping experience even better.",
                "images/aboutus1.jpg",
                "About Us"),)  ,

                  Positioned(
                    top: 80.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 455.w),
                      child: elementsController.customDropdown(),
                    ),
                  )
              ],
            ),
           ),
          
            aboutuscontroller.widget2(
                "✔ Authentic & High-Quality Products – We ensure that every product meets high standards of quality and durability.\n ✔ Fast & Secure Delivery – Get your orders delivered quickly and safely to your doorstep.\n ✔ Multiple Payment Options – Choose from various secure payment methods, including online banking, mobile payments, and cash on delivery.\n ✔ Easy Returns & Customer Support – Hassle-free return policies and 24/7 customer support to assist you whenever needed.\n At Fair Bangla, we believe in providing a seamless shopping experience where style and innovation come together. Shop with confidence and upgrade your wardrobe and tech collection today!\n 🚀 Fair Bangla – Smart Shopping, Trusted Service! 🛒👟🔌",
                "images/image2.png",
                "Why Choose Us?"),
            SizedBox(
              height: 80.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: CustomText(
                  inputText: "Contact Us",
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontsize: 25),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: CustomText(
                  inputText: "Enter Your message",
                  fontsize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Container(
                  color: Colors.black,
                  width: 620.w,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                    controller: emailinfo,
                    maxLines: 10,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        border: InputBorder.none),
                  )),
            ),
            SizedBox(
              height: 20.h,
            ),
            elementsController.customButton(
                "Send", Colors.black, () {}, Colors.yellow),
            SizedBox(
              height: 80.h,
            ),
            elementsController.bottomNavbar(),
          ],
        ),
      ),
    );
  }
}
