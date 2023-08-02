import 'dart:convert';

import 'package:demo/components/my_alert.dart';
import 'package:demo/services/users_api.dart';
import 'package:flutter/material.dart';

class MyCreateEditScreen extends StatefulWidget {
  const MyCreateEditScreen({
    super.key,
    required this.isCreate,
    required this.firstName,
    required this.lastName,
    required this.userId,
  });

  final bool isCreate;
  final String firstName;
  final String lastName;
  final String userId;
  @override
  State<MyCreateEditScreen> createState() => MyCreateEditScreenState();
}

class MyCreateEditScreenState extends State<MyCreateEditScreen> {
  final myNameTextBoxController = TextEditingController();
  final myJobTextController = TextEditingController();
  bool isNameTextBoxEmpty = false;
  bool isJobTextBoxEmpty = false;
  @override
  void initState() {
    super.initState();
    myNameTextBoxController.text = widget.firstName;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(!widget.isCreate ? 'Update User' : 'Create User'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          Center(
            child: SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: myNameTextBoxController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        borderSide: BorderSide(color: Colors.amber, width: 4.0),
                      ),
                      errorText:
                          isNameTextBoxEmpty ? "Please enter name" : null,
                    ),
                    keyboardType: TextInputType.name,
                    onChanged: (text) {
                      setState(() {
                        isNameTextBoxEmpty = false;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: myJobTextController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      hintText: "Enter your job",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        borderSide: BorderSide(color: Colors.amber, width: 4.0),
                      ),
                      errorText: isJobTextBoxEmpty ? "Please enter job" : null,
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (text) {
                      setState(() {
                        isJobTextBoxEmpty = false;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      onPressSubmitButton();
                    },
                    child: const Text(
                      'Submit',
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onPressSubmitButton() async {
    setState(() {
      myNameTextBoxController.text.isEmpty ? isNameTextBoxEmpty = true : false;
      myJobTextController.text.isEmpty ? isJobTextBoxEmpty = true : false;
    });
    Map<String, String> body = {
      'name': myNameTextBoxController.text.toString(),
      'job': myJobTextController.text.toString(),
    };
    if (widget.isCreate) {
      // create User api called
      final response = await UserApi().createUserAPI(body);
      if (response.statusCode == 201) {
        Navigator.of(context).pop();
        showMyDialogBox(
            context, 'Alert', 'Your account is created successfully!');
      } else {
        showMyDialogBox(context, 'Alert', 'Something went wrong!');
      }
    } else {
      // update User api called
      final response =
          await UserApi().updateUserAPI(widget.userId.toString(), body);
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        showMyDialogBox(
            context, 'Alert', 'Your account is updated successfully!');
      } else {
        // ignore: use_build_context_synchronously
        showMyDialogBox(context, 'Alert', 'Something went wrong!');
      }
    }
  }
}
