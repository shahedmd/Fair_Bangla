import 'package:fair_bangla/Elemnts/datamodel.dart';
import 'package:get/get.dart';

class CartProduct {
  Products products;
  int quantity;

  CartProduct({
    required this.products,
    this.quantity = 1,
  });
}

class CartControler extends GetxController {
  var productsList = <CartProduct>[].obs;

  double get total => productsList.fold(
      0, (sum, item) => sum + item.products.price * item.quantity);

  void addProduct(Products product) {
    final index =
        productsList.indexWhere((item) => item.products.id == product.id);
    if (index != -1) {
      productsList[index].quantity++;
    } else {
      productsList.add(CartProduct(products: product, quantity: 1));
    }
  }

  void updateQuantity(String productId, int quantity) {
    final index = productsList.indexWhere((item) => item.products.id == productId);
    if (index != -1) {
      if (quantity == 0) {
        productsList.removeAt(index);
      } else {
        productsList[index].quantity = quantity;
        productsList.refresh(); 
      }
    }
  }



  void removeProduct(String productId) {
    productsList.removeWhere((item) => item.products.id == productId);
  }
}
