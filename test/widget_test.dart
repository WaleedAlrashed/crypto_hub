// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_tracker/pages/price_list_page.dart';
import 'package:crypto_tracker/pages/portfolio_forecast_page.dart';

void main() {
  group('PriceListPage Tests', () {
    testWidgets('should display the app bar with title',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: PriceListPage()));

      expect(find.text('Crypto Tracker'), findsOneWidget);
    });

    testWidgets('should display loading text initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: PriceListPage()));

      expect(find.text('Loading...'), findsNWidgets(2)); // Assuming two items
    });
  });

  group('PortfolioForecastPage Tests', () {
    testWidgets('should display the app bar with title',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PortfolioForecastPage()));

      expect(find.text('Portfolio Revenue Forecast'), findsOneWidget);
    });

    testWidgets('should display dropdown and text field',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PortfolioForecastPage()));

      expect(find.text('Select Cryptocurrency'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('should show validation error when form is invalid',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PortfolioForecastPage()));

      await tester.tap(find.text('Generate Forecast with AI'));
      await tester.pump();

      expect(find.text('Please select a cryptocurrency'), findsOneWidget);
      expect(find.text('Please enter an amount'), findsOneWidget);
    });
  });
}
