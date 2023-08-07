import 'dart:convert';

import 'package:demo/components/my_alert.dart';
import 'package:demo/components/my_custom_input.dart';
import 'package:demo/components/my_custom_tab.dart';
import 'package:demo/screens/Auth/users/my_home_screen.dart';
import 'package:demo/services/users_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo/utils/Constants/const.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  var email = TextEditingController();
  var password = TextEditingController();

  bool emailError = false;
  bool passwordError = false;
  bool loader = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      loader = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              // color: Colors.cyan,
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    MyCustomInput(
                      inputController: email,
                      errormessage:
                          emailError ? "Enter email is invalid!" : null,
                      maxLength: 50,
                      hintText: 'Enter Email',
                      keyboardType: TextInputType.emailAddress,
                      onTextChange: (text) {
                        setState(() {
                          emailError = false;
                        });
                      },
                      isInputIsPassword: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyCustomInput(
                      inputController: password,
                      errormessage:
                          passwordError ? "Enter password is invalid!" : null,
                      hintText: 'Enter Password',
                      keyboardType: TextInputType.emailAddress,
                      onTextChange: (text) {
                        setState(() {
                          passwordError = false;
                        });
                      },
                      isInputIsPassword: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: !loader ? onPressLogin : null,
                      child: loader
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 0.6,
                              ),
                            )
                          : const Text('Login'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onPressLogin() async {
    setState(() {
      loader = true;
      emailError = email.text.isEmpty || email.text.length < 5 ? true : false;
      passwordError =
          password.text.isEmpty || password.text.length < 5 ? true : false;
    });

    if (!emailError && !passwordError) {
      // api call
      Map<String, String> params = {
        "email": email.text.toString(),
        "password": password.text.toString()
      };
      try {
        final response = await UserApi().userLoginAPI(params);
        final jsonResponse = jsonDecode(response.body);
        if (response.statusCode == 200) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(TOKEN, jsonResponse['token']);
          setState(() {
            loader = false;
          });
          Route route = MaterialPageRoute(
            builder: (context) => const MyCustomTab(),
          );
          Navigator.pushReplacement(
            context,
            route,
          );
        } else if (jsonResponse['error'] == 'user not found') {
          showMyDialogBox(context, 'Alert', 'User not Found!');
          setState(() {
            loader = false;
          });
        } else {
          setState(() {
            loader = false;
          });
        }
      } catch (error) {
        setState(() {
          loader = false;
        });
      }
    } else {
      setState(() {
        loader = false;
      });
    }
  }
}
