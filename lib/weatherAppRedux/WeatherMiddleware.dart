import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import 'package:weather_app/Application.dart';
import 'package:weather_app/weatherAppRedux/WeatherActions.dart';
import 'package:weather_app/weatherAppRedux/WeatherLogic.dart';
import 'package:weather_app/weatherAppRedux/WeatherViewState.dart';

class AnimationsEpicReduxMws {
  final AnimationsEpicReduxLogic animationsEpicReduxLogic;

  AnimationsEpicReduxMws(this.animationsEpicReduxLogic);

  List<Middleware<AnimationEpicReduxViewState>> createAnimationsEpicReduxMws() {
    return [
      TypedMiddleware<AnimationEpicReduxViewState, UpdateWeatherAction>(
          handleUpdateWeatherAction),
      TypedMiddleware<AnimationEpicReduxViewState, LoadForecastAction>(
          _handleLoadForeCastAction)
    ];
  }

  _handleLoadForeCastAction(Store<AnimationEpicReduxViewState> store,
      LoadForecastAction action, NextDispatcher next) {
    next(LoadingForecast());
    animationsEpicReduxLogic
        .getForecast()
        .then((weather) => next(WeatherMwForecastPartialState(
            _convertLogicModelToMw(weather.forecast))))
        .catchError((error) {
      appLogger.e("forecastLoad:", error);
      next(NoInternetConnection());
    });
  }

  handleUpdateWeatherAction(Store<AnimationEpicReduxViewState> store,
      UpdateWeatherAction action, NextDispatcher next) {
    next(Loading());
    animationsEpicReduxLogic
        .getCurrentWeather()
        .then((weather) => next(AnimationsEpicReduxMwWeatherUpdatedPartialState(
            weatherIcon: weather.weatherIcon,
            temperature: weather.temperature,
            isDay: weather.isDay,
            humidity: weather.humidity,
            pressureHpa: weather.pressureHpa,
            visibilityMeters: weather.visibilityMeters,
            cloudlinessPercentage: weather.cloudlinessPercentage,
            windSpeed: weather.windSpeed,
            windDegree: weather.windDegree)))
        ;
  }

  Map<DateTime, MwForeCastForDay> _convertLogicModelToMw(
      Map<DateTime, ForeCastForDay> forecast) {
    return forecast.map((key, item) => MapEntry(
        key,
        MwForeCastForDay(item.hourlyForecast
            .map((item) => MwForecastForHour(
                item.temperature,
                item.pressuremPa,
                item.humidityPercentage,
                item.weatherIcon,
                item.cloudsPercentage,
                item.windSpeed,
                item.windDegree,
                item.date))
            .toList())));
  }
}

/// partial states of this middleware

class NoInternetConnection {}

class Loading {}

class LoadingForecast {}

/// MW states
@immutable
class AnimationsEpicReduxMwWeatherUpdatedPartialState {
  final String weatherIcon;
  final num temperature;
  final bool isDay;
  final num humidity;
  final num pressureHpa;
  final num visibilityMeters;
  final num cloudlinessPercentage;
  final num windSpeed;
  final num windDegree;

  AnimationsEpicReduxMwWeatherUpdatedPartialState(
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
class WeatherMwForecastPartialState {
  final Map<DateTime, MwForeCastForDay> forecast;

  WeatherMwForecastPartialState(this.forecast);
}

@immutable
class MwForeCastForDay {
  final List<MwForecastForHour> hourlyForecast;

  MwForeCastForDay(this.hourlyForecast);
}

@immutable
class MwForecastForHour {
  final num temperature;
  final num pressuremPa;
  final num humidityPercentage;
  final String weatherIcon;
  final num cloudsPercentage;
  final num windSpeed;
  final num windDegree;
  final DateTime date;

  MwForecastForHour(
      this.temperature,
      this.pressuremPa,
      this.humidityPercentage,
      this.weatherIcon,
      this.cloudsPercentage,
      this.windSpeed,
      this.windDegree,
      this.date);
}
