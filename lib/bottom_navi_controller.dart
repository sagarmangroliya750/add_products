// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'bottom_Navigations/cart.dart';
import 'bottom_Navigations/favourite.dart';
import 'bottom_Navigations/home.dart';
import 'bottom_Navigations/profile.dart';

class bottom_navi_controller extends StatefulWidget {
  const bottom_navi_controller({Key? key}) : super(key: key);

  @override
  State<bottom_navi_controller> createState() => _bottom_navi_controllerState();
}

class _bottom_navi_controllerState extends State<bottom_navi_controller> {

  PageController pageController =PageController();
  List<Color> clr = [Colors.black,Colors.green,Colors.red,Colors.yellow];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView(
        controller: pageController,
        children: <Widget>[
          home(),favourite(),cart(),profile()
        ],
      ),
      extendBody: true,
      backgroundColor:Colors.black,
      bottomNavigationBar: RollingBottomBar(
        controller: pageController,
        color:Colors.orange.shade300,
        useActiveColorByDefault: false,
        items: const [
          RollingBottomBarItem(Icons.home, label: 'Home',activeColor:Colors.green),
          RollingBottomBarItem(Icons.favorite, label: 'Favourite',activeColor:Colors.redAccent),
          RollingBottomBarItem(Icons.add_shopping_cart, label: 'Cart',activeColor:Colors.brown),
          RollingBottomBarItem(Icons.person, label: 'Profile',activeColor:Colors.blue),
        ],
        enableIconRotation: true,
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
