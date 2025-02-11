// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'datamodel.dart';


class HomePageProductFetchControler extends GetxController{

   Future<List<Products>> fetchProducts() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('HomepageProductDataBase').get();
    return snapshot.docs.map((doc) => Products.fromFirestore(doc)).toList();
  }
}