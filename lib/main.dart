import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kush/views/frontscreen.dart';
import 'package:kush/views/homeScreen.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();   // both these lines should be above runapp
  await Firebase.initializeApp();
  runApp(const Myapp());
}


class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user=FirebaseAuth.instance.currentUser;
    print(user?.uid.toString());
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: user != null ? frontscreen() : const homeScreen(),

    );
  }
}

