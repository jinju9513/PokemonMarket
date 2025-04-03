import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_text.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: 'POKE',
          fontSize: 24,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/1.png',
                width: double.infinity,
                height: 450,
                fit: BoxFit.fitHeight,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: '상품명',
                          fontSize: 20,
                        ),
                        CommonText(
                          text: '리자몽',
                          fontSize: 24,
                        ),
                      ],
                    ),
                    CommonText(text: '10,000원'),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
