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

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      appBar: CommonAppbar(
        isDarkMode: themeManager.isDarkMode,
        toggleTheme: themeManager.toggleTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: HomePageList(
          products: products,
          onAddProduct: _addProduct,
        ),
      ),
    );
  }
}
