import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_img.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:intl/intl.dart';

class DetailList extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DetailList({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  // 가격 포맷팅 함수
  String formatPrice(dynamic price) {
    int priceValue;
    if (price is String) {
      priceValue = int.tryParse(price.replaceAll(',', '')) ?? 0;
    } else if (price is int) {
      priceValue = price;
    } else {
      priceValue = 0;
    }
    return NumberFormat('#,###').format(priceValue);
  }

  // 전체 화면 이미지 보기 다이얼로그
  void _showFullScreenImage(BuildContext context, String? imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  panEnabled: true,
                  scaleEnabled: true,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: imagePath != null
                      ? CommonImg(
                          path: imagePath,
                          width: double.infinity,
                          height: double.infinity,
                          boxFit: BoxFit.contain,
                        )
                      : const CommonImg(
                          path: 'assets/placeholder.png',
                          width: double.infinity,
                          height: double.infinity,
                          boxFit: BoxFit.contain,
                        ),
              ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 앱바와 상단 이미지 사이 간격 추가
          const SizedBox(height: 20), // 상단 여백 추가
          // 상단 이미지 (탭 시 전체 화면으로 보기)
          GestureDetector(
            onTap: () => _showFullScreenImage(context, product['imagePath']),
            child: AspectRatio(
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
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: product['name'] ?? '이름 없음',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              CommonText(
                text: '${formatPrice(product['price'])}원',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: '남은 갯수 : ${product['quantity'] ?? 0}개',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          // 구분선 추가
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          const SizedBox(height: 10),
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