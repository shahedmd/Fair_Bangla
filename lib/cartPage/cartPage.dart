import 'package:fair_bangla/Elemnts/helpingwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'getxCartControler.dart';



class FairBanlgCart extends StatefulWidget {
  const FairBanlgCart({super.key});

  @override
  State<FairBanlgCart> createState() => _FairBanlgCartState();
}

class _FairBanlgCartState extends State<FairBanlgCart> {

      final cartControler = Get.find<CartControler>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx((){
                 if (cartControler.productsList.isEmpty) {
              return const Center(child: Text('Your cart is empty'));
            }

             return Expanded(
               child: ListView.builder(
                itemCount: cartControler.productsList.length,
                itemBuilder: (context, index) {
                  final item = cartControler.productsList[index];
                  return ListTile(
                    leading: Image.network(item.products.url),
                    title: Text(item.products.name),
                    subtitle: Text('\$${item.products.price.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            cartControler.updateQuantity(item.products.id, item.quantity - 1);
                          },
                        ),
                        Text(
                          item.quantity.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            cartControler.updateQuantity(item.products.id, item.quantity + 1);
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


            SizedBox(height: 20.h,),

            Obx(() {
              return  CustomText(inputText:  'Total: \$${cartControler.total.toStringAsFixed(2)}',
               color: Colors.black, fontWeight: FontWeight.bold, fontsize: 25);
            })
          ],
        ),
    );
  }
}


