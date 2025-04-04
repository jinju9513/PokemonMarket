import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_text.dart';

// 공통 앱바 위젯 정의
class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode; // 다크 모드 여부
  final VoidCallback toggleTheme; // 테마 전환 콜백

  const CommonAppbar({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const CommonText(
        text: 'POKE',
        fontSize: 24,
      ),
      actions: [
        // 테마 전환 버튼
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