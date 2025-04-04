import 'package:flutter/material.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/widgets/card_trade_list/card_trade_detail_list.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:provider/provider.dart';

class CardTradeList extends StatefulWidget {

  @override
  State<CardTradeList> createState() => _CardTradeListState();
}

final List<Map<String, dynamic>> cardTradeData = [
    {
      'userName': '피카츄짱짱123',
      'desiredCards': ['assets/1.png', 'assets/2.png'],
      'ownedCards': ['assets/1.png', 'assets/2.png'],
    },
    {
      'userName': '꼬부기최고',
      'desiredCards': ['assets/1.png'],
      'ownedCards': ['assets/1.png', 'assets/2.png'],
    },
    {
      'userName': '이상해씨99',
      'desiredCards': ['assets/1.png'],
      'ownedCards': ['assets/1.png'],
    },
  ];

class _CardTradeListState extends State<CardTradeList> {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      appBar: CommonAppbar(
          isDarkMode: themeManager.isDarkMode,
          toggleTheme: themeManager.toggleTheme),
     body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: cardTradeData.length,
        itemBuilder: (context, index) {
          final data = cardTradeData[index];
          return CardTradeDetailList(
            userName: data['userName'],
            desiredCards: List<String>.from(data['desiredCards']),
            ownedCards: List<String>.from(data['ownedCards']),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
      ),
    );
  }
}
