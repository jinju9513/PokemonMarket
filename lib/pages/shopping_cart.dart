import 'package:flutter/material.dart';

class CartItem {
  final String id; // ID 필드 추가
  final String name;
  final int price;
  final int quantity;
  final String imagePath;

  CartItem({
    required this.id, // 필수 파라미터로 변경
    required this.name,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });

  int get totalPrice => price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id, // ID 유지
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
      imagePath: imagePath,
    );
  }

  // 상품 데이터에서 CartItem을 생성하는 팩토리 메서드
  factory CartItem.fromProduct(Map<String, dynamic> product,
      {int quantity = 1}) {
    String priceStr = product['price']?.toString().replaceAll(',', '') ?? '0';
    int price = int.tryParse(priceStr) ?? 0;

    String imagePath;
    if (product['imagePath'] == null) {
      imagePath = 'assets/placeholder.png';
    } else if (product['imagePath'] is String) {
      imagePath = product['imagePath'];
    } else {
      // File 객체인 경우 path 속성 사용
      imagePath = product['imagePath'].path;
    }

    // 고유 ID 가져오기 (없는 경우 현재 시간 기반 ID 생성)
    String id = product['id']?.toString() ??
        DateTime.now().millisecondsSinceEpoch.toString();

    return CartItem(
      id: id, // ID 설정
      name: product['name'] ?? '제품명 없음',
      price: price,
      quantity: quantity,
      imagePath: imagePath,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CartItem) return false;

    // ID와 이름을 모두 비교하도록 수정
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class CartManager extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(CartItem item) {
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index >= 0) {
      final existing = _items[index];
      _items[index] =
          existing.copyWith(quantity: existing.quantity + item.quantity);
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index >= 0) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void updateQuantity(CartItem item, int newQuantity) {
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index >= 0) {
      _items[index] = item.copyWith(quantity: newQuantity);
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);
}
