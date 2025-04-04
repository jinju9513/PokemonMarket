import 'package:flutter/material.dart';
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
    );
  }
}
