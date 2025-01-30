import 'package:fair_bangla/Elemnts/datamodel.dart';
import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:fair_bangla/cartPage/getxCartControler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Elemnts/webElements.dart';
import 'colorsSelection.dart';

// ignore: must_be_immutable
class ProductsDetails extends StatefulWidget {
  Products products;
  ProductsDetails({super.key, required this.products});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  final elmentsControler = Get.find<Elements>();
  final cartController = Get.put(CartControler());
  @override
  void initState() {
    cartController.setColors(widget.products.colors);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          elmentsControler.navbar(),
          SizedBox(
            height: 40.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        inputText: widget.products.name,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontsize: 35),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomText(
                        inputText: "Price: ${widget.products.price.toString()}",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontsize: 23),
                    SizedBox(
                      height: 25.h,
                    ),
                    SizedBox(
                        height: 450.h,
                        width: 450.h,
                        child: Image.network(
                          widget.products.url,
                          fit: BoxFit.contain,
                        )),
                    CustomText(
                        inputText: "Color Family",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontsize: 15),
                    ColorDropdown()
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
