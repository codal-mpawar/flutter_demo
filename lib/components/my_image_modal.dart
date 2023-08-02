import 'package:flutter/material.dart';

Future<void> showMyImageModal(BuildContext context, userAvatar) async {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.black54,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return SizedBox(
        height: 1000,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userAvatar),
              radius: 200,
            ),
            Positioned(
              top: -1.0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ), //CircularAvatar
            ), //Positioned
          ], //<Widget>[]
        ), //S
      );
    },
  );
}
