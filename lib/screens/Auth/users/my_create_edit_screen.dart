// ignore_for_file: use_build_context_synchronously
import 'package:demo/components/my_alert.dart';
import 'package:demo/components/my_custom_clickable_icon.dart';
import 'package:demo/components/my_custom_input.dart';
import 'package:demo/services/users_api.dart';
import 'package:flutter/material.dart';

class MyCreateEditScreen extends StatefulWidget {
  const MyCreateEditScreen({
    super.key,
    required this.isCreate,
    required this.firstName,
    required this.lastName,
    required this.userId,
    required this.refresh,
  });

  final bool isCreate;
  final String firstName;
  final String lastName;
  final String userId;
  final Function refresh;
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
    myNameTextBoxController.dispose();
    myJobTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(!widget.isCreate ? 'Update User' : 'Create User'),
        leading: CustomClickableIcon(
          onPressedIcon: () {
            widget.refresh();
            Navigator.pop(context);
          },
        ),
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
                  MyCustomInput(
                    inputController: myNameTextBoxController,
                    errormessage:
                        isNameTextBoxEmpty ? "Please enter name" : null,
                    maxLength: 50,
                    hintText: "Enter your name",
                    keyboardType: TextInputType.name,
                    onTextChange: (text) {
                      setState(() {
                        isNameTextBoxEmpty = false;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyCustomInput(
                    inputController: myJobTextController,
                    errormessage: isJobTextBoxEmpty ? "Please enter job" : null,
                    maxLength: 50,
                    hintText: "Enter your job",
                    keyboardType: TextInputType.text,
                    onTextChange: (text) {
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
    if (isNameTextBoxEmpty || isJobTextBoxEmpty) return;
    if (widget.isCreate) {
      final response = await UserApi().createUserAPI(body);
      if (response.statusCode == 201) {
        Navigator.of(context).pop();
        showMyDialogBox(
            context, 'Alert', 'Your account is created successfully!');
      } else {
        showMyDialogBox(context, 'Alert', 'Something went wrong!');
      }
    } else {
      final response =
          await UserApi().updateUserAPI(widget.userId.toString(), body);
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        showMyDialogBox(
            context, 'Alert', 'Your account is updated successfully!');
      } else {
        showMyDialogBox(context, 'Alert', 'Something went wrong!');
      }
    }
  }
}
