import 'dart:io';
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
      child: path.startsWith('assets/')
          ? Image.asset(
              path,
              width: width,
              height: height,
              fit: boxFit,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: width,
                  height: height,
                  color: Colors.grey,
                  child: const Center(child: Text('이미지 로드 실패')),
                );
              },
            )
          : Image.file(
              File(path),
              width: width,
              height: height,
              fit: boxFit,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: width,
                  height: height,
                  color: Colors.grey,
                  child: const Center(child: Text('이미지 로드 실패')),
                );
              },
            ),
    );
  }
}