// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, non_constant_identifier_names, unnecessary_new, prefer_collection_literals, unnecessary_this, avoid_unnecessary_containers

import 'package:add_products/login_pg.dart';
import 'package:add_products/products_list.dart';
import 'package:flutter/material.dart';
import '../Utils.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String p = "Price : ";
  bool issearch = false;
  bool dark = true;

  TextEditingController h1 = TextEditingController();
  TextEditingController h2 = TextEditingController();
  TextEditingController h3 = TextEditingController();
  TextEditingController h4 = TextEditingController();

  TextEditingController i1 = TextEditingController();
  bool status = false;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Drawer(
            backgroundColor: Colors.black87,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    accountName: Text("Email"),
                    accountEmail: Text('email', style: TextStyle(color: Colors.green),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [
                          Colors.deepPurple,
                          Colors.indigo,
                          Colors.deepPurple,
                          Colors.indigo
                        ])),
                    otherAccountsPictures: [
                      CircleAvatar(backgroundImage: NetworkImage('imageurl')),
                      CircleAvatar(
                        backgroundImage: NetworkImage('imageurl'),
                      ),
                    ],
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage('imageurl'),
                    )),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.add_business,
                    color: Colors.blueAccent,
                  ),
                  title: Text("Add Products",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  subtitle: Text("Add your products",
                      style: TextStyle(color: Colors.white60, fontSize: 13)),
                ),
                ListTile(
                  leading: Icon(
                    Icons.view_day_outlined,
                    color: Colors.blueAccent,
                  ),
                  title: Text("View Products",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                  subtitle: Text(
                    "View your product list",
                    style: TextStyle(color: Colors.white60, fontSize: 13),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return home();
                      },
                    ));
                  },
                ),
                ListTile(
                  onTap: () {
                    Utils.prefs!.clear();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return login_pg();
                      },
                    ));
                  },
                  leading: Icon(Icons.logout, color: Colors.blueAccent),
                  title: Text(
                    "Log out",
                    style: TextStyle(color: Colors.red.shade400, fontSize: 16),
                  ),
                  subtitle: Text("Sign out your profile",
                      style: TextStyle(color: Colors.white60, fontSize: 13)),
                ),
              ],
            )),
        appBar: issearch
            ? AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white10,
                elevation: 0, //Sec Appbar
                title: Container(
                  height: 45,
                  width: double.infinity,
                  child: TextField(
                    controller: i1,
                    autofocus: true,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                issearch = false;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 20,
                            )),
                        contentPadding: EdgeInsets.all(5),
                        filled: true,
                        fillColor: Colors.orange.shade200,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: " Search Products . . .",
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 15)),
                  ),
                ))
            : AppBar(
                //Main Appbar
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.brightness_medium,
                        size: 22,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          issearch = true;
                        });
                      },
                      icon: Icon(Icons.search_rounded)),
                ],
                centerTitle: true,
                backgroundColor: Colors.orange.shade400,
                title: Text("Home Page"),
              ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.65),
                itemCount:Product.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return home();
                              },
                            ));
                          },
                          child: Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Colors.indigoAccent.shade100
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Center(
                                      child: Container(alignment: Alignment.center,
                                    height: 150, child: Image.asset("${Product[index]['image']}")
                                  )),
                                  Container(
                                      height: 80, width: 140,
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.indigoAccent.shade100.withOpacity(0.5),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.orange.shade100,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        bottom: Radius.circular(20))),
                                            height: 30,
                                            width: 120,
                                            child: Text("${Product[index]['name']}", style: TextStyle(fontSize: 15,
                                                    fontFamily: "wlc5")),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 20),
                                            child: Text("💰${Product[index]['price']}/-", style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white)),
                                          )
                                        ],
                                      ))
                                ],
                              )),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )),
          ],
        )));
  }
}

