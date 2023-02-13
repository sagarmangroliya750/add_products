// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_field, prefer_final_fields, non_constant_identifier_names, unnecessary_null_comparison, use_build_context_synchronously, sized_box_for_whitespace, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:add_products/login_pg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class register_pg extends StatefulWidget {
  const register_pg({Key? key}) : super(key: key);

  @override
  State<register_pg> createState() => _register_pgState();
}

class _register_pgState extends State<register_pg> {

  TextEditingController tname = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tpassword = TextEditingController();

  ImagePicker _picker = ImagePicker();
  String Imagepath = "";

  sendUserDatatoDB()
  {
    DatabaseReference _collectionRef = FirebaseFirestore.instance.collection("user-data") as DatabaseReference;
    return _collectionRef.push().set({
      'name'  : tname.text,
      'image' : Imagepath
    }).then((value) => print("User Name Added Successfully...")).catchError((error) => print("Something Wrong..."));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade400,
                      Colors.orangeAccent.shade100,
                      Colors.orange.shade400
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    transform: GradientRotation(20))),
            child:Column(
              children: [
                Container(
                  height:35,width:150,
                  alignment:Alignment.center,
                  decoration:BoxDecoration(color:Colors.black87,
                    borderRadius:BorderRadius.vertical(bottom:Radius.elliptical(50,5),top:Radius.elliptical(50,5)),
                  ),
                  margin:EdgeInsets.only(top:40,bottom:20),
                  child:Text("Sign Up",style:TextStyle(fontSize:22,color:Colors.white,fontFamily: "fnt")),
                ),
                InkWell(
                  onLongPress:() {
                    setState(() {
                      Imagepath.isNotEmpty ? Imagepath="" : null;
                    });
                  },
                  child:Container(
                    height:120,width:120,margin:EdgeInsets.only(top:20),
                    decoration:BoxDecoration(color:Colors.orange.shade200,
                    boxShadow: [
                      BoxShadow(
                        blurRadius:10,spreadRadius:8,offset:Offset(0,0),color:Colors.orangeAccent
                      )
                    ]
                    ),
                    child: Imagepath.isEmpty
                        ? Icon( Icons.add_photo_alternate,size:60,color: Colors.grey.shade400,)
                        : Image.file(File(Imagepath),fit:BoxFit.fill),
                  ),
                ),
                InkWell(
                  onTap: () {
                   showDialog(context: context, builder: (context) {
                     return AlertDialog(
                       title:Text("Photos"),
                       content:Text("Add Images via Camera or Gallery.."),
                       actions: [
                         TextButton(onPressed: () async {

                           final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                           Navigator.pop(context);
                           setState(() {
                             if(photo!=null)
                             {
                               Imagepath = photo.path;
                             }
                           });

                         }, child:Text("Camera")),

                         TextButton(onPressed: () async {
                           final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                           Navigator.pop(context);
                           setState(() {
                             if(photo!=null)
                             {
                               Imagepath = photo.path;
                             }
                           });
                         }, child:Text("Gallery"))
                       ],
                     );
                   },);
                  },
                  child: Container(
                    height:35,width:120,
                    alignment:Alignment.center,
                    decoration:BoxDecoration(color:Colors.black87,
                        borderRadius:BorderRadius.circular(20),
                    ),
                    margin:EdgeInsets.only(top:15),
                    child:Text("Add Image",style:TextStyle(fontSize:22,color:Colors.orange.shade200,fontFamily:"fnt"),),
                  ),
                ),
               Expanded(
                   child:Container(
                 height: 300, width: 420,
                 decoration: BoxDecoration(
                     color: Colors.black87,
                     borderRadius: BorderRadius.only(
                         topRight: Radius.circular(40),
                         topLeft: Radius.circular(40))),
                 child: ListView(
                   children: [
                     Padding(
                       padding: EdgeInsets.only(top:30, right: 20, left: 20),
                       child: TextField(
                         controller: tname,style:TextStyle(color:Colors.white),
                         decoration: InputDecoration(
                             enabledBorder: OutlineInputBorder(
                                 borderSide:
                                 BorderSide(color: Colors.orange.shade200),
                                 borderRadius: BorderRadius.circular(30)),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(30)),
                             prefixIcon: Icon(
                               Icons.person,
                               color: Colors.orange.shade200,
                             ),
                             hintText: "Enter Your Name",
                             hintStyle: TextStyle(color: Colors.white70),
                             labelText: "Name",
                             labelStyle: TextStyle(color: Colors.orange.shade200)),
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.only(top:20, right: 20, left: 20),
                       child: TextField(
                         autofillHints:[AutofillHints.email],
                         controller: temail,style:TextStyle(color:Colors.white),
                         decoration: InputDecoration(
                             enabledBorder: OutlineInputBorder(
                                 borderSide:
                                 BorderSide(color: Colors.orange.shade200),
                                 borderRadius: BorderRadius.circular(30)),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(30)),
                             prefixIcon: Icon(
                               Icons.mail_lock_outlined,
                               color: Colors.orange.shade200,
                             ),
                             hintText: "Enter Your Email",
                             hintStyle: TextStyle(color: Colors.white70),
                             labelText: "Email",
                             labelStyle: TextStyle(color: Colors.orange.shade200)),
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.only(
                           right: 20, left: 20, top: 20, bottom: 30),
                       child: TextField(
                         controller: tpassword,style:TextStyle(color:Colors.white),
                         decoration: InputDecoration(
                             enabledBorder: OutlineInputBorder(
                                 borderSide:
                                 BorderSide(color: Colors.orangeAccent),
                                 borderRadius: BorderRadius.circular(30)),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(30)),
                             prefixIcon:
                             Icon(Icons.lock, color: Colors.orange.shade200),
                             hintText: "Enter Your Password",
                             hintStyle: TextStyle(color: Colors.white70),
                             labelText: "Password",
                             labelStyle: TextStyle(color: Colors.orange.shade200)),
                       ),
                     ),
                     Column(
                       children: [
                         InkWell(
                             onTap: () async {
                               String semail = temail.text.trim();
                               String spassword = tpassword.text.trim();
                               try {
                                 final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                   email: semail,
                                   password: spassword,
                                 );

                                 AwesomeDialog(
                                   context: context,
                                   dialogType: DialogType.success,
                                   animType: AnimType.rightSlide,
                                   barrierColor:Colors.orangeAccent.shade200,
                                   dismissOnTouchOutside:false,
                                   title: 'Successful',
                                   desc: 'Registered Successfully...!!!',
                                   btnCancelOnPress: () {
                                     Navigator.pop(context);
                                   },
                                   btnOkOnPress: () {
                                     Navigator.push(context,MaterialPageRoute(builder: (context) {
                                       return login_pg();
                                     },));
                                   },
                                 ).show();

                               } on FirebaseAuthException catch (e) {
                                 if (e.code == 'weak-password') {
                                   print('The password provided is too weak.');
                                 }
                                 else if (e.code == 'email-already-in-use') {
                                   print('The account already exists for that email.');
                                 }
                               } catch (e) {
                                 print(e);
                               }
                               print(semail);
                               print(spassword);
                             },
                             child:Column(
                               children: [
                               Container(
                                 height: 50, width:319,
                                 margin: EdgeInsets.only(bottom:55),
                                 decoration: BoxDecoration(
                                     color: Colors.blueAccent,
                                     borderRadius: BorderRadius.circular(30),
                                     boxShadow: [
                                       BoxShadow(blurRadius: 8, spreadRadius: -3)
                                     ]),
                                 alignment: Alignment.center,
                                 child: Text("Register", style:TextStyle(fontSize:18, fontFamily: "wlc4")),
                               ),
                               InkWell(
                                 onTap:() {

                                   sendUserDatatoDB();
                                   print("Added Successfully");
                                   Navigator.push(context,MaterialPageRoute(builder: (context) {
                                     return login_pg();
                                   },));
                                 },
                                 child:Container(
                                     alignment:Alignment.center,
                                     height:55,decoration:BoxDecoration(
                                   shape:BoxShape.circle,color:Colors.orange.shade300,
                                 ),
                                     child: Icon(Icons.arrow_back_ios_new_sharp,size:25,)
                                 ),
                               )
                             ],)
                         ),
                       ],
                     )
                   ],
                 ),
               ))
              ],
            ))
    );
  }
}
