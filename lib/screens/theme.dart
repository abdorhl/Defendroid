import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDark = true;

  bool get isDark => _isDark;

  setDarkMode(bool value) {
    _isDark = value;
    notifyListeners();
  }
}
