import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cartPage/getxCartControler.dart';

class SizeDropdown extends StatelessWidget {
  final sizeController = Get.put(CartControler());

   SizeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButton<String>(
        alignment: Alignment.center,
        
        
        value: sizeController.productSize.value.isNotEmpty
            ? sizeController.productSize.value
            : null, // Show the selected color
        hint: const Text("Select Color"),
        dropdownColor: Colors.white,
        items: sizeController.sizeList.map((size) {
          return DropdownMenuItem<String>(
            alignment: Alignment.center,
            value: size,
            child: SizedBox(
              width: 20,
              height: 20,
              child: CustomText(inputText: size, color: Colors.black, fontWeight: FontWeight.bold, fontsize: 16),
             
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            sizeController.changeProductSize(value);
          }
        },
      );
    });
  }
}
