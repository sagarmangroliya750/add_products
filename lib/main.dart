// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, camel_case_types

import 'package:add_products/bottom_navi_controller.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils.dart';
import 'login_pg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: demo(), debugShowCheckedModeBanner: false));
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gonext();
  }

  gonext() async {
    Utils.prefs = await SharedPreferences.getInstance();

    await Future.delayed(Duration(seconds: 4));

    bool loginstatus = Utils.prefs!.getBool('loginstatus') ?? false;

    if (loginstatus) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return bottom_navi_controller();
        },
      ));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return login_pg();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: AnimatedSplashScreen(
      splashIconSize: 100,
      splash: "myimg/ic_launcher.png",
      nextScreen:Text('loginstatus'),
      disableNavigation: true,
      backgroundColor: Color(0XFFFFCC99),
      curve: Curves.bounceInOut,
    )));
  }
}
