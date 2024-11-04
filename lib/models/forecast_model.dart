import 'package:hive/hive.dart';

part 'forecast_model.g.dart';

@HiveType(typeId: 0)
class ForecastModel {
  @HiveField(0)
  final String crypto;

  @HiveField(1)
  final Forecast forecast;

  @HiveField(2)
  final String assumptions;

  @HiveField(3)
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

  factory ForecastModel.empty() {
    return ForecastModel(
      crypto: '',
      forecast: Forecast.empty(),
      assumptions: '',
      tips: '',
    );
  }
}

@HiveType(typeId: 1)
class Forecast {
  @HiveField(0)
  final String shortTerm;

  @HiveField(1)
  final String mediumTerm;

  @HiveField(2)
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

  factory Forecast.empty() {
    return Forecast(
      shortTerm: '',
      mediumTerm: '',
      longTerm: '',
    );
  }
}
