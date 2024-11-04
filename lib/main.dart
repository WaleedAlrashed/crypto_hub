import 'package:crypto_tracker/notifiers/theme_notifier.dart';
import 'package:crypto_tracker/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:crypto_tracker/models/forecast_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  final geminiApiKey = dotenv.env['GEMINI_API_KEY'];
  if (geminiApiKey == null) {
    throw Exception('GEMINI_API_KEY not found in .env file');
  }
  Gemini.init(apiKey: geminiApiKey);

  await Hive.initFlutter();
  Hive.registerAdapter(ForecastModelAdapter());
  Hive.registerAdapter(ForecastAdapter());
  await Hive.openBox<ForecastModel>('forecasts');

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
          title: 'Crypto Tracker',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: snapshot.data,
          home: const HomePage(),
        );
      },
    );
  }
}
