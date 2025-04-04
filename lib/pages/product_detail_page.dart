import 'package:flutter/material.dart';
import 'package:pokemon_market/pages/edit_product_page.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/widgets/product_detail_page/detail_list.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  int getTotalPrice() {
    dynamic priceValue = widget.product['price'] ?? 0;
    int price;

    if (priceValue is String) {
      price = int.tryParse(priceValue.replaceAll(',', '')) ?? 0;
    } else if (priceValue is int) {
      price = priceValue;
    } else {
      price = 0;
    }

    return price * _quantity;
  }

  void _showAddToCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('장바구니에 담겼습니다.'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('취소', style: TextStyle(color: Colors.grey)),
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey[300],
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('확인', style: TextStyle(color: Colors.blue)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showStockErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('구매할 수 없습니다.'),
          content: const Text('선택한 갯수가 재고보다 많습니다.'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('확인', style: TextStyle(color: Colors.blue)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog() async {
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductPage(product: widget.product),
      ),
    );

    if (updatedProduct != null && updatedProduct is Map<String, dynamic>) {
      Navigator.pop(context, updatedProduct);
    }
  }

  void _handleDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('삭제 확인'),
          content: const Text('이 상품을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context, {'deleted': true});
              },
              child: const Text('삭제', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: DetailList(
          product: widget.product,
          onEdit: _showEditDialog,
          onDelete: _handleDelete,
        ),
      ),
      bottomNavigationBar: Container(
        height: 100, // 세로 높이를 100으로 설정 (기존 높이보다 증가)
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // 패딩 조정
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.black),
                  onPressed: () {
                    if (_quantity > 1) setState(() => _quantity--);
                  },
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32), // 버튼 크기 약간 증가
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 18, color: Colors.black), // 텍스트 크기 증가
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  onPressed: () => setState(() => _quantity++),
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32), // 버튼 크기 약간 증가
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
            Text(
              '₩${getTotalPrice().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
              style: const TextStyle(fontSize: 18, color: Colors.black54), // 텍스트 크기 증가
            ),
            ElevatedButton(
              onPressed: () {
                int stock = widget.product['quantity'] ?? 0;
                if (_quantity > stock) {
                  _showStockErrorDialog(context);
                } else {
                  _showAddToCartDialog(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // 버튼 패딩 조정
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('구매하기', style: TextStyle(fontSize: 18)), // 텍스트 크기 증가
            ),
          ],
        ),
      ),
    );
  }
}