import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Elemnts/webElements.dart';
import 'getxCartControler.dart';

class FairBanlgCart extends StatefulWidget {
  const FairBanlgCart({super.key});

  @override
  State<FairBanlgCart> createState() => _FairBanlgCartState();
}

class _FairBanlgCartState extends State<FairBanlgCart> {
  final cartControler = Get.find<CartControler>();
  final elementControler = Get.find<Elements>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            elementControler.navbar(),
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  if (cartControler.productsList.isEmpty) {
                    return const Center(child: Text('Your cart is empty'));
                  }

                  return SizedBox(
                    height: 750.h,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ListView.builder(
                      itemCount: cartControler.productsList.length,
                      itemBuilder: (context, index) {
                        final item = cartControler.productsList[index];
                        return ListTile(
                          leading: Image.network(item.products.url),
                          title: Text(item.products.name),
                          subtitle: Column(
                            children: [Text(
                                '\$${item.products.price.toStringAsFixed(2)}'),
                                Text(
                                'Color Family: ${cartControler.selectedColor.toString()}')],
                         
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  cartControler.updateQuantity(
                                      item.products.id, item.quantity - 1);
                                },
                              ),
                              Text(
                                item.quantity.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  cartControler.updateQuantity(
                                      item.products.id, item.quantity + 1);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  cartControler.removeProduct(item.products.id);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),

                SizedBox(
                  height: 100.w,
                ),
                Container(
                  height: 400.h,
                  width: 280.w,
                  decoration: const BoxDecoration(color: Colors.yellow),
                  child: Column(
                    children: [
                      Obx(() {
                        return CustomText(
                            inputText:
                                'Total: \$${cartControler.total.toStringAsFixed(2)}',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontsize: 25);
                      }),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomText(
                          inputText:
                              "Total Item ${cartControler.productsList.length.toString()}",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontsize: 20)
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
