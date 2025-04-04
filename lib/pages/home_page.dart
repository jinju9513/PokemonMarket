import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokemon_market/pages/card_trade_list.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/widgets/home_page/home_page_list.dart';
import 'package:pokemon_market/pages/product_add_page.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/pages/cart_page.dart'; //카트 매니저 추가가
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> products = [];

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
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ProductListScreen(
          products: products,
          onAddProduct: _addProduct,
        ),
      ),
    );
  }

  // 장바구니로 이동하는 메서드 추가
  void _navigateToCart() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: CommonAppbar(
        isDarkMode: themeManager.isDarkMode,
        toggleTheme: themeManager.toggleTheme,
        onBackPressed: null,
      ),
      body: Center(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    onPressed: _navigateToCart, // 장바구니 페이지로 이동
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
                        CupertinoPageRoute(
                            builder: (context) => CardTradeList()),
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

// 상품 목록 화면을 별도의 위젯으로 분리
class ProductListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final VoidCallback onAddProduct;

  const ProductListScreen({
    Key? key,
    required this.products,
    required this.onAddProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: CommonAppbar(
        isDarkMode: themeManager.isDarkMode,
        toggleTheme: themeManager.toggleTheme,
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: HomePageList(
        products: products,
        onAddProduct: onAddProduct,
      ),
    );
  }
}
