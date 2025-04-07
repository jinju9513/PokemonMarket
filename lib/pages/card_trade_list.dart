import 'package:flutter/material.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/widgets/card_trade_list/card_trade_detail_list.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_market/pages/card_exchange_page.dart'; // 카드 교환 등록 페이지
import 'dart:math' as math;

class CardTradeList extends StatefulWidget {
  const CardTradeList({super.key});

  @override
  State<CardTradeList> createState() => _CardTradeListState();
}

class _CardTradeListState extends State<CardTradeList>
    with SingleTickerProviderStateMixin {
  // 앱이 실행 중일 때만 데이터를 유지하는 정적(static) 리스트
  // 페이지를 벗어나도 데이터는 메모리에 유지됨
  static final List<Map<String, dynamic>> _cardTradeData = [];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    return Scaffold(
      appBar: CommonAppbar(
        isDarkMode: themeManager.isDarkMode,
        toggleTheme: themeManager.toggleTheme,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
                    PokemonColors.backgroundDark,
                    PokemonColors.backgroundDark.withOpacity(0.8),
                  ]
                : [
                    PokemonColors.backgroundLight,
                    Colors.white,
                  ],
          ),
          image: DecorationImage(
            image: AssetImage(
              isDarkMode
                  ? 'assets/light_pokeballs_bg.png'
                  : 'assets/light_pokeballs_bg.png',
            ),
            fit: BoxFit.cover,
            opacity: 0.03,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  // 타이틀 섹션
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? PokemonColors.primaryBlue.withOpacity(0.2)
                            : PokemonColors.primaryRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDarkMode
                              ? PokemonColors.primaryBlue.withOpacity(0.3)
                              : PokemonColors.primaryRed.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 700),
                            tween: Tween<double>(begin: 0, end: 2 * math.pi),
                            builder: (context, value, child) {
                              return Transform.rotate(
                                angle: math.sin(value) * 0.05,
                                child: child,
                              );
                            },
                            child: Icon(
                              Icons.card_membership_rounded,
                              size: 28,
                              color: isDarkMode
                                  ? PokemonColors.primaryYellow
                                  : PokemonColors.primaryRed,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '포켓몬 카드 교환',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 카드 리스트
                  Expanded(
                    child: _cardTradeData.isEmpty
                        ? _buildEmptyState()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ListView.separated(
                              padding: const EdgeInsets.only(bottom: 100),
                              itemCount: _cardTradeData.length,
                              itemBuilder: (context, index) {
                                final data = _cardTradeData[index];
                                return _buildCardItem(
                                    data, isDarkMode, context);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                            ),
                          ),
                  ),
                ],
              ),
            ),

            // 카드 추가 버튼
            _buildFAB(isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem(
      Map<String, dynamic> data, bool isDarkMode, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? PokemonColors.cardDark : PokemonColors.cardLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isDarkMode
              ? PokemonColors.primaryBlue.withOpacity(0.2)
              : PokemonColors.primaryRed.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: CardTradeDetailList(
        userName: data['userName'],
        desiredCards: List<String>.from(data['desiredCards']),
        ownedCards: List<String>.from(data['ownedCards']),
      ),
    );
  }

  // 카드가 없을 때 보여줄 빈 화면 UI
  Widget _buildEmptyState() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_animationController.value * 0.05),
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color:
                isDarkMode ? PokemonColors.cardDark : PokemonColors.cardLight,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: isDarkMode
                  ? PokemonColors.primaryBlue.withOpacity(0.2)
                  : PokemonColors.primaryRed.withOpacity(0.2),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/empty_pokemon.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 24),
              Text(
                '등록된 교환카드가 없습니다',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '교환할 카드를 등록해보세요!',
                style: TextStyle(
                  fontSize: 15,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () => _navigateToCardExchange(),
                icon: Icon(
                  Icons.add_circle_outline,
                  color: isDarkMode
                      ? PokemonColors.primaryYellow
                      : PokemonColors.primaryRed,
                ),
                label: Text(
                  '카드 등록하기',
                  style: TextStyle(
                    color: isDarkMode
                        ? PokemonColors.primaryYellow
                        : PokemonColors.primaryRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  side: BorderSide(
                    color: isDarkMode
                        ? PokemonColors.primaryYellow
                        : PokemonColors.primaryRed,
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 카드 등록 페이지로 이동하는 FloatingActionButton
  Widget _buildFAB(bool isDarkMode) {
    return Positioned(
      bottom: 32,
      right: 32,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_animationController.value * 0.1),
            child: child,
          );
        },
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [
                      PokemonColors.primaryBlue,
                      PokemonColors.primaryBlue.withOpacity(0.8),
                    ]
                  : [
                      PokemonColors.primaryRed,
                      PokemonColors.primaryRed.withOpacity(0.8),
                    ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? PokemonColors.primaryBlue.withOpacity(0.4)
                    : PokemonColors.primaryRed.withOpacity(0.4),
                blurRadius: 12,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _navigateToCardExchange,
              customBorder: const CircleBorder(),
              splashColor: Colors.white24,
              highlightColor: Colors.white10,
              child: Center(
                child: Image.asset(
                  'assets/plus_logo.png',
                  color: Colors.white,
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToCardExchange() async {
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
  }
}
