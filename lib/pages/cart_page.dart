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

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
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
    final cartManager = Provider.of<CartManager>(context);
    final items = cartManager.items;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CommonAppbar(
        isDarkMode: isDarkMode,
        toggleTheme: themeManager.toggleTheme,
        onBackPressed: null,
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
              'assets/light_pokeballs_bg.png',
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
                          Icons.shopping_cart_rounded,
                          size: 28,
                          color: isDarkMode
                              ? PokemonColors.primaryYellow
                              : PokemonColors.primaryRed,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '장바구니',
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

            // 장바구니 내용 또는 빈 장바구니 메시지
            Expanded(
              child: items.isEmpty
                  ? _buildEmptyCart(isDarkMode)
                  : _buildCartItemList(items, cartManager, isDarkMode),
            ),
          ],
        ),
      ),
      bottomNavigationBar: items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              height: 120,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? PokemonColors.cardDark
                    : PokemonColors.cardLight,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
                border: Border.all(
                  color: isDarkMode
                      ? PokemonColors.primaryBlue.withOpacity(0.2)
                      : PokemonColors.primaryRed.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '총 가격',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₩${NumberFormat('#,###').format(cartManager.totalPrice)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: items.isEmpty
                        ? null
                        : () {
                            _showPurchaseConfirmDialog(context, cartManager);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? PokemonColors.primaryBlue
                          : PokemonColors.primaryYellow,
                      foregroundColor: isDarkMode ? Colors.white : Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 20,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '구매하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyCart(bool isDarkMode) {
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
          width: 280,
          padding: const EdgeInsets.all(30),
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
              Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: isDarkMode
                    ? PokemonColors.primaryYellow.withOpacity(0.7)
                    : PokemonColors.primaryRed.withOpacity(0.7),
              ),
              const SizedBox(height: 24),
              Text(
                '장바구니가 비었습니다',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '포켓몬 상품을 담아보세요!',
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: isDarkMode
                      ? PokemonColors.primaryYellow
                      : PokemonColors.primaryRed,
                ),
                label: Text(
                  '상품 쇼핑하기',
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

  Widget _buildCartItemList(
      List<CartItem> items, CartManager cartManager, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildCartItem(item, cartManager, isDarkMode, context);
        },
      ),
    );
  }

  Widget _buildCartItem(CartItem item, CartManager cartManager, bool isDarkMode,
      BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? PokemonColors.cardDark : PokemonColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isDarkMode
              ? PokemonColors.primaryBlue.withOpacity(0.2)
              : PokemonColors.primaryRed.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상품 이미지
          Container(
            width: 100,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDarkMode
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.3),
                width: 1,
              ),
              color: isDarkMode ? Colors.black26 : Colors.grey[100],
            ),
            clipBehavior: Clip.hardEdge,
            child: _buildProductImage(item.imagePath),
          ),
          const SizedBox(width: 16),

          // 상품 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상품명 및 삭제 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildRemoveButton(cartManager, item, isDarkMode),
                  ],
                ),
                const SizedBox(height: 12),

                // 수량 조절 버튼
                Row(
                  children: [
                    _buildQtyIconButton(
                      icon: Icons.remove,
                      onPressed: item.quantity > 1
                          ? () => cartManager.updateQuantity(
                                item,
                                item.quantity - 1,
                              )
                          : null,
                      isDarkMode: isDarkMode,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.black12 : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.grey.withOpacity(0.3)
                              : Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        '${item.quantity}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    _buildQtyIconButton(
                      icon: Icons.add,
                      onPressed: () {
                        // 현재 수량이 최대 수량보다 작을 때만 증가 가능
                        if (item.quantity < item.maxQuantity) {
                          cartManager.updateQuantity(
                            item,
                            item.quantity + 1,
                          );
                        } else {
                          // 재고 부족 메시지 표시
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('최대 구매 가능 수량은 ${item.maxQuantity}개입니다.'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 가격 정보
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '₩${NumberFormat('#,###').format(item.totalPrice)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode
                            ? PokemonColors.primaryYellow
                            : PokemonColors.primaryRed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemoveButton(
      CartManager cartManager, CartItem item, bool isDarkMode) {
    return InkWell(
      onTap: () => cartManager.removeItem(item),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black26 : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDarkMode
                ? Colors.grey.withOpacity(0.3)
                : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Icon(
          Icons.close,
          size: 16,
          color: isDarkMode ? Colors.white70 : Colors.black54,
        ),
      ),
    );
  }

  Widget _buildQtyIconButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black26 : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDarkMode
                ? Colors.grey.withOpacity(0.3)
                : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: onPressed == null
              ? (isDarkMode ? Colors.grey[600] : Colors.grey[400])
              : (isDarkMode ? Colors.white : Colors.black),
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
}
