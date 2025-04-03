import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_img.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:pokemon_market/widgets/product_detail_page/detail_list.dart';
import 'package:pokemon_market/theme/custom_theme.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDark ? darkTheme : lightTheme,
      child: Scaffold(
        appBar: AppBar(
          title: CommonText(
            text: 'POKE',
            fontSize: 24,
          ),
          actions: [
            IconButton(
              icon: Icon(
                isDark ? Icons.wb_sunny : Icons.nightlight_round,
                color: isDark ? Colors.yellow : Colors.blueGrey,
              ),
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(height: 30),
              CommonImg(
                  path: 'assets/2.png', height: 450, boxFit: BoxFit.fitHeight),
              SizedBox(height: 30),
              DetailList()
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 115,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: isDark ? Color(0xFF2D2D2D) : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, -5),
              ),
            ],
            border: Border(
              top: BorderSide(
                color: isDark
                    ? Colors.purple.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: '총 가격: 10,000원',
                fontSize: 18,
                textColor: isDark ? Colors.white : Colors.black87,
              ),
              ElevatedButton(
                onPressed: () {},
                child: CommonText(text: '구매하기', fontSize: 16),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
