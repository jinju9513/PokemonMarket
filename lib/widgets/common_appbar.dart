import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_text.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const CommonAppbar({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true, // 타이틀을 가운데 정렬로 설정
      title: const CommonText(
        text: 'POKE',
        fontSize: 24,
      ),
      actions: [
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}