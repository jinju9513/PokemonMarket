import 'package:flutter/material.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'dart:math' as math;

class SelectCardPage extends StatefulWidget {
  const SelectCardPage({super.key});

  @override
  State<SelectCardPage> createState() => _SelectCardPageState();
}

class _SelectCardPageState extends State<SelectCardPage>
    with SingleTickerProviderStateMixin {
  final List<String> selectedCards = [];
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

    final List<String> cardAssets =
        List.generate(20, (index) => 'assets/${index + 1}.png');

    return Scaffold(
      appBar: CommonAppbar(
        isDarkMode: isDarkMode,
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
        child: Column(
          children: [
            // 타이틀 섹션
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 16),
              child: Center(
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
                          Icons.grid_view_rounded,
                          size: 28,
                          color: isDarkMode
                              ? PokemonColors.primaryYellow
                              : PokemonColors.primaryRed,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '카드 선택',
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
            ),

            // 선택된 카드 카운터
            if (selectedCards.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? PokemonColors.primaryBlue.withOpacity(0.15)
                      : PokemonColors.primaryRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: isDarkMode
                          ? PokemonColors.primaryYellow
                          : PokemonColors.primaryRed,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${selectedCards.length}장 선택됨',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

            // 카드 그리드
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
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
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: cardAssets.length,
                  itemBuilder: (context, index) {
                    final card = cardAssets[index];
                    final isSelected = selectedCards.contains(card);

                    return AnimatedScale(
                      scale: isSelected ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 150),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedCards.remove(card);
                            } else {
                              selectedCards.add(card);
                            }
                          });
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // 카드 컨테이너
                            Padding(
                              padding: const EdgeInsets.all(3.2),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.black.withOpacity(0.3)
                                      : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? (isDarkMode
                                            ? PokemonColors.primaryYellow
                                            : PokemonColors.primaryRed)
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: (isDarkMode
                                                    ? PokemonColors
                                                        .primaryYellow
                                                    : PokemonColors.primaryRed)
                                                .withOpacity(0.5),
                                            blurRadius: 8,
                                            spreadRadius: -2,
                                          ),
                                        ]
                                      : null,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    card,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            // 선택 표시
                            if (isSelected)
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? PokemonColors.primaryYellow
                                        : PokemonColors.primaryRed,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // 등록 버튼
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final pulseValue = 1.0 +
                      (selectedCards.isNotEmpty
                          ? (_animationController.value * 0.03)
                          : 0.0);
                  return Transform.scale(
                    scale: pulseValue,
                    child: child,
                  );
                },
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode
                        ? PokemonColors.primaryBlue
                        : PokemonColors.primaryYellow,
                    foregroundColor: isDarkMode ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: selectedCards.isNotEmpty ? 4 : 0,
                    disabledBackgroundColor:
                        isDarkMode ? Colors.grey[700] : Colors.grey[300],
                    disabledForegroundColor:
                        isDarkMode ? Colors.grey[500] : Colors.grey[500],
                  ),
                  onPressed: selectedCards.isNotEmpty
                      ? () {
                          Navigator.pop(context, selectedCards);
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '카드 등록하기',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
