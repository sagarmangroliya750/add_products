

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:sqflite/sqflite.dart';

import '../Utils.dart';
import '../login_pg.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {

  String id = "";
  String name = 'name';
  String email = 'email';
  String contact = 'contact';
  String password = 'password';
  String imagepath = "";
  String imageurl = "";

  TextEditingController h1 = TextEditingController();
  TextEditingController h2 = TextEditingController();
  TextEditingController h3 = TextEditingController();
  TextEditingController h4 = TextEditingController();

  Database? database;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {

    id = Utils.prefs!.getString('id') ?? "";
    name = Utils.prefs!.getString('name') ?? "";
    email = Utils.prefs!.getString('email') ?? "";
    contact = Utils.prefs!.getString('contact') ?? "";
    password = Utils.prefs!.getString('password') ?? "";
    imagepath = Utils.prefs!.getString('imagepath') ?? "";

    imageurl = "https://sagarspatel.000webhostapp.com/sagar/$imagepath";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.orange.shade400,
        title:Container(
          margin:EdgeInsets.only(left:60),
          child:Row(
            children: [
              Icon(Icons.account_circle_rounded),
              Text("  Profile",style:TextStyle(fontFamily:"wlc4",fontWeight:FontWeight.bold),),
            ],
          ),
        ),
        centerTitle:true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              InkWell(
                onTap:() {
                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                    return login_pg();
                  },));
                },child: Container(
                margin:EdgeInsets.only(top:10),
                alignment:Alignment.center,
                height:35,width:170,color:Colors.blueAccent.withOpacity(0.3),
                child:Text("Your Profile",style:TextStyle(fontSize:18,fontFamily:"userlogin",fontWeight:FontWeight.bold),),
              ),
              ),
              Container(
                height:100,width:100,margin:EdgeInsets.only(top:10),
                decoration:BoxDecoration(border:Border.all(color:Colors.black)),
                child:imagepath.isEmpty ? Icon(Icons.add_a_photo_sharp)
                    : Image.network(imageurl),
              ),
            ],
          ),
          Padding(
              padding:EdgeInsets.all(10),
              child:TextField(
                decoration:InputDecoration(border: OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
                    labelText:name,
                    hintText: name,
                    prefixIcon:Icon(Icons.person,color:Colors.blueAccent)
                ),
                controller:h1,
              )),
          Padding(
              padding:EdgeInsets.all(10),
              child:TextField(
                //readOnly:true,
                enabled: false,
                decoration:InputDecoration(border: OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
                  labelText:email,
                  prefixIcon:Icon(Icons.call,color:Colors.green),
                ),
              )),
          Padding(
              padding:EdgeInsets.all(10),
              child:TextField(
                // readOnly:true,
                enabled:false,
                decoration:InputDecoration(border: OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
                  labelText:contact,
                  prefixIcon:Icon(Icons.email,color: Colors.brown),
                ),
                controller:h3,
              )),
          Padding(
              padding:EdgeInsets.all(10),
              child:TextField(
                // readOnly:true,
                enabled:false,
                decoration:InputDecoration(border: OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
                  labelText:password,
                  prefixIcon:Icon(Icons.lock,color:Colors.green.shade400),
                  suffixIcon:Icon(Icons.remove_red_eye_sharp),
                ),
                controller:h4,
                obscureText:true,
              )),
          Column(
            children: [
              SizedBox(
                height:40,width:120,
                child:GFButton(
                  elevation: 6,
                  splashColor:Colors.orange,
                  onPressed: (){},
                  text: "Update",textStyle:TextStyle(fontSize:16),
                  icon: Icon(Icons.update,),
                  color:Colors.green,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
