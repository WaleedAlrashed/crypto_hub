import 'package:crypto_tracker/pages/forecast_results_page.dart';
import 'package:crypto_tracker/services/gemini_service.dart';
import 'package:flutter/material.dart';

class PortfolioForecastPage extends StatefulWidget {
  const PortfolioForecastPage({super.key});

  @override
  State<PortfolioForecastPage> createState() => _PortfolioForecastPageState();
}

class _PortfolioForecastPageState extends State<PortfolioForecastPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCrypto;
  double? cryptoAmount;
  final List<String> cryptocurrencies = [
    'BTC',
    'ETH',
    'BNB',
    'XRP',
    'ADA'
  ]; // Example list
  final TextEditingController amountController =
      TextEditingController(text: "50");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // Dropdown for selecting cryptocurrency
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
                validator: (value) =>
                    value == null ? 'Please select a cryptocurrency' : null,
              ),
              const SizedBox(height: 16.0),

              // Text field for entering amount
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

              // Button to generate results
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      generateForecast();
                    }
                  },
                  child: const Text('Generate Forecast with AI'),
                ),
              ),

              // Disclaimer text
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'All your data will be privately secured.',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to generate forecast by sending data to Google Gemini
  void generateForecast() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Call Gemini API (this should be an async function)
      final forecastData =
          await GeminiService.getForecast(selectedCrypto!, cryptoAmount!);

      if (!mounted) return;

      // Navigate to results page with the forecast data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForecastResultsPage(
            forecast: forecastData,
          ),
        ),
      );
    }
  }
}
