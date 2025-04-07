import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:pokemon_market/pages/shopping_cart.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'dart:math' as math;

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final cartManager = Provider.of<CartManager>(context);
    final items = cartManager.items;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final textColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

    return Scaffold(
      appBar: CommonAppbar(
        isDarkMode: isDarkMode,
        toggleTheme: themeManager.toggleTheme,
        onBackPressed: null,
      ),
      body: items.isEmpty
          ? Center(
              child: CommonText(
                text: '장바구니가 비었습니다',
                fontSize: 20,
                textColor: textColor,
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Stack(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: _buildProductImage(item.imagePath),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: item.name,
                                      fontSize: 18,
                                      textColor: textColor,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        _buildQtyIconButton(
                                          icon: Icons.remove,
                                          onPressed: item.quantity > 1
                                              ? () {
                                                  cartManager.updateQuantity(
                                                    item,
                                                    item.quantity - 1,
                                                  );
                                                }
                                              : null,
                                          context: context,
                                        ),
                                        const SizedBox(width: 12),
                                        CommonText(
                                          text: '${item.quantity}',
                                          fontSize: 16,
                                          textColor: textColor,
                                        ),
                                        const SizedBox(width: 12),
                                        _buildQtyIconButton(
                                          icon: Icons.add,
                                          onPressed: () {
                                            cartManager.updateQuantity(
                                              item,
                                              item.quantity + 1,
                                            );
                                          },
                                          context: context,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    CommonText(
                                      text:
                                          '가격 : ${NumberFormat('#,###').format(item.totalPrice)}원',
                                      fontSize: 16,
                                      textColor: textColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                onPressed: () => cartManager.removeItem(item),
                                icon: const Icon(Icons.close),
                                splashRadius: 20,
                                padding: EdgeInsets.zero,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index < items.length - 1)
                      Divider(
                        thickness: 1,
                        color: isDarkMode ? Colors.white24 : Colors.black12,
                      ),
                  ],
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 130,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 7,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text:
                  '총 가격: ${NumberFormat('#,###').format(cartManager.totalPrice)}원',
              fontSize: 18,
              textColor: textColor,
            ),
            ElevatedButton(
              onPressed: items.isEmpty
                  ? null
                  : () {
                      _showPurchaseConfirmDialog(context, cartManager);
                    },
              child: const CommonText(text: '구매하기', fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _showPurchaseConfirmDialog(
      BuildContext context, CartManager cartManager) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final totalItems = cartManager.items.length;
    final totalPrice = cartManager.totalPrice;

    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      barrierLabel: 'dismiss',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: FadeTransition(
            opacity: animation,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? PokemonColors.cardDark
                      : PokemonColors.cardLight,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: isDarkMode
                        ? PokemonColors.primaryBlue.withOpacity(0.3)
                        : PokemonColors.primaryRed.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 포켓볼 아이콘 (애니메이션)
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 700),
                      tween: Tween<double>(begin: 0, end: 2 * math.pi),
                      builder: (context, value, child) {
                        return Transform.rotate(
                          angle: math.sin(value) * 0.05,
                          child: child,
                        );
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? PokemonColors.primaryBlue.withOpacity(0.1)
                              : PokemonColors.primaryRed.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/plus_logo.png',
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 제목
                    Text(
                      '구매 확인',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 내용
                    Text(
                      '$totalItems개 상품을 총 ${NumberFormat('#,###').format(totalPrice)}원에 구입하시겠습니까?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 취소 버튼
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                '취소',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // 구매하기 버튼
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              _showPurchaseCompleteDialog(context, cartManager);
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? PokemonColors.primaryBlue
                                    : PokemonColors.primaryYellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '구매하기',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPurchaseCompleteDialog(
      BuildContext context, CartManager cartManager) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      barrierLabel: 'dismiss',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: FadeTransition(
            opacity: animation,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? PokemonColors.cardDark
                      : PokemonColors.cardLight,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: isDarkMode
                        ? PokemonColors.primaryBlue.withOpacity(0.3)
                        : PokemonColors.primaryRed.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 성공 아이콘
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? PokemonColors.primaryBlue.withOpacity(0.1)
                            : PokemonColors.primaryYellow.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 50,
                        color: isDarkMode
                            ? PokemonColors.primaryBlue
                            : PokemonColors.primaryYellow,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 제목
                    Text(
                      '구매 완료',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 내용
                    Text(
                      '구매가 완료되었습니다.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 확인 버튼
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        cartManager.clearCart(); // 장바구니 비우기
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? PokemonColors.primaryBlue
                              : PokemonColors.primaryYellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '확인',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductImage(String imagePath) {
    try {
      if (imagePath.startsWith('assets/')) {
        return Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.image_not_supported, size: 40),
            );
          },
        );
      } else {
        return Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.image_not_supported, size: 40),
            );
          },
        );
      }
    } catch (e) {
      return const Center(
        child: Icon(Icons.error_outline, size: 40, color: Colors.red),
      );
    }
  }

  Widget _buildQtyIconButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required BuildContext context,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        splashRadius: 20,
        padding: EdgeInsets.zero,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
