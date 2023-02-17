import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kush/views/Forgotpass.dart';
import 'package:kush/views/Signupscreen.dart';
import 'package:kush/views/frontscreen.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';



class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  TextEditingController loginemailcontroller = TextEditingController();
  TextEditingController loginpasscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text("LogIn"),
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
                  controller: loginemailcontroller,
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
                  controller: loginpasscontroller,
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
                  onPressed: ()async{
                var loginemail = loginemailcontroller.text.trim();
                var loginpass = loginpasscontroller.text.trim();
                try{
                  final User? firebaseuser = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: loginemail, password: loginpass)).user;
                    if(firebaseuser != null)
                      {
                        Get.to(()=>frontscreen());
                      }else{
                      print("Wrong email and password");
                    }
                } on FirebaseAuthException catch (e){
                  print("Error $e");
                }



                  },
                  child: Text("Login"),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(()=>Forgotpass());
                },
                child: Container(
                     child: Card(
                         child:Padding(padding: const EdgeInsets.all(10.0),
                           child:Text("Forget Password"),
                     ),
                     ),
                 ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>Signupscreen());

                },
                child: Container(
                    child: Card(

                      child:Padding(padding: const EdgeInsets.all(10.0),
                        child:Text("Dont have a account SignUp"),
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
