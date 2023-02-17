
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kush/views/homeScreen.dart';

signupuser(String username, String password, String phone, String email)async {
  User? userid = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("users")
        .doc(userid!.uid)
        .set({
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
      'createdat': DateTime.now(),
      'userid': userid.uid,
    }).then((value) =>
    { FirebaseAuth.instance.signOut(),
      Get.to(() => homeScreen()),
    });
  } on FirebaseAuthException catch (e) {
    print("$e");
  }
}