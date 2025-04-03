import 'package:flutter/material.dart';

class CommonImg extends StatelessWidget {
  final String path;
  final double height;
  final double width;

  final BoxFit boxFit;

  const CommonImg({
    super.key,
    required this.path,
    required this.height,
    this.width = double.infinity,
    required this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        path,
        width: width,
        height: height,
        fit: boxFit,
      ),
    );
  }
}
