// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:demo/components/my_clickable_image.dart';
import 'package:demo/components/my_label.dart';
import 'package:flutter/material.dart';

class MyUserDetailScreen extends StatefulWidget {
  const MyUserDetailScreen({super.key, required this.user});
  final dynamic user;
  @override
  State<MyUserDetailScreen> createState() => MyUserDetailScreenStack();
}

class MyUserDetailScreenStack extends State<MyUserDetailScreen> {
  var userId;
  var userFirstName;
  var userLastName;
  var userEmail;
  var userAvatar;
  @override
  void initState() {
    super.initState();
    final userdetail = widget.user;
    setState(() {
      userId = userdetail['id'].toString();
      userFirstName = userdetail['first_name'];
      userLastName = userdetail['last_name'];
      userEmail = userdetail['email'];
      userAvatar = userdetail['avatar'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            const SizedBox(height: 30),
            MyClickableImage(
              userAvatar: userAvatar,
            ),
            Align(
              alignment: Alignment.center,
              child: MyTextLabel(text: userFirstName),
            ),
            Align(
              alignment: Alignment.center,
              child: MyTextLabel(text: userLastName, size: 30),
            ),
            Align(
              alignment: Alignment.center,
              child: MyTextLabel(text: userEmail),
            ),
          ],
        ),
      ),
    );
  }
}
