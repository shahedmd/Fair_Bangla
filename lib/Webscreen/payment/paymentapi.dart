// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
// ignore: deprecated_member_use
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class PaymentController extends GetxController {
  var isloading = false.obs;

  Future<void> initiatePayment({
  
    required Map<String, Object> body, 
  }) async {
    try {
      isloading.value = true; 

      
      final response = await http.post(
        Uri.parse('http://localhost:8080/create-payment'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body), 
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final gatewayUrl = responseData['GatewayPageURL']; 
        if (gatewayUrl != null) {
          _redirectToWeb(gatewayUrl); 
        } else {
          print('❌ Missing GatewayPageURL in response');
        }
      } else {
        print('❌ Failed to initiate payment: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('❌ Exception: $e');
    } finally {
      isloading.value = false; 
    }
  }


  void _redirectToWeb(String url) {
    html.window.open(url, '_self'); 
  }
}
