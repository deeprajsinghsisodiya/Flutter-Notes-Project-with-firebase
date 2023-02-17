import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kush/views/frontscreen.dart';
import 'package:kush/views/homeScreen.dart';

class noteedit extends StatefulWidget {
  const noteedit({Key? key}) : super(key: key);

  @override
  State<noteedit> createState() => _noteeditState();
}

class _noteeditState extends State<noteedit> {
  TextEditingController notecotroller = TextEditingController();
  // User? userid FirebaseAuth.ins
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Note Edit"),),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: notecotroller..text = "${Get.arguments['notes'].toString()}",

            ),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
              onPressed: ()async{
              FirebaseFirestore.instance.collection("notes").doc(Get.arguments['DocID'].toString()).update(
                {
                  'userNotes': notecotroller.text.trim(),
                },
              ).then((value) => {
                Get.to(()=>frontscreen()),
                print("Data updated"),}


              );
            },
                child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
