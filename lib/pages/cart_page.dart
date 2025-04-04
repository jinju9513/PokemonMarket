import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:pokemon_market/pages/shopping_cart.dart';
import 'package:pokemon_market/widgets/common_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartManager = Provider.of<CartManager>(context);
    final items = cartManager.items;

    return Scaffold(
      appBar: AppBar(
        title: const CommonText(text: 'poke', fontSize: 24),
        centerTitle: true,
      ),
      body: items.isEmpty
          ? const Center(
              child: CommonText(text: '장바구니가 비었습니다', fontSize: 20),
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
                              // 상품 이미지
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: _buildProductImage(item.imagePath),
                              ),
                              const SizedBox(width: 16),
                              // 상품 정보 + 수량 조절
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(text: item.name, fontSize: 18),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        _buildQtyButton(
                                            '-',
                                            item.quantity > 1
                                                ? () {
                                                    cartManager.updateQuantity(
                                                      item,
                                                      item.quantity - 1,
                                                    );
                                                  }
                                                : null),
                                        _buildQtyButton(
                                            '${item.quantity}', null),
                                        _buildQtyButton('+', () {
                                          cartManager.updateQuantity(
                                            item,
                                            item.quantity + 1,
                                          );
                                        }),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    CommonText(
                                      text:
                                          '가격 : ${NumberFormat('#,###').format(item.totalPrice)}원',
                                      fontSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // 삭제 버튼
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              onPressed: () => cartManager.removeItem(item),
                              icon: const Icon(Icons.close),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const CircleBorder(),
                                side: const BorderSide(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index < items.length - 1) const Divider(thickness: 1),
                  ],
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text:
                  '총 가격: ${NumberFormat('#,###').format(cartManager.totalPrice)}원',
              fontSize: 18,
            ),
            ElevatedButton(
              onPressed: items.isEmpty
                  ? null
                  : () {
                      // TODO 구매하기 기능추가
                      // 구매하기 동작은 나중에
                    },
              child: const CommonText(text: '구매하기', fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // 제품 이미지 로드 메서드
  Widget _buildProductImage(String imagePath) {
    try {
      // 이미지 경로가 'assets/'로 시작하면 Asset 이미지로 간주
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
      }
      // 그렇지 않으면 File 이미지로 간주
      else {
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

  Widget _buildQtyButton(String label, VoidCallback? onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
        color:
            onPressed == null && label == '-' ? Colors.grey[300] : Colors.white,
      ),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Center(
          child: CommonText(text: label, fontSize: 16),
        ),
      ),
    );
  }
}
