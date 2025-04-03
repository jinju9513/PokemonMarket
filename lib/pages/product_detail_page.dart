import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_img.dart';
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
            CommonImg(
                path: 'assets/2.png', height: 450, boxFit: BoxFit.fitHeight),
            SizedBox(height: 30),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                    CommonText(
                      text: '10,000원',
                      fontSize: 20,
                    ),
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
