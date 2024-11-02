import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons_fix/flutter_icons_fix.dart';
import 'services/price_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(const CryptoTrackerApp());

class CryptoTrackerApp extends StatelessWidget {
  const CryptoTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PriceListScreen(),
    );
  }
}

class PriceListScreen extends StatelessWidget {
  final List<String> cryptoSymbols = ['btcusdt', 'ethusdt'];

  PriceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crypto Tracker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
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
