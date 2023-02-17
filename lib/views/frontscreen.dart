import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kush/views/createNotes.dart';
import 'package:kush/views/homeScreen.dart';

import 'noteedit.dart';

class frontscreen extends StatefulWidget {
 const frontscreen({Key? key}) : super(key: key);


  @override
  State<frontscreen> createState() => _frontscreenState();
}

class _frontscreenState extends State<frontscreen> {
  User? userid = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text("Front Screen"),
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(()=>homeScreen());
            },
              child: Icon(Icons.logout_outlined)
          ),
        ],
      ),
      body:  Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
              .collection("notes")
                  .where("userId",isEqualTo: userid?.uid)
                  .snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                if(snapshot.hasError){
                  return Text("Somethig went wrong");
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                if(snapshot.data!.docs.isEmpty){
                  return Center(
                    child: Text("No Data"),
                  );
                }
                if(snapshot != null && snapshot.data !=null){
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder:(context,index){
                      var notesvar = snapshot.data!.docs[index]['userNotes'];
                      var noteID = snapshot.data!.docs[index]['userId'];
                      var DocID = snapshot.data!.docs[index].id;
                      return Card(
                        child: ListTile(
                          title: Text(notesvar),
                          subtitle: Text(noteID),
                          trailing: Row(
                           mainAxisSize:MainAxisSize.min,
                            children: [
                              GestureDetector( onTap: (){


                                Get.to(()=>noteedit(),
                                  arguments: {
                                  'notes':notesvar,
                                    'DocID':DocID,
                                  },

                                );
                              },

                                child:  Icon(
                                color: Colors.indigoAccent,
                                    Icons.edit,
                                ),
                              ),
                                SizedBox(
                                width: 15,
                                ),
                        GestureDetector(
                          onTap: ()async{
                            await FirebaseFirestore.instance
                                .collection("notes")
                                .doc(DocID)
                                .delete();
                          },

                         child:     Icon(color: Colors.deepPurple,
                             Icons.delete,
                         ),
                        )
                          ],
                          ),
                        ),
                      );
                  }
                  );
                }
                return Container();
            },

          )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: (){
          Get.to(()=>createnotes());
        },
        child:Icon(
            Icons.add,
        ),
      ),
    );
  }
}
