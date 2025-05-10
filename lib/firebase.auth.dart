// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:fair_bangla/Webscreen/login.dart';
import 'package:fair_bangla/Webscreen/webshomepage.dart';
import 'package:flutter/material.dart ';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Elemnts/helpingwidgets.dart';
import 'usermodel.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool isloading = false.obs;

  String error = "";
  // Sign up with email and password
  Future<User?> signUp(String email, String password, String name, String phone,
      String address, BuildContext context, Widget getpage) async {
    isloading.value = true;

    // Show a SnackBar indicating loading
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: CustomText(
          inputText: 'Sign Up...',
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

        Get.to(getpage);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        error = "Enter correct email or password";
      }

      if(e.code == 'email-already-in-use'){
        error = "Email is already in use";
      } 

      else{
        error = "Something went wrong";
      }
      

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.yellow,
          content: CustomText(
            inputText: error,
            fontWeight: FontWeight.bold,
            fontsize: 13,
            color: Colors.black,
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    }
    isloading.value = false;
    return null;
  }

  Future<User?> signIn(String email, String password, Widget getPage,
      BuildContext context) async {
    isloading.value = true;

    // Show a SnackBar indicating loading
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        Get.to(getPage);
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        error = "Enter correct email or password";
      }
     


      Get.snackbar(
        "Error", // Title
        error, // Message
        backgroundColor: Colors.yellow,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );

      isloading.value = false;

      return null;
    }
  }

  Future<void> signOut(context) async {
    await _auth.signOut();

    await ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.yellow,
          content: CustomText(
            inputText: "Loging Our",
            fontWeight: FontWeight.bold,
            fontsize: 13,
            color: Colors.black,
          ),
          duration: const Duration(seconds: 4),
        ),
      ).closed;

    Get.to(SignUpPage(getpage: const WebHomePage()));
  }

  Future getuser() async {
    final currentuser = FirebaseAuth.instance.currentUser;

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('fairbanglaUser')
        .doc(currentuser!.uid)
        .get();

    if (doc.exists) {
      return UserDAta.fromFirestore(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
