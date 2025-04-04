import 'package:flutter/foundation.dart';

class ThemeManager with ChangeNotifier {
  // 싱글톤 패턴 구현
  static final ThemeManager _instance = ThemeManager._internal();

  factory ThemeManager() {
    return _instance;
  }

  ThemeManager._internal();

  // 테마 상태
  bool _isDarkMode = false;

  // getter
  bool get isDarkMode => _isDarkMode;

  // 테마 전환
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // 상태 변경 알림
  }

  // 테마 설정
  void setTheme(bool isDark) {
    if (_isDarkMode != isDark) {
      _isDarkMode = isDark;
      notifyListeners(); // 상태 변경 알림
    }
  }
}