import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/widgets/product_detail_page/detail_list.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:provider/provider.dart';

// 상품 상세 페이지
class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product; // 상품 데이터

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1; // 선택한 갯수

  // 전체 가격 계산
  int getTotalPrice() {
    String priceStr = widget.product['price']?.replaceAll(',', '') ?? '0';
    int price = int.tryParse(priceStr) ?? 0;
    return price * _quantity;
  }

  // 장바구니 추가 팝업 표시
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text('취소', style: TextStyle(color: Colors.grey)),
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey[300],
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text('확인', style: TextStyle(color: Colors.blue)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // 재고 부족 팝업 표시
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text('확인', style: TextStyle(color: Colors.blue)),
                  ),
                ),
              ],
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
        child: DetailList(product: widget.product),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100], 
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(20)), 
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
            // 갯수 조절
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.black),
                  onPressed: () {
                    if (_quantity > 1) {
                      setState(() {
                        _quantity--;
                      });
                    }
                  },
                  padding: const EdgeInsets.all(4),
                  constraints:
                      const BoxConstraints(minWidth: 28, minHeight: 28),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  padding: const EdgeInsets.all(4),
                  constraints:
                      const BoxConstraints(minWidth: 28, minHeight: 28),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
            // 전체 가격
            Text(
              '₩${getTotalPrice().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            // 구매하기 버튼
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
                backgroundColor: Colors.blue, // 현대적인 파란색
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text('구매하기', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
