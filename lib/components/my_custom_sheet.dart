import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Future<void> showActionSheet(BuildContext context, onPressUpdate, onPressDelete,
    cancelButtonText, updateButtonText, deleteButtonText) async {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child:
            Text(cancelButtonText, style: const TextStyle(color: Colors.black)),
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            onPressUpdate(context);
          },
          child: Text(
            updateButtonText,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            onPressDelete();
          },
          child: Text(
            deleteButtonText,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
        )
      ],
    ),
  );
}
