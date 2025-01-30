import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cartPage/getxCartControler.dart';

class ColorDropdown extends StatelessWidget {
  final colorController = Get.put(CartControler());

   ColorDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButton<String>(
        alignment: Alignment.center,
        
        value: colorController.selectedColor.value.isNotEmpty
            ? colorController.selectedColor.value
            : null, // Show the selected color
        hint: const Text("Select Color"),
        dropdownColor: Colors.white,
        items: colorController.colors.map((color) {
          return DropdownMenuItem<String>(
            alignment: Alignment.center,
            value: color,
            child: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                color: Color(int.parse(color.replaceFirst('#', '0xff'))),
                shape: BoxShape.circle,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            colorController.updateSelectedColor(value);
          }
        },
      );
    });
  }
}
