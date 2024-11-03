import 'dart:convert';

import 'package:crypto_tracker/models/forecast_model.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  static Future<ForecastModel> getForecast(
    String selectedCrypto,
    double cryptoAmount,
  ) async {
    final gemini = Gemini.instance;

    String prompt = """
User is requesting a forecast for their cryptocurrency portfolio. The user holds $cryptoAmount of $selectedCrypto
 Generate a forecast for the portfolio’s projected revenue growth over time, assuming average market trends and historical growth rates. Provide insights on potential returns in the short term (1-3 months), medium term (6-12 months), and long term (1-5 years). Include any assumptions used in the forecast.
Data should be returned in the following json format only $forecastJsonFromat
""";

    final forecastResult = await gemini.text(prompt);
    if (forecastResult != null) {
      if (forecastResult.content?.parts != null) {
        dynamic jsonString = forecastResult.content!.parts!.first.text;
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        ForecastModel forecastModel = ForecastModel.fromJson(jsonData);

        return forecastModel;
      }
    }
    return Future.value(ForecastModel.empty());
  }

  static String forecastJsonFromat = """
{
  "type": "object",
  "properties": {
    "crypto": {
      "type": "string",
      "description": "Symbol of the cryptocurrency"
    },
    "forecast": {
      "type": "object",
      "description": "Forecasted revenue growth projections for the portfolio",
      "properties": {
        "short_term": {
          "type": "string",
          "description": "Projected revenue growth for 1-3 months"
        },
        "medium_term": {
          "type": "string",
          "description": "Projected revenue growth for 6-12 months"
        },
        "long_term": {
          "type": "string",
          "description": "Projected revenue growth for 1-5 years"
        }
      }
    },
    "assumptions": {
      "type": "string",
      "description": "Any assumptions made by Gemini AI in generating the forecast"
    },
    "tips":{
    "type": "string",
    "description":"Tips and tricks to increase revenue based on the Forecasted revenue growth"
    }
  },
  "required": [
    "crypto",
    "forecast"
  ]
}
""";
}
