import 'package:crypto_tracker/notifiers/theme_notifier.dart';
import 'package:crypto_tracker/pages/price_list_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(CryptoTrackerApp());

class CryptoTrackerApp extends StatelessWidget {
  final ThemeNotifier _themeNotifier = ThemeNotifier();

  CryptoTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeMode>(
      stream: _themeNotifier.themeStream,
      initialData: _themeNotifier.currentTheme,
      builder: (context, snapshot) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: snapshot.data,
          home: PriceListPage(
            onToggleTheme: _themeNotifier.toggleTheme,
          ),
        );
      },
    );
  }
}
