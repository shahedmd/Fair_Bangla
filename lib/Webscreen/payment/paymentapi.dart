

import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PayApi {
  RxBool isloading = false.obs;

  Future<void> initiatePayment({
    required String orderId,
    required double amount,
required List<Map<String, dynamic>> items,
    required Map<String, dynamic> customerData,
  }) async {
    if (amount <= 0) {
      print('❌ Invalid amount');
      return;
    }

    try {
      isloading.value = true;

      final response = await http.post(
        Uri.parse('http://localhost:8080/create-payment'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'orderId': orderId,
          'amount': amount,
          'items': items,
          'customerData': customerData,
        }),
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
