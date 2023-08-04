import 'package:flutter/material.dart';

class MyCustomInput extends StatefulWidget {
  const MyCustomInput({
    super.key,
    this.inputController,
    this.hintText,
    this.keyboardType,
    this.maxLength,
    this.errormessage,
    this.onTextChange,
  });
  final TextEditingController? inputController;
  final String? hintText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? errormessage;
  final Function? onTextChange;

  @override
  State<MyCustomInput> createState() => _MyCustomInputState();
}

class _MyCustomInputState extends State<MyCustomInput> {
  @override
  void initState() {
    super.initState();
  }

  void disponse() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.inputController,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          borderSide: BorderSide(color: Colors.amber, width: 4.0),
        ),
        errorText: widget.errormessage,
      ),
      keyboardType: widget.keyboardType,
      onChanged: (text) {
        widget.onTextChange!(text);
      },
    );
  }
}
