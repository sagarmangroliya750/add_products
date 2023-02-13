// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, avoid_print, use_build_context_synchronously, avoid_single_cascade_in_expression_statements, unnecessary_null_comparison

import 'package:add_products/bottom_navi_controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Utils.dart';

class login_pg extends StatefulWidget {
  const login_pg({Key? key}) : super(key: key);

  @override
  State<login_pg> createState() => _login_pgState();
}

class _login_pgState extends State<login_pg> {

  TextEditingController temail = TextEditingController();
  TextEditingController tpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                height:60,width:180,
                margin:EdgeInsets.only(top:110,bottom:50),alignment:Alignment.center,
                  decoration:BoxDecoration(color:Colors.orangeAccent.shade200,borderRadius:BorderRadius.circular(100),
                  boxShadow:[
                    BoxShadow(color:Colors.orangeAccent.shade200,spreadRadius:-3,blurRadius:8,offset:Offset(0, 8)
                    )
                  ]
                  ),
                child:Text("Welcome",style:TextStyle(fontSize:35,color:Colors.black,fontFamily:"fnt"))
              ),
              Container(
                height:35,width:150,
                alignment:Alignment.center,
                decoration:BoxDecoration(color:Colors.black87,
                    borderRadius:BorderRadius.vertical(bottom:Radius.elliptical(50,5),top:Radius.elliptical(50,5)),
                ),
                child:Text("User Login",style:TextStyle(fontSize:22,color:Colors.white,fontFamily: "fnt")),
              ),
              Expanded(
                  child: Container(
                height: size.height,
                width: size.width,
                margin: EdgeInsets.only(top:3),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 90, right: 20, left: 20),
                      child: TextField(
                        autofillHints: [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        textInputAction: TextInputAction.next,
                        controller: temail,style:TextStyle(color:Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange.shade200),
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
                        keyboardType: TextInputType.number,
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
                            String semail    = temail.text.trim();
                            String spassword = tpassword.text.trim();

                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: semail, password: spassword);
                              await Utils.prefs!.setBool('loginstatus', true);
                              Navigator.push(context,MaterialPageRoute(builder: (context) => bottom_navi_controller(),));
                              print("Login Successfully..");
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                barrierColor:Colors.orangeAccent.shade200,
                                autoHide:Duration(seconds:5),
                                dismissOnTouchOutside:false,
                                title: 'Successful',
                                desc: 'User Login Successfully...',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                                 setState(() {
                                   temail.text="";
                                   tpassword.text="";
                                 });
                                 await Utils.prefs!.setBool('loginstatus', true);
                                Navigator.push(context,MaterialPageRoute(builder: (context) => bottom_navi_controller(),));
                                },
                              )..show();
                            }
                            on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {

                                print('No user found for that email.');

                                Fluttertoast.showToast(
                                    msg: "⚠️ No user found for that email",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.red,
                                    fontSize: 16.0
                                );
                              }
                              else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');

                                Fluttertoast.showToast(
                                    msg: "Your Password is incorrect‼️",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.red,
                                    fontSize: 16.0
                                );
                              }
                              else if(temail.text== "" || tpassword.text == "")
                                {
                                  Fluttertoast.showToast(
                                      msg: "Empty Details ‼️",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.red,
                                      fontSize: 16.0
                                  );
                                }
                              else
                              {
                                Fluttertoast.showToast(
                                    msg: "⚠️ Email or Password Incorrect",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.red,
                                    fontSize: 16.0
                                );
                              }
                            }
                          },
                          child: Container(
                            height: 50,
                            width: size.width-40,
                            margin: EdgeInsets.only(bottom:80),
                            decoration: BoxDecoration(
                                color: Colors.green.shade400,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(blurRadius: 8, spreadRadius: -3)
                                ]),
                            alignment: Alignment.center,
                            child: Text("Log In",style:TextStyle(fontSize:18,fontFamily: "wlc4")),
                          ),
                        ),
                        Column(
                          children: [
                          //  Text("Or",style:TextStyle(color:Colors.white),),
                            Container(
                              alignment:Alignment.center,
                              height:45,width:350,
                              decoration:BoxDecoration(
                                border:Border.all(color:Colors.grey),borderRadius:BorderRadius.circular(5)
                              ),
                              child:Text("Sign Up",style:TextStyle(color:Colors.white)),
                            )
                          ],
                        )

                        // Container(
                        //   height: 50,width:250,color:Colors.blue,
                        // )
                      ],
                    ),
                  ],
                ),
              ))
            ],
          )

        )
    );
  }
}
