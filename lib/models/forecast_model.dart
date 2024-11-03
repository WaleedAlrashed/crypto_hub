import 'dart:convert';

class ForecastModel {
  final String crypto;
  final Forecast forecast;
  final String assumptions;
  final String tips;

  ForecastModel({
    required this.crypto,
    required this.forecast,
    required this.assumptions,
    required this.tips,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      crypto: json['crypto'],
      forecast: Forecast.fromJson(json['forecast']),
      assumptions: json['assumptions'],
      tips: json['tips'],
    );
  }

  // Factory method for empty results
  factory ForecastModel.empty() {
    return ForecastModel(
      crypto: '',
      forecast: Forecast.empty(),
      assumptions: '',
      tips: '',
    );
  }
}

class Forecast {
  final String shortTerm;
  final String mediumTerm;
  final String longTerm;

  Forecast({
    required this.shortTerm,
    required this.mediumTerm,
    required this.longTerm,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      shortTerm: json['short_term'],
      mediumTerm: json['medium_term'],
      longTerm: json['long_term'],
    );
  }
  // Factory method for empty forecast
  factory Forecast.empty() {
    return Forecast(
      shortTerm: '',
      mediumTerm: '',
      longTerm: '',
    );
  }
}

// Example usage
void main() {
  String jsonString = '''
  {
    "crypto": "BTC",
    "forecast": {
      "short_term": "Up to 5-10%",
      "medium_term": "15-25%",
      "long_term": "50-100%"
    },
    "assumptions": "Assuming average market trends and historical growth rates",
    "tips": "* Consider dollar-cost averaging to reduce risk and increase potential returns over time.\\n* Research and invest in a diverse portfolio of cryptocurrencies to reduce risk.\\n* Hold your investments long-term to maximize potential gains."
  }
  ''';

  Map<String, dynamic> jsonData = jsonDecode(jsonString);
  ForecastModel forecastModel = ForecastModel.fromJson(jsonData);

  print('Crypto: ${forecastModel.crypto}');
  print('Short Term Forecast: ${forecastModel.forecast.shortTerm}');
  print('Assumptions: ${forecastModel.assumptions}');
  print('Tips: ${forecastModel.tips}');
}
