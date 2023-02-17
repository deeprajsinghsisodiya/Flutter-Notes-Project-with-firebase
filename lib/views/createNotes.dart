import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class createnotes extends StatefulWidget {
  const createnotes({Key? key}) : super(key: key);

  @override
  State<createnotes> createState() => _createnotesState();
}

class _createnotesState extends State<createnotes> {
  TextEditingController notecontroller = TextEditingController();
  User? userid = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Create Notes"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: notecontroller,
                maxLength: null,
                decoration: InputDecoration(hintText: "Add Notes"),
              ),
            ),
            ElevatedButton(
              onPressed: ()async{
                var notes = notecontroller.text.trim();
                if(notes!=null){
                  try{
                    await FirebaseFirestore.instance
                        .collection("notes")
                        .doc()
                        .set({
                            "Created at" : DateTime.now(),
                            "userNotes" : notes,
                              "userId" : userid!.uid,
                          });
                  }catch (e){
                    print("$e");
                  }
                }
              }, child: Text("Add Notes"),)
          ],
        ),
      ),
    );
  }
}
