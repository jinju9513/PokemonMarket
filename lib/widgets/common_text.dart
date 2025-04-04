import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 공통 텍스트 위젯
class CommonText extends StatelessWidget {
  final String text; // 텍스트 내용
  final double fontSize; // 폰트 크기
  final Color? textColor; // 텍스트 색상 (기본값: 테마 색상)
  final FontWeight? fontWeight; // 폰트 두께

  const CommonText({
    super.key,
    required this.text,
    required this.fontSize,
    this.textColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: textColor ?? Theme.of(context).textTheme.bodyMedium!.color,
        fontWeight: fontWeight,
      ),
    );
  }
}