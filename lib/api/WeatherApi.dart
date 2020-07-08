import 'dart:async';
import 'dart:convert';

import 'package:weather_app/api/CurrentWeatherModel.dart';
import 'package:weather_app/api/ForecastWeatherModel.dart';
import 'package:http/http.dart' as http;

import 'WeatherInfoApiKey.dart';

/// api call for current weather in Kosice
/// https://api.openweathermap.org/data/2.5/weather?id=724443&lang=SK&units=metric&appid=$weatherApiKey
/// example repsonse: {"coord":{"lon":21.26,"lat":48.71},"weather":[{"id":800,"main":"Clear","description":"jasná obloha","icon":"01d"}],"base":"stations","main":{"temp":28,"pressure":1018,"humidity":42,"temp_min":28,"temp_max":28},"visibility":10000,"wind":{"speed":6.7,"deg":360},"clouds":{"all":0},"dt":1534847400,"sys":{"type":1,"id":5907,"message":0.0023,"country":"SK","sunrise":1534822604,"sunset":1534873099},"id":724443,"name":"Kosice","cod":200}

class WeatherApi {
  static const String ACTUAL_WEATHER_KOSICE =
      "https://api.openweathermap.org/data/2.5/weather?id=724443&lang=SK&units=metric&appid=$weatherApiKey";

  static const String FORECAST_WEATHER_KOSICE =
      "https://api.openweathermap.org/data/2.5/forecast?id=724443&lang=SK&units=metric&appid=$weatherApiKey";

  Future<CurrentWeatherModel> getActualWeather() async {
    return await http.Client()
        .get(Uri.parse(ACTUAL_WEATHER_KOSICE))
        .then((response) => response.body)
        .then(json.decode)
        .then((value) {
      print(value);
      return value;
    }).then((json) => CurrentWeatherModel.fromJson(json));
  }

  Future<ForecastWeatherModel> getForecast() async {
    return await http.Client()
        .get(Uri.parse(FORECAST_WEATHER_KOSICE))
        .then((response) => response.body)
        .then(json.decode)
        .then((value) {
      print(value);
      return value;
    }).then((json) => ForecastWeatherModel.fromJson(json));
  }
}
