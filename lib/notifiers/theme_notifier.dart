import 'dart:async';
import 'package:flutter/material.dart';

class ThemeNotifier {
  final _themeController = StreamController<ThemeMode>.broadcast();
  ThemeMode _currentTheme = ThemeMode.system;

  Stream<ThemeMode> get themeStream => _themeController.stream;
  ThemeMode get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme =
        _currentTheme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _themeController.sink.add(_currentTheme);
  }

  void dispose() {
    _themeController.close();
  }
}
