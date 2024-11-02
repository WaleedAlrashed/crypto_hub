import 'dart:convert';

import 'package:crypto_tracker/notifiers/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_fix/flutter_icons_fix.dart';
import 'services/price_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
          home: PriceListScreen(
            onToggleTheme: _themeNotifier.toggleTheme,
          ),
        );
      },
    );
  }
}

class PriceListScreen extends StatelessWidget {
  final List<String> cryptoSymbols = ['btcusdt', 'ethusdt'];
  final VoidCallback onToggleTheme;
  final Map<String, double> previousPrices = {};

  PriceListScreen({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crypto Tracker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cryptoSymbols.length,
        itemBuilder: (context, index) {
          final symbol = cryptoSymbols[index];
          final priceService = PriceService(symbol);

          return StreamBuilder(
            stream: priceService.priceStream.asyncMap((data) async {
              await Future.delayed(const Duration(seconds: 1));
              return data;
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final priceData = jsonDecode(snapshot.data);
                final priceString = priceData['p'];
                final price = double.parse(priceString);

                if (previousPrices[symbol] != null &&
                    previousPrices[symbol] != price) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${symbol.toUpperCase()} price changed to \$${price.toStringAsFixed(2)}',
                          ),
                          backgroundColor: Colors.deepPurple,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  });
                }

                previousPrices[symbol] = price;

                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      FlutterIcons.currency_btc_mco,
                      color: Colors.orange,
                    ),
                    title: Text(
                      symbol.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Price: \$${price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: const Icon(
                      Icons.trending_up,
                      color: Colors.green,
                    ),
                  ),
                );
              } else {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      FlutterIcons.currency_btc_mco,
                      color: Colors.orange,
                    ),
                    title: Text(
                      symbol.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text('Loading...'),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initializeNotifications() {
  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  notificationsPlugin.initialize(initializationSettings);
}

void showAlert(String crypto, double price) {
  const notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails('id', 'name',
        channelDescription: 'channel description'),
  );
  notificationsPlugin.show(
    0,
    '$crypto Price Alert',
    'The price is now $price',
    notificationDetails,
  );
}
