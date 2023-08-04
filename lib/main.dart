import 'package:demo/screens/Auth/users/my_home_screen.dart';
import 'package:demo/screens/UnAuth/my_login.dart';
import 'package:demo/screens/UnAuth/my_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>
            const MySplashScreen(), // Initial loading screen if needed
        '/home': (context) => const MyHomeScreen(),
        '/login': (context) => const MyLoginScreen(),
      },
      builder: EasyLoading.init(),
    );
  }
}
