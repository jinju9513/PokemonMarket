import 'package:flutter/material.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/widgets/card_trade_list/card_trade_detail_list.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_market/pages/card_exchange_page.dart'; // 카드 교환 등록 페이지

class CardTradeList extends StatefulWidget {
  const CardTradeList({super.key});

  @override
  State<CardTradeList> createState() => _CardTradeListState();
}

class _CardTradeListState extends State<CardTradeList> {
  // 앱이 실행 중일 때만 데이터를 유지하는 정적(static) 리스트
  // 페이지를 벗어나도 데이터는 메모리에 유지됨
  static final List<Map<String, dynamic>> _cardTradeData = [];

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: CommonAppbar(
        isDarkMode: themeManager.isDarkMode,
        toggleTheme: themeManager.toggleTheme,
      ),
      body: Stack(
        children: [
          // 등록된 교환카드가 없을 때 보여줄 화면
          if (_cardTradeData.isEmpty)
            _buildEmptyState()
          else
            // 교환카드 리스트 표시
            ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _cardTradeData.length,
              itemBuilder: (context, index) {
                final data = _cardTradeData[index];
                return CardTradeDetailList(
                  userName: data['userName'],
                  desiredCards: List<String>.from(data['desiredCards']),
                  ownedCards: List<String>.from(data['ownedCards']),
                );
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 20),
            ),

          // 카드 추가 버튼
          _buildFAB(),
        ],
      ),
    );
  }

  // 카드가 없을 때 보여줄 빈 화면 UI
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/empty_pokemon.png', width: 120, height: 120),
          const SizedBox(height: 16),
          CommonText(
            text: '등록된 교환카드가 없습니다',
            fontSize: 18,
            textColor: Theme.of(context).textTheme.bodyMedium!.color,
          ),
          const SizedBox(height: 8),
          CommonText(
            text: '교환할 카드를 등록해보세요!',
            fontSize: 14,
            textColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  // 카드 등록 페이지로 이동하는 FloatingActionButton
  Widget _buildFAB() {
    return Positioned(
      bottom: 56,
      right: 36,
      child: FloatingActionButton(
        onPressed: () async {
          // 카드 등록 페이지로 이동
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

          // 등록 결과를 받으면 리스트에 추가
          if (result != null) {
            setState(() {
              _cardTradeData.add(result); // 정적 리스트에 저장됨
            });
          }
        },
        backgroundColor: PokemonColors.primaryRed,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Image.asset('assets/plus_logo.png'),
      ),
    );
  }
}
