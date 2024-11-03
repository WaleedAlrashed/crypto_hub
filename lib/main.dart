import 'package:crypto_tracker/notifiers/theme_notifier.dart';
import 'package:crypto_tracker/pages/portfolio_forecase_page.dart';
import 'package:crypto_tracker/pages/price_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() {
  Gemini.init(apiKey: 'AIzaSyAXtMS9KyKDb4sFQwZAegWWRclet5dd1cE');
  runApp(
    CryptoTrackerApp(),
  );
}

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
          home: PortfolioForecastPage(
              // onToggleTheme: _themeNotifier.toggleTheme,
              ),
        );
      },
    );
  }
}
