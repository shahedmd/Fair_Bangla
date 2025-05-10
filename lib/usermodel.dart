
import 'package:flutter/material.dart';
class UserDAta {
  String username;
  String email;
  String address;
  String phone;
  String uid;

  UserDAta({required this. username, required this.address, required this.email, required this.phone, required this.uid});


  factory UserDAta.fromFirestore(Map<String, dynamic> doc) {

    return UserDAta(
      username: doc['name'] ?? '',
      email: doc['email'] ?? '',
      address: doc['address'] ?? '',
      phone: doc['phone'] ?? '' ,
      uid: doc['uid']
    );
  }

}