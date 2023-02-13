// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Cart"),
        backgroundColor: Colors.orange.shade400,
      ),
    );
  }
}
