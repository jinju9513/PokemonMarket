import 'package:flutter/material.dart';

class CardTradeDetailList extends StatelessWidget {
  final String userName;
  final List<String> desiredCards;
  final List<String> ownedCards;

  const CardTradeDetailList({
    super.key,
    required this.userName,
    required this.desiredCards,
    required this.ownedCards,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 현재 테마 접근

    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor, // 테마 기반 카드 색상
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: theme.textTheme.bodyLarge, // 유저 이름
          ),
          const SizedBox(height: 12),
          Text(
            '원하는 카드',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          _buildCardRow(desiredCards),
          const SizedBox(height: 16),
          Text(
            '보유카드',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          _buildCardRow(ownedCards),
        ],
      ),
    );
  }

  Widget _buildCardRow(List<String> cardPaths) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cardPaths.map((path) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(path, width: 60),
          );
        }).toList(),
      ),
    );
  }
}
