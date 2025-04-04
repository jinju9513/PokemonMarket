import 'package:flutter/foundation.dart';

// 좋아요 상태를 관리하는 Provider
class LikeProvider with ChangeNotifier {
  // 상품별 좋아요 상태와 좋아요 수를 저장하는 맵
  final Map<String, bool> _likedItems = {};
  final Map<String, int> _likeCounts = {};

  // 특정 상품의 좋아요 상태 반환
  bool isLiked(String productId) => _likedItems[productId] ?? false;

  // 특정 상품의 좋아요 수 반환
  int getLikeCount(String productId) => _likeCounts[productId] ?? 0;

  // 좋아요 토글
  void toggleLike(String productId) {
    if (_likedItems[productId] == true) {
      _likedItems[productId] = false;
      _likeCounts[productId] = (_likeCounts[productId] ?? 0) - 1;
    } else {
      _likedItems[productId] = true;
      _likeCounts[productId] = (_likeCounts[productId] ?? 0) + 1;
    }
    notifyListeners(); // 상태 변경 알림
  }
}