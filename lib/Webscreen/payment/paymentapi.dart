

// ignore_for_file: avoid_web_libraries_in_flutter, avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';






class PayApi{
 
 RxBool isloading = false.obs;
 Future<void> initiatePayment(double amount) async {
    
    
    if (amount <= 0) {
      return;
    }

    try {
      isloading.value =  true;
      final response = await http.post(
        Uri.parse('http://localhost:8080/create-payment'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': amount.toString()}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final gatewayUrl = responseData['GatewayPageURL'];
        if (gatewayUrl != null) {
          _redirectToWeb(gatewayUrl);
        }

        // Handle response data here, like opening the payment page.
        print(responseData);
        isloading.value = false;
      } else {  
        print('Failed to initiate payment');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  void _redirectToWeb(String url) {
  html.window.open(url, '_self');
}

}