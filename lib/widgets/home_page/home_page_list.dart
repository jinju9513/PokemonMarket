import 'package:flutter/material.dart';
import 'package:pokemon_market/pages/product_detail_page.dart';
import 'package:pokemon_market/widgets/common_img.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/providers/like_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePageList extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final VoidCallback onAddProduct;

  const HomePageList({
    super.key,
    required this.products,
    required this.onAddProduct,
  });

  @override
  State<HomePageList> createState() => _HomePageListState();
}

class _HomePageListState extends State<HomePageList> {
  String formatCreatedAt(String? createdAt) {
    if (createdAt == null) return '알 수 없음';
    try {
      final dateTime = DateTime.parse(createdAt);
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    } catch (e) {
      return '알 수 없음';
    }
  }

  // 가격 포맷팅 함수
  String formatPrice(dynamic price) {
    int priceValue;
    if (price is String) {
      priceValue = int.tryParse(price.replaceAll(',', '')) ?? 0;
    } else if (price is int) {
      priceValue = price;
    } else {
      priceValue = 0;
    }
    return NumberFormat('#,###').format(priceValue);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.products.isEmpty
            ? Center(
                child: CommonText(
                  text: '등록된 상품이 없습니다.',
                  fontSize: 18,
                  textColor: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: widget.products.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  thickness: 1,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[200],
                ),
                itemBuilder: (context, index) {
                  final product = widget.products[index];
                  final productId =
                      product['id']?.toString() ?? index.toString();

                  return Consumer<LikeProvider>(
                    builder: (context, likeProvider, child) {
                      final isLiked = likeProvider.isLiked(productId);
                      final likeCount = likeProvider.getLikeCount(productId);

                      return GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(product: product),
                            ),
                          );

                          if (result != null &&
                              result is Map<String, dynamic>) {
                            if (result['deleted'] == true) {
                              setState(() {
                                widget.products.removeAt(index);
                              });
                            } else {
                              setState(() {
                                widget.products[index] = result;
                              });
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: product['imagePath'] != null
                                    ? CommonImg(
                                        path: product['imagePath'] as String,
                                        height: 80,
                                        width: 80,
                                        boxFit: BoxFit.cover,
                                      )
                                    : const CommonImg(
                                        path: 'assets/placeholder.png',
                                        height: 80,
                                        width: 80,
                                        boxFit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: product['name'] ?? '이름 없음',
                                      fontSize: 16,
                                      textColor: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 4),
                                    CommonText(
                                      text:
                                          '포켓몬 센터 • ${formatCreatedAt(product['createdAt'])}',
                                      fontSize: 14,
                                      textColor: Colors.grey,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText(
                                          text:
                                              '${formatPrice(product['price'])}원',
                                          fontSize: 16,
                                          textColor: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            likeProvider.toggleLike(productId);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                isLiked
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: isLiked
                                                    ? Colors.red
                                                    : Colors.grey,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 4),
                                              CommonText(
                                                text: '$likeCount',
                                                fontSize: 14,
                                                textColor: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
        Positioned(
          //FIXME: 위치조정
          bottom: 56,
          right: 26,
          child: FloatingActionButton(
            onPressed: widget.onAddProduct,
            backgroundColor: PokemonColors.primaryRed,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ],
    );
  }
}
