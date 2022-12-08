import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/UI/LoginScreen/loginScreen.dart';

import '../../shared/components/constants.dart';
import '../HomeScreen/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  void navigationPage() async {
    Widget? widget;
    var user = FirebaseAuth.instance.currentUser;
    if (user != null ) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget!,
      ),
    );
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/images/SplashScreen.png',
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      )),
    );
  }
}
