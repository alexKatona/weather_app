import 'package:flutter/material.dart';

@immutable
class AnimationEpicReduxViewState {
  final String weatherIcon;
  final int temperature;
  final bool isLoading;
  final bool isDay;
  final num humidity;
  final num pressureHpa;
  final num visibilityMeters;
  final num cloudlinessPercentage;
  final num windSpeed;
  final num windDegree;
  final bool isInternetError;
  final WsForecast forecast;

  AnimationEpicReduxViewState(
      {this.forecast,
      this.pressureHpa,
      this.visibilityMeters,
      this.cloudlinessPercentage,
      this.weatherIcon,
      this.temperature,
      this.isLoading = false,
      this.isDay = true,
      this.humidity,
      this.windSpeed,
      this.windDegree,
      this.isInternetError = false});

  factory AnimationEpicReduxViewState.initial() => AnimationEpicReduxViewState();

  AnimationEpicReduxViewState copyWith(
      {String weatherIcon,
      int temperature,
      bool isLoading,
      bool isDay,
      num humidity,
      num pressureHpa,
      num visibilityMeters,
      num cloudlinessPercentage,
      num windSpeed,
      num windDegree,
      bool isInternetError,
      WsForecast forecast}) {
    return AnimationEpicReduxViewState(
        weatherIcon: weatherIcon ?? this.weatherIcon,
        temperature: temperature ?? this.temperature,
        isLoading: isLoading ?? this.isLoading,
        isDay: isDay ?? this.isDay,
        humidity: humidity ?? this.humidity,
        pressureHpa: pressureHpa ?? this.pressureHpa,
        visibilityMeters: visibilityMeters ?? this.visibilityMeters,
        cloudlinessPercentage: cloudlinessPercentage ?? this.cloudlinessPercentage,
        windDegree: windDegree ?? this.windDegree,
        windSpeed: windSpeed ?? this.windSpeed,
        isInternetError: isInternetError ?? this.isInternetError,
        forecast: forecast ?? this.forecast);
  }
}

/// ui data classes for forecast
@immutable
class WsForecast {
  final Map<DateTime, WsForeCastForDay> forecast;

  WsForecast(this.forecast);

  List<ForecastForDay> asList() {
    List<ForecastForDay> forecastList = List();
    forecast.forEach((key, value) {
      forecastList.add(ForecastForDay(key, value));
    });
    return forecastList;
  }
}

@immutable
class ForecastForDay {
  final DateTime date;
  final WsForeCastForDay forecast;

  ForecastForDay(this.date, this.forecast);
}

@immutable
class WsForeCastForDay {
  final List<WsForecastForHour> hourlyForecast;

  WsForeCastForDay(this.hourlyForecast);
}

@immutable
class WsForecastForHour {
  final num temperature;
  final num pressuremPa;
  final num humidityPercentage;
  final String weatherIcon;
  final num cloudsPercentage;
  final num windSpeed;
  final num windDegree;
  final DateTime date;

  WsForecastForHour(this.temperature, this.pressuremPa, this.humidityPercentage, this.weatherIcon, this.cloudsPercentage,
      this.windSpeed, this.windDegree, this.date);
}
