import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color textColor;

  const CommonText({
    super.key,
    required this.text,
    this.fontSize,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: textColor,
      ),
    );
  }
}
