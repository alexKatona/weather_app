import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/api/CurrentWeatherModel.dart';
import 'package:weather_app/api/ForecastWeatherModel.dart';
import 'package:weather_app/api/WeatherApi.dart';
import 'package:intl/intl.dart';

class AnimationsEpicReduxLogic {
  final WeatherApi _weatherApi;

  AnimationsEpicReduxLogic(this._weatherApi);

  Future<AnimationsEpicReduxLogicWeatherPartialState> getCurrentWeather() {
    return _weatherApi.getActualWeather().then((weather) => AnimationsEpicReduxLogicWeatherPartialState(
        weatherIcon: weather.weather[0]?.icon ?? null,
        temperature: weather.main.temp,
        isDay: _isDay(weather),
        humidity: weather.main.humidity,
        pressureHpa: weather.main.pressure,
        visibilityMeters: weather.visibilityMeters,
        cloudlinessPercentage: weather.clouds.cloudlinesPercentage,
        windDegree: weather.wind.windDegree,
        windSpeed: weather.wind.windSpeed));
  }

  Future<WeatherLogicForecastPartialState> getForecast() {
    return _weatherApi.getForecast().then((forecastModel) => WeatherLogicForecastPartialState(_parseForecast(forecastModel)));
  }

  Map<DateTime, ForeCastForDay> _parseForecast(ForecastWeatherModel forecast) {
    DateFormat format = DateFormat('yyyy-MM-dd');

    /// creates map of forecasts for each day
    Map<DateTime, List<ForeCastModel>> groupedForecastByDay =
        groupBy(forecast.forecast, (foreCastmodel) => format.parse(foreCastmodel.dtTxt, true));

    /// map the date list to date custom object holding that list
    return groupedForecastByDay.map((itemKey, itemValue) =>
        MapEntry<DateTime, ForeCastForDay>(itemKey, ForeCastForDay(_getHourlyForeCastForDay(itemKey, groupedForecastByDay))));
  }

  List<ForecastForHour> _getHourlyForeCastForDay(DateTime date, Map<DateTime, List<ForeCastModel>> groupedForeCastByDay) {
    /// filter out dates for another day forecast
    Map<DateTime, List<ForeCastModel>> foreCastForDay = Map.from(groupedForeCastByDay)
      ..removeWhere((key, value) => !key.isAtSameMomentAs(date));

    /// map to list of foreCasts per hour for a given date
    List<ForecastForHour> hourlyForeCastForDay = List();
    foreCastForDay.values.expand((item) => item).toList().forEach((item) {
      hourlyForeCastForDay.add(ForecastForHour(item.main.temp, item.main.pressure, item.main.humidity, item.weather[0]?.icon,
          item.clouds.all, item.wind.speed, item.wind.deg, DateTime.parse(item.dtTxt)));
    });

    return hourlyForeCastForDay;
  }

  bool _isDay(CurrentWeatherModel weather) {
    var sunSet = DateTime.fromMillisecondsSinceEpoch(weather.sysModel.sunSet * 1000, isUtc: true);
    var sunRise = DateTime.fromMillisecondsSinceEpoch(weather.sysModel.sunRise * 1000, isUtc: true);
    var actual = DateTime.now().toUtc();
    return actual.isAfter(sunRise) && actual.isBefore(sunSet);
  }
}

class AnimationsEpicReduxLogicWeatherPartialState {
  final String weatherIcon;
  final num temperature;
  final bool isDay;
  final num humidity;
  final num pressureHpa;
  final num visibilityMeters;
  final num cloudlinessPercentage;
  final num windSpeed;
  final num windDegree;

  AnimationsEpicReduxLogicWeatherPartialState(
      {this.pressureHpa,
      this.visibilityMeters,
      this.cloudlinessPercentage,
      this.weatherIcon,
      this.temperature,
      @required this.isDay,
      this.humidity,
      this.windDegree,
      this.windSpeed});
}

@immutable
class WeatherLogicForecastPartialState {
  final Map<DateTime, ForeCastForDay> forecast;

  WeatherLogicForecastPartialState(this.forecast);
}

@immutable
class ForeCastForDay {
  final List<ForecastForHour> hourlyForecast;

  ForeCastForDay(this.hourlyForecast);
}

@immutable
class ForecastForHour {
  final num temperature;
  final num pressuremPa;
  final num humidityPercentage;
  final String weatherIcon;
  final num cloudsPercentage;
  final num windSpeed;
  final num windDegree;
  final DateTime date;

  ForecastForHour(this.temperature, this.pressuremPa, this.humidityPercentage, this.weatherIcon, this.cloudsPercentage,
      this.windSpeed, this.windDegree, this.date);
}
