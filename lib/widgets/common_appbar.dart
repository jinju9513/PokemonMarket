import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_text.dart';

// 공통 앱바 위젯 정의
class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode; // 다크 모드 여부
  final VoidCallback toggleTheme; // 테마 전환 콜백
  final VoidCallback? onBackPressed; // 뒤로 가기 콜백 

  const CommonAppbar({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
    this.onBackPressed, // 뒤로 가기 콜백 추가
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      // 뒤로 가기 버튼 추가 (onBackPressed가 있을 때만 표시)
      leading: onBackPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back), // 뒤로 가기 화살표 아이콘
              onPressed: onBackPressed,
            )
          : null,
      title: const CommonText(
        text: 'POKE',
        fontSize: 24,
      ),
      actions: [
        // 테마 전환 버튼 (다크/라이트 모드 전환)
        IconButton(
          icon: Icon(
            isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
            color: isDarkMode ? Colors.yellow : Colors.blueGrey,
          ),
          onPressed: toggleTheme,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // 앱바 높이 설정
}