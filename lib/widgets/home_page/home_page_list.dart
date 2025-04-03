import 'package:flutter/material.dart';
import 'package:pokemon_market/pages/product_detail_page.dart';
import 'package:pokemon_market/widgets/common_img.dart';
import 'package:pokemon_market/widgets/common_text.dart';

class HomePageList extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final VoidCallback onAddProduct;

  const HomePageList({
    super.key,
    required this.products,
    required this.onAddProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        products.isEmpty
            ? const Center(
                child: CommonText(
                  text: '등록된 상품이 없습니다.',
                  fontSize: 18,
                ),
              )
            : ListView.separated(
                itemCount: products.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                    thickness: 1,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  );
                },
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          product['imagePath'] != null
                              ? CommonImg(
                                  path: product['imagePath'] as String,
                                  height: 120,
                                  width: 120,
                                  boxFit: BoxFit.cover,
                                )
                              : const CommonImg(
                                  path: 'assets/placeholder.png',
                                  height: 120,
                                  width: 120,
                                  boxFit: BoxFit.cover,
                                ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonText(
                                      text: product['name'] ?? '이름 없음',
                                      fontSize: 24,
                                    ),
                                    const SizedBox(height: 24),
                                    CommonText(
                                      text: '가격: ${product['price'] ?? '0'}원',
                                      fontSize: 18,
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
              ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: onAddProduct,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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