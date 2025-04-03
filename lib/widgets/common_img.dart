import 'package:flutter/material.dart';

class CommonImg extends StatelessWidget {
  final String path;
  final double height;
  final BoxFit boxFit;

  const CommonImg({
    super.key,
    required this.path,
    required this.height,
    required this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        'assets/1.png',
        width: double.infinity,
        height: 450,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
