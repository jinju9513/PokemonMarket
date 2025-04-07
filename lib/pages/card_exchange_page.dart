import 'package:flutter/material.dart';
import 'package:pokemon_market/pages/select_card_page.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class CardExchangePage extends StatefulWidget {
  final String userName;
  final List<String> desiredCards;
  final List<String> ownedCards;

  const CardExchangePage({
    super.key,
    required this.userName,
    required this.desiredCards,
    required this.ownedCards,
  });

  @override
  _CardExchangePageState createState() => _CardExchangePageState();
}

class _CardExchangePageState extends State<CardExchangePage> {
  final TextEditingController _nameController = TextEditingController();
  List<String> selectedDesiredCards = [];
  List<String> selectedOwnedCards = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userName;
    selectedDesiredCards = List.from(widget.desiredCards);
    selectedOwnedCards = List.from(widget.ownedCards);
  }

  @override
  void dispose() {
    _nameController.dispose();
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
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // 타이틀 섹션
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                          Icons.sync_alt_rounded,
                          size: 28,
                          color: isDarkMode
                              ? PokemonColors.primaryYellow
                              : PokemonColors.primaryRed,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '카드 교환하기',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 정보 입력 섹션
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? PokemonColors.cardDark
                        : PokemonColors.cardLight,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 닉네임 입력
                      _buildTextField(
                        controller: _nameController,
                        labelText: '닉네임',
                        hintText: '닉네임을 입력하세요',
                        icon: Icons.person_outline_rounded,
                        isDarkMode: isDarkMode,
                      ),
                      const SizedBox(height: 24),

                      // 원하는 카드 선택
                      _buildCardSelectionField(
                        labelText: '원하는 카드',
                        cards: selectedDesiredCards,
                        onTap: () async {
                          final selectedCardList =
                              await Navigator.push<List<String>>(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SelectCardPage()),
                          );

                          if (selectedCardList != null) {
                            setState(() {
                              selectedDesiredCards.addAll(
                                  selectedCardList.where((card) =>
                                      !selectedDesiredCards.contains(card)));
                            });
                          }
                        },
                        isDarkMode: isDarkMode,
                        icon: Icons.card_giftcard_rounded,
                      ),
                      const SizedBox(height: 24),

                      // 보유 카드 선택
                      _buildCardSelectionField(
                        labelText: '보유카드',
                        cards: selectedOwnedCards,
                        onTap: () async {
                          final selectedCardList =
                              await Navigator.push<List<String>>(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SelectCardPage()),
                          );

                          if (selectedCardList != null) {
                            setState(() {
                              selectedOwnedCards.addAll(selectedCardList.where(
                                  (card) =>
                                      !selectedOwnedCards.contains(card)));
                            });
                          }
                        },
                        isDarkMode: isDarkMode,
                        icon: Icons.style_rounded,
                      ),

                      const Spacer(),

                      // 등록 버튼
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, {
                              'userName': _nameController.text,
                              'desiredCards': selectedDesiredCards,
                              'ownedCards': selectedOwnedCards,
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDarkMode
                                ? PokemonColors.primaryBlue
                                : PokemonColors.primaryYellow,
                            foregroundColor:
                                isDarkMode ? Colors.white : Colors.black,
                            elevation: 3,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            '등록하기',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    required bool isDarkMode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black12 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode
              ? Colors.grey.withOpacity(0.3)
              : Colors.grey.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 16,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: isDarkMode
                ? PokemonColors.primaryYellow
                : PokemonColors.primaryRed,
          ),
          labelStyle: TextStyle(
            color: isDarkMode ? Colors.grey : Colors.grey[700],
          ),
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode
                  ? PokemonColors.primaryYellow
                  : PokemonColors.primaryRed,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildCardSelectionField({
    required String labelText,
    required List<String> cards,
    required VoidCallback onTap,
    required bool isDarkMode,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 라벨
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: isDarkMode
                    ? PokemonColors.primaryYellow
                    : PokemonColors.primaryRed,
              ),
              const SizedBox(width: 8),
              Text(
                labelText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),

        // 카드 선택 필드
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.black12 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDarkMode
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  '카드 선택',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.grey : Colors.grey[700],
                  ),
                ),
                const Spacer(),
                if (cards.isEmpty)
                  Icon(
                    Icons.add_circle_outline,
                    color: isDarkMode
                        ? PokemonColors.primaryYellow
                        : PokemonColors.primaryRed,
                  )
                else
                  Row(
                    children: [
                      Text(
                        '${cards.length}장 선택됨',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? PokemonColors.primaryBlue.withOpacity(0.2)
                              : PokemonColors.primaryRed.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isDarkMode
                                ? PokemonColors.primaryBlue.withOpacity(0.3)
                                : PokemonColors.primaryRed.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            ...cards.take(3).map(
                                  (card) => Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Image.asset(card,
                                        width: 30, height: 30),
                                  ),
                                ),
                            if (cards.length > 3)
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? PokemonColors.primaryBlue
                                          .withOpacity(0.5)
                                      : PokemonColors.primaryRed
                                          .withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '+${cards.length - 3}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
