import 'package:flutter/material.dart';
import 'package:pokemon_market/pages/product_detail_page.dart';
import 'package:pokemon_market/widgets/common_img.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/providers/like_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// 홈페이지 상품 목록 위젯 
class HomePageList extends StatefulWidget {
  final List<Map<String, dynamic>> products; // 상품 목록
  final VoidCallback onAddProduct; // 상품 추가 콜백

  const HomePageList({
    super.key,
    required this.products,
    required this.onAddProduct,
  });

  @override
  State<HomePageList> createState() => _HomePageListState();
}

class _HomePageListState extends State<HomePageList> {
  // 등록 시간 포맷팅
  String formatCreatedAt(String? createdAt) {
    if (createdAt == null) return '알 수 없음';
    try {
      final dateTime = DateTime.parse(createdAt);
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    } catch (e) {
      return '알 수 없음';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 상품 목록이 비어있을 경우 메시지 표시
        widget.products.isEmpty
            ? Center(
                child: CommonText(
                  text: '등록된 상품이 없습니다.',
                  fontSize: 18,
                  textColor: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16), // 목록 패딩
                itemCount: widget.products.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.withOpacity(0.3), // 구분선 색상
                ),
                itemBuilder: (context, index) {
                  final product = widget.products[index];
                  final productId = product['id']?.toString() ?? index.toString(); // 상품 ID (없으면 인덱스 사용)

                  return Consumer<LikeProvider>(
                    builder: (context, likeProvider, child) {
                      final isLiked = likeProvider.isLiked(productId);
                      final likeCount = likeProvider.getLikeCount(productId);

                      return GestureDetector(
                        onTap: () {
                          // 상품 클릭 시 상세 페이지로 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(product: product),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 상품 이미지 (썸네일)
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
                              // 상품 정보
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 상품명
                                    CommonText(
                                      text: product['name'] ?? '이름 없음',
                                      fontSize: 16,
                                      textColor: Theme.of(context).textTheme.bodyLarge!.color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 4),
                                    // 사용자 위치 및 등록 시간 (위치 정보 제거) 현재는필요없음 
                                    CommonText(
                                      text: '포켓몬 센터 • ${formatCreatedAt(product['createdAt'])}',
                                      fontSize: 14,
                                      textColor: Colors.grey,
                                    ),
                                    const SizedBox(height: 4),
                                    // 가격
                                    CommonText(
                                      text: '${product['price'] ?? '0'}원',
                                      fontSize: 16,
                                      textColor: Theme.of(context).textTheme.bodyLarge!.color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                              // 좋아요 (하트 아이콘 + 수)
                              GestureDetector(
                                onTap: () {
                                  // 좋아요 토글
                                  likeProvider.toggleLike(productId);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      isLiked ? Icons.favorite : Icons.favorite_border,
                                      color: isLiked ? Colors.red : Colors.grey,
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
                        ),
                      );
                    },
                  );
                },
              ),
        // 상품 추가 버튼 (포켓몬 테마 빨간색)
        Positioned(
          bottom: 16,
          right: 16,
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