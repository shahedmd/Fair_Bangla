import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutusController extends GetxController {
  widget(String description, String imageurl, String heading) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  inputText: heading,
                  color: Colors.yellow.shade900,
                  fontWeight: FontWeight.bold,
                  fontsize: 35),
              SizedBox(
                height: 18.h,
              ),
              SizedBox(
                  width: 550.w,
                  child: CustomText(
                      inputText: description,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontsize: 18))
            ],
          ),
          SizedBox(
            width: 200.w,
          ),
          SizedBox(
            height: 400.h,
            width: 500.w,
            child: Image.asset(imageurl),
          )
        ],
      ),
    );
  }





    widget2(String description, String imageurl, String heading) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          SizedBox(
            height: 400.h,
            width: 500.w,
            child: Image.asset(imageurl),
          ),
          SizedBox(
            width: 200.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  inputText: heading,
                  color: Colors.yellow.shade900,
                  fontWeight: FontWeight.bold,
                  fontsize: 35),
              SizedBox(
                height: 18.h,
              ),
              SizedBox(
                  width: 550.w,
                  child: CustomText(
                      inputText: description,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontsize: 18))
            ],
          ),
          
        ],
      ),
    );
  }
}
