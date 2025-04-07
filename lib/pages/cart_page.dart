import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:pokemon_market/pages/shopping_cart.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/theme/custom_theme.dart';

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
                                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
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
          borderRadius: BorderRadius.only(
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
                      // TODO 구매하기 기능추가
                    },
              child: const CommonText(text: '구매하기', fontSize: 16),
            ),
          ],
        ),
      ),
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
