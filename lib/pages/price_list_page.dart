import 'dart:convert';

import 'package:crypto_tracker/notifiers/theme_notifier.dart';
import 'package:crypto_tracker/services/price_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_fix/flutter_icons_fix.dart';

class PriceListPage extends StatelessWidget {
  final List<String> cryptoSymbols = ['btcusdt', 'ethusdt'];

  final Map<String, double> previousPrices = {};

  PriceListPage({super.key});

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
            onPressed: ThemeNotifier().toggleTheme,
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
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(
                      //       '${symbol.toUpperCase()} price changed to \$${price.toStringAsFixed(2)}',
                      //     ),
                      //     backgroundColor: Colors.deepPurple,
                      //     behavior: SnackBarBehavior.floating,
                      //     duration: const Duration(seconds: 3),
                      //   ),
                      // );
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
