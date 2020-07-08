import 'package:flutter/material.dart';

/// {
///    "coord": {
///         "lon": 21.26,
///         "lat": 48.71
///    },
///    "weather": [
///       {
///          "id": 800,
///          "main": "Clear",
///          "description": "jasná obloha",
///          "icon": "01d"
///        }
///    ],
///    "base": "stations",
///    "main": {
///       "temp": 28,
///       "pressure": 1018,
///       "humidity": 42,
///       "temp_min": 28,
///       "temp_max": 28
///    },
///    "visibility": 10000,
///    "wind": {
///       "speed": 6.7,
///       "deg": 360
///    },
///    "clouds": {
///        "all": 0
///    },
///    "dt": 1534847400,
///    "sys": {
///         "type": 1,
///         "id": 5907,
///         "message": 0.0023,
///         "country": "SK",
///         "sunrise": 1534822604,
///         "sunset": 1534873099
///    },
///    "id": 724443,
///    "name": "Kosice",
///    "cod": 200
///    }

@immutable
class CurrentWeatherModel {
  final List<WeatherModel> weather;
  final MainModel main;
  final SysModel sysModel;
  final num visibilityMeters;
  final Clouds clouds;
  final Wind wind;

  CurrentWeatherModel({this.weather, this.main, this.sysModel, this.visibilityMeters, this.clouds, this.wind});

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> parsedJson) {
    return CurrentWeatherModel(
        weather: (parsedJson["weather"] as List).map((value) => WeatherModel.fromJson(value)).toList(growable: false),
        main: MainModel.fromJson(parsedJson["main"]),
        sysModel: SysModel.fromJson(parsedJson["sys"]),
        visibilityMeters: parsedJson["visibility"],
        clouds: Clouds.fromJson(parsedJson["clouds"]),
        wind: Wind.fromJson(parsedJson["wind"]));
  }
}

class Wind {
  final num windSpeed;
  final num windDegree;

  Wind({this.windSpeed, this.windDegree});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(windDegree: json["deg"], windSpeed: json["speed"]);
  }
}

class Clouds {
  final num cloudlinesPercentage;

  Clouds({this.cloudlinesPercentage});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(cloudlinesPercentage: json["all"]);
  }
}

class SysModel {
  final num sunRise;
  final num sunSet;

  SysModel({this.sunRise, this.sunSet});

  factory SysModel.fromJson(Map<String, dynamic> json) {
    return SysModel(sunRise: json["sunrise"], sunSet: json["sunset"]);
  }
}

class WeatherModel {
  static const String ICON_URL = "http://openweathermap.org/img/w/{icon}.png";

  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherModel({this.id, this.main, this.description, this.icon});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: ICON_URL.replaceFirst("{icon}", json["icon"]));
  }
}

class MainModel {
  final int temp;
  final int pressure;
  final int humidity;
  final int temp_min;
  final int temp_max;

  MainModel({this.temp, this.pressure, this.humidity, this.temp_min, this.temp_max});

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(
        temp: json["temp"],
        pressure: json["pressure"],
        humidity: json["humidity"],
        temp_min: json["temp_min"],
        temp_max: json["temp_max"]);
  }
}
