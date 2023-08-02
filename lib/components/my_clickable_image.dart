import 'package:demo/components/my_image_modal.dart';
import 'package:flutter/material.dart';

class MyClickableImage extends StatelessWidget {
  final String userAvatar;
  const MyClickableImage({super.key, required this.userAvatar});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMyImageModal(context, userAvatar);
      },
      child: CircleAvatar(
        backgroundImage: NetworkImage(userAvatar),
        radius: 100,
      ),
    );
  }
}
