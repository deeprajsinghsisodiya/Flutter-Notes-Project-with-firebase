import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kush/views/homeScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import '../services/signupservices.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({Key? key}) : super(key: key);

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  TextEditingController Usernamecontroller = TextEditingController();
  TextEditingController Phonecontroller = TextEditingController();
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Passwordcontroller = TextEditingController();
  User? currentUser=FirebaseAuth.instance.currentUser;
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
                  controller: Usernamecontroller,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person_2_outlined),
                    hintText: 'UserName',
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child:TextFormField(
                  controller: Phonecontroller,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.phone_android_outlined),
                    hintText: 'Phone',
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child:TextFormField(
                  controller: Emailcontroller,
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child:TextFormField(
                  controller: Passwordcontroller,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.password_outlined),
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
                onPressed: (){
                var username = Usernamecontroller.text.trim();
                var phone = Phonecontroller.text.trim();
                var email = Emailcontroller.text.trim();
                var password = Passwordcontroller.text.trim();
                FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
                    .then((value)=> {
                      print("User Created"),
                      signupuser(
                        username,
                        password,
                        phone,
                        email,
                      ),


                });
                },
                child: Text("Sign Up"),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(()=>homeScreen());
                },
                child: Container(
                  child: Card(

                    child:Padding(padding: const EdgeInsets.all(10.0),
                      child:Text("Already have a account SignIn"),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
