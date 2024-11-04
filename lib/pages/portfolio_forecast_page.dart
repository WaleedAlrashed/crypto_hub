import 'package:crypto_tracker/pages/forecast_results_page.dart';
import 'package:crypto_tracker/services/gemini_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:crypto_tracker/models/forecast_model.dart';

class PortfolioForecastPage extends StatefulWidget {
  const PortfolioForecastPage({super.key});

  @override
  State<PortfolioForecastPage> createState() => _PortfolioForecastPageState();
}

class _PortfolioForecastPageState extends State<PortfolioForecastPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCrypto;
  double? cryptoAmount;
  bool _isLoading = false;
  final List<String> cryptocurrencies = ['BTC', 'ETH', 'BNB', 'XRP', 'ADA'];
  final TextEditingController amountController =
      TextEditingController(text: "50");
  late Box<ForecastModel> forecastBox;

  @override
  void initState() {
    super.initState();
    forecastBox = Hive.box<ForecastModel>('forecasts');
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Portfolio Revenue Forecast'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedCrypto,
                      hint: const Text('Select Cryptocurrency'),
                      items: cryptocurrencies.map((crypto) {
                        return DropdownMenuItem(
                          value: crypto,
                          child: Text(crypto),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCrypto = value;
                        });
                      },
                      validator: (value) => value == null
                          ? 'Please select a cryptocurrency'
                          : null,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter Amount',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        final amount = double.tryParse(value);
                        if (amount == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        cryptoAmount = double.parse(value!);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  generateForecast();
                                }
                              },
                              child: const Text('Generate Forecast with AI'),
                            ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'All your data will be privately secured.',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("previous forecasts"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: forecastBox.length,
                        itemBuilder: (context, index) {
                          final forecast = forecastBox.getAt(index);
                          return Card(
                            child: ListTile(
                              title: Text(forecast!.crypto),
                              subtitle: Text(
                                  'Short Term: ${forecast.forecast.shortTerm}'),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForecastResultsPage(forecast: forecast),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void generateForecast() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final forecastData =
          await GeminiService.getForecast(selectedCrypto!, cryptoAmount!);

      if (!mounted) return;

      forecastBox.add(forecastData);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ForecastResultsPage(
            forecast: forecastData,
          ),
        ),
      );
    } catch (e) {
      print('Error fetching forecast: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
