import 'dart:async';

import 'package:demo/components/my_custom_tab.dart';
import 'package:demo/screens/Auth/users/my_home_screen.dart';
import 'package:demo/screens/UnAuth/my_login.dart';
import 'package:demo/utils/Constants/const.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => MySplashScreenState();
}

class MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    getUserLoggedInOrNot();
  }

  void navigateToHomeScreen(BuildContext context, routename) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => routename,
        ),
      );
    });
  }

  Future<void> getUserLoggedInOrNot() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(TOKEN);
    if (token == null) {
      navigateToHomeScreen(context, const MyLoginScreen());
    } else {
      navigateToHomeScreen(context, const MyCustomTab());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber.shade700,
        child: const Center(
          child: Text(
            'My Demo',
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
