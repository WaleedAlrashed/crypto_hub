import 'dart:io';

import 'package:crypto_tracker/models/forecast_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_tracker/services/gemini_service.dart';

void main() {
  group('GeminiService Tests', () {
    setUpAll(() async {
      // Load environment variables
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());

      // Initialize Gemini with the API key from .env
      final apiKey = dotenv.env['GEMINI_API_KEY'];
      if (apiKey == null) {
        throw Exception('API_KEY not found in .env file');
      }
      Gemini.init(apiKey: apiKey);
    });
    test('getForecast returns valid data', () async {
      // Arrange
      const String crypto = 'BTC';
      const double amount = 50.0;

      // Act
      final forecastData = await GeminiService.getForecast(crypto, amount);

      // Assert
      expect(forecastData, isNotNull);
      expect(forecastData.crypto, equals(crypto));
      expect(forecastData.forecast, isNotNull);
    });

    test('getForecast throws error on invalid input', () async {
      // Arrange
      const String crypto = 'INVALID_CRYPTO';
      const double amount = -10.0;

      // Act & Assert
      expect(
        () async => await GeminiService.getForecast(crypto, amount),
        throwsA(isA<Future<ForecastModel>>()),
      );
    });
  });
}
