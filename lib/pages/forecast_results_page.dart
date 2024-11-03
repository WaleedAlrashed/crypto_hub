import 'package:crypto_tracker/models/forecast_model.dart';
import 'package:flutter/material.dart';

class ForecastResultsPage extends StatelessWidget {
  final ForecastModel forecast;

  const ForecastResultsPage({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forecast Results for ${forecast.crypto}"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Row(
                children: [
                  Icon(Icons.monetization_on, color: Colors.green, size: 40),
                  SizedBox(width: 8),
                  Text(
                    'Projected Revenue',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Forecast',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.trending_up,
                                  color: Colors.blue),
                              title: Text(
                                'Short Term: ${forecast.forecast.shortTerm}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.trending_flat,
                                  color: Colors.orange),
                              title: Text(
                                'Medium Term: ${forecast.forecast.mediumTerm}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.trending_down,
                                  color: Colors.red),
                              title: Text(
                                'Long Term: ${forecast.forecast.longTerm}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Text(
                        'Assumptions: ${forecast.assumptions}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Divider(),
                      Text(
                        'Tips: ${forecast.tips}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
