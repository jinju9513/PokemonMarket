import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_img.dart';
import 'package:pokemon_market/widgets/common_text.dart';

class DetailList extends StatelessWidget {
  final Map<String, dynamic> product;

  const DetailList({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 이미지
          AspectRatio(
            aspectRatio: 1,
            child: product['imagePath'] != null
                ? CommonImg(
                    path: product['imagePath'] as String,
                    height: 350,
                    width: double.infinity,
                    boxFit: BoxFit.contain,
                  )
                : const CommonImg(
                    path: 'assets/placeholder.png',
                    height: 350,
                    width: double.infinity,
                    boxFit: BoxFit.contain,
                  ),
          ),
          const SizedBox(height: 20),
          // 상품명과 남은 갯수 (상단)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: product['name'] ?? '이름 없음',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              CommonText(
                text: '남은 갯수 : ${product['quantity'] ?? 0}개',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 15),
          // 상품 가격 (중단)
          CommonText(
            text: '${product['price'] ?? 0}원',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          // 상세 내용 (하단)
          CommonText(
            text: product['description'] ?? '설명 없음',
            fontSize: 22,
            fontWeight: FontWeight.normal,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}