// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';

class favourite extends StatefulWidget {
  const favourite({Key? key}) : super(key: key);

  @override
  State<favourite> createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Favourites"),
        backgroundColor: Colors.orange.shade400,
      ),
    );
  }
}
