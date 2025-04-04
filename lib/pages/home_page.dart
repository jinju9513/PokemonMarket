import 'package:flutter/material.dart';
import 'package:pokemon_market/pages/card_trade_list.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/widgets/home_page/home_page_list.dart';
import 'package:pokemon_market/pages/product_add_page.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> products = [];
  bool _showProductList = false; // 상품 목록 화면 표시 여부
  // 상품 추가 기능
  void _addProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductAddPage()),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        products.add(result);
      });
    }
  }

  // 상품 목록 화면으로 전환
  void _showProductListScreen() {
    setState(() {
      _showProductList = true;
    });
  }

  // 초기 화면으로 돌아가기
  void _goBackToInitialScreen() {
    setState(() {
      _showProductList = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      appBar: CommonAppbar(
        isDarkMode: themeManager.isDarkMode,
        toggleTheme: themeManager.toggleTheme,
        // 상품 목록 화면일 때만 뒤로 가기 버튼 표시
        onBackPressed: _showProductList ? _goBackToInitialScreen : null,
      ),
      body: _showProductList
          ? HomePageList(
              products: products,
              onAddProduct: _addProduct,
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 피카츄 로고 이미지 추가 (애셋에서 불러오기)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/pika.png', // 애셋 경로
                      height: 100,
                      width: 100,
                    ),
                  ),
                  // 버튼 3개 (상품목록, 장바구니, 카드교환)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        // 상품목록 버튼
                        ElevatedButton(
                          onPressed: _showProductListScreen, // 상품 목록 화면으로 전환
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            minimumSize: const Size(200, 50), // 버튼 크기 조정
                          ),
                          child: const Text(
                            '상품목록',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 장바구니 버튼
                        ElevatedButton(
                          onPressed: () {
                            // TODO: 장바구니 페이지로 이동 (아직 없음)
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => CartPage()), // 장바구니 페이지 추가 예정
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            minimumSize: const Size(200, 50), // 버튼 크기 조정
                          ),
                          child: const Text(
                            '장바구니',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 카드교환 버튼
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CardTradeList()), // 카드교환 페이지 추가 예정
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            minimumSize: const Size(200, 50), // 버튼 크기 조정
                          ),
                          child: const Text(
                            '카드교환',
                            style: TextStyle(fontSize: 16, color: Colors.black),
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
}
