import 'package:flutter/material.dart';

class MyTextLabel extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final VoidCallback? onClick;

  const MyTextLabel({
    super.key,
    required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Text(
        text,
        style: TextStyle(fontSize: size, fontWeight: fontWeight, color: color),
      ),
    );
  }
}
