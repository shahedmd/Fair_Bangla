import 'package:flutter/material.dart ';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Elemnts/helpingwidgets.dart';
import 'usermodel.dart';
class AuthController extends GetxController{
   final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


    RxBool isloading = false.obs;

  // Sign up with email and password
  Future<User?> signUp(String email, String password, String name, String phone,
      String address, BuildContext context, Widget getpage) async {
    isloading.value = true;

    // Show a SnackBar indicating loading
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          inputText: 'Logging in...',
          fontWeight: FontWeight.bold,
          fontsize: 13,
          color: Colors.black,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('fairbanglaUser').doc(user.uid).set({
          'email': email,
          'name': name,
          'phone': phone,
          'address': address,
          'uid': user.uid
        });

        Get.to( getpage);

      }

      return user;
    } catch (e) {
      
       // ignore: use_build_context_synchronously
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          inputText: e.toString(),
          fontWeight: FontWeight.bold,
          fontsize: 13,
          color: Colors.black,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    }
        isloading.value = false;
        return null;

  }

    Future<User?> signIn(String email, String password, Widget getPage,BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(userCredential.user != null){
        Get.to(getPage);
      }
      return userCredential.user;

    } catch (e) {

 ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          inputText: e.toString(),
          fontWeight: FontWeight.bold,
          fontsize: 13,
          color: Colors.black,
        ),
        duration: const Duration(seconds: 2),
      ),
    );      
    return null;
    }
  }


  Future getuser() async{
    final currentuser = FirebaseAuth.instance.currentUser;

        DocumentSnapshot doc = await FirebaseFirestore.instance.collection('fairbanglaUser').doc(currentuser!.uid).get();

         if(doc.exists){
          return UserDAta.fromFirestore( doc.data() as Map<String, dynamic> );
        }
        return null;

  }


}