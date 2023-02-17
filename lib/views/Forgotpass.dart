import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kush/views/homeScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class Forgotpass extends StatefulWidget {
  const Forgotpass({Key? key}) : super(key: key);

  @override
  State<Forgotpass> createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {
  TextEditingController forgotpasscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text("SignUp"),
        actions: [
          Icon(Icons.more_vert),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(

          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                height: 300,
                child: Lottie.asset("assets/107385-login.json"),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child:TextFormField(
                  controller: forgotpasscontroller,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email_outlined),
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
                onPressed: ()async{
                var forgotpass = forgotpasscontroller.text.trim();
                try{
                   await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotpass).then((value) =>
                    {
                      print("Email Sent"),
                      Get.to(()=>homeScreen()),
                    });
                }on FirebaseAuthException catch (e) {
                  print("Error of forgot pass $e");
                }

                },
                child: Text("Forgot Password"),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
