import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_tracker/services/gemini_service.dart';

void main() {
  group('GeminiService Tests', () {
    Gemini.init(apiKey: "apiKey");
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
        throwsA(isA<Exception>()),
      );
    });
  });
}
