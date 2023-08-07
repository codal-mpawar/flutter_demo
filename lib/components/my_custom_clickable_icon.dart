import 'package:flutter/material.dart';

class CustomClickableIcon extends StatelessWidget {
  const CustomClickableIcon({super.key, this.icon, this.onPressedIcon});
  final Icon? icon;
  final VoidCallback? onPressedIcon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon!,
      onPressed: onPressedIcon!,
    );
  }
}
