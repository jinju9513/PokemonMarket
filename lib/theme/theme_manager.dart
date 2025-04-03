import 'package:flutter/material.dart';

class ThemeManager {
  // 싱글톤 패턴 구현
  static final ThemeManager _instance = ThemeManager._internal();

  factory ThemeManager() {
    return _instance;
  }

  ThemeManager._internal();

  // 테마 상태와 리스너 목록
  bool _isDarkMode = false;
  final List<Function(bool)> _listeners = [];

  // getter
  bool get isDarkMode => _isDarkMode;

  // 리스너 추가
  void addListener(Function(bool) listener) {
    _listeners.add(listener);
  }

  // 리스너 제거
  void removeListener(Function(bool) listener) {
    _listeners.remove(listener);
  }

  // 테마 전환
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _notifyListeners();
  }

  // 테마 설정
  void setTheme(bool isDark) {
    if (_isDarkMode != isDark) {
      _isDarkMode = isDark;
      _notifyListeners();
    }
  }

  // 리스너에게 변경 알림
  void _notifyListeners() {
    for (final listener in _listeners) {
      listener(_isDarkMode);
    }
  }
}
