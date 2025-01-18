// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  String inputText = "";
  double fontsize;
  FontWeight fontWeight;
  Color color;

  CustomText(
      {super.key,
      required this.inputText,
      required this.color,
      required this.fontWeight,
      required this.fontsize});

  @override
  Widget build(BuildContext context) {
    return Text(
      inputText,
      style: TextStyle(
          fontFamily: "Inter",
          fontWeight: fontWeight,
          fontSize: fontsize.sp,
          color: color),
    );
  }
}
