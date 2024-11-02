import 'dart:convert';

import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text('Crypto Tracker')),
      body: ListView.builder(
        itemCount: cryptoSymbols.length,
        itemBuilder: (context, index) {
          final symbol = cryptoSymbols[index];
          print("fuck $symbol");
          final priceService = PriceService(symbol);

          return StreamBuilder(
            stream: priceService.priceStream.asyncMap((data) async {
              await Future.delayed(const Duration(seconds: 1));
              return data;
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final priceData = jsonDecode(snapshot.data);
// "{"e":"trade","E":1730565712804,"s":"BTCUSDT","t":3993655081,"p":"69562.00000000","q":"0.00089000","T":1730565712804,"m":false,"M…"

                final priceString = priceData['p'];
                final price = double.parse(priceString);
                return ListTile(
                  title: Text("$symbol"),
                  subtitle: Text('Price: $price'),
                );
              } else {
                return ListTile(
                  title: Text("$symbol"),
                  subtitle: const Text('Loading...'),
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
