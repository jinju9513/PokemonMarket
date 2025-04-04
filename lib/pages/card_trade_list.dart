import 'package:flutter/material.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/widgets/card_trade_list/card_trade_detail_list.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_market/pages/card_exchange_page.dart'; //chandoli21

class CardTradeList extends StatefulWidget {
  @override
  State<CardTradeList> createState() => _CardTradeListState();
}

//카드 더미
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
      body: Stack(
        children: [
          // 카드 리스트
          ListView.separated(
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

          // FloatingActionButton 위에 Positioned 위젯
          Positioned(
            bottom: 56,
            right: 36,
            child: FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push<Map<String, dynamic>>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CardExchangePage(
                      userName: '',
                      desiredCards: [],
                      ownedCards: [],
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    cardTradeData.add(result);
                  });
                }
              },

              backgroundColor: PokemonColors.primaryRed, // 빨간색
              foregroundColor: Colors.white, // 아이콘 흰색
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(Icons.add, size: 30),
              // 테마에서 색상 적용되므로 따로 설정할 필요 없음!
            ),
          ),
        ],
      ),
    );
  }
}
