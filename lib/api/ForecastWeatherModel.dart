import 'dart:core';

class ForecastWeatherModel {
  final List<ForeCastModel> forecast;

  ForecastWeatherModel({this.forecast});

  factory ForecastWeatherModel.fromJson(Map<String, dynamic> parsedJson) {
    return ForecastWeatherModel(
        forecast: (parsedJson["list"] as List).map((value) => ForeCastModel.fromJson(value)).toList(growable: false));
  }
}

class ForeCastModel {
  int _dt;
  Main _main;
  List<Weather> _weather;
  Clouds _clouds;
  Wind _wind;
  Rain _rain;
  Sys _sys;
  String _dtTxt;

  ForeCastModel(
      {int dt,
        Main main,
        List<Weather> weather,
        Clouds clouds,
        Wind wind,
        Rain rain,
        Sys sys,
        String dtTxt}) {
    this._dt = dt;
    this._main = main;
    this._weather = weather;
    this._clouds = clouds;
    this._wind = wind;
    this._rain = rain;
    this._sys = sys;
    this._dtTxt = dtTxt;
  }

  int get dt => _dt;
  set dt(int dt) => _dt = dt;
  Main get main => _main;
  set main(Main main) => _main = main;
  List<Weather> get weather => _weather;
  set weather(List<Weather> weather) => _weather = weather;
  Clouds get clouds => _clouds;
  set clouds(Clouds clouds) => _clouds = clouds;
  Wind get wind => _wind;
  set wind(Wind wind) => _wind = wind;
  Rain get rain => _rain;
  set rain(Rain rain) => _rain = rain;
  Sys get sys => _sys;
  set sys(Sys sys) => _sys = sys;
  String get dtTxt => _dtTxt;
  set dtTxt(String dtTxt) => _dtTxt = dtTxt;

  ForeCastModel.fromJson(Map<String, dynamic> json) {
    _dt = json['dt'];
    _main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      _weather = new List<Weather>();
      json['weather'].forEach((v) {
        _weather.add(new Weather.fromJson(v));
      });
    }
    _clouds =
    json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    _wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    _rain = json['rain'] != null ? new Rain.fromJson(json['rain']) : null;
    _sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    _dtTxt = json['dt_txt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this._dt;
    if (this._main != null) {
      data['main'] = this._main.toJson();
    }
    if (this._weather != null) {
      data['weather'] = this._weather.map((v) => v.toJson()).toList();
    }
    if (this._clouds != null) {
      data['clouds'] = this._clouds.toJson();
    }
    if (this._wind != null) {
      data['wind'] = this._wind.toJson();
    }
    if (this._rain != null) {
      data['rain'] = this._rain.toJson();
    }
    if (this._sys != null) {
      data['sys'] = this._sys.toJson();
    }
    data['dt_txt'] = this._dtTxt;
    return data;
  }
}

class Main {
  num _temp;
  num _tempMin;
  num _tempMax;
  num _pressure;
  num _seaLevel;
  num _grndLevel;
  int _humidity;
  num _tempKf;

  Main(
      {num temp,
        num tempMin,
        num tempMax,
        num pressure,
        num seaLevel,
        num grndLevel,
        int humidity,
        num tempKf}) {
    this._temp = temp;
    this._tempMin = tempMin;
    this._tempMax = tempMax;
    this._pressure = pressure;
    this._seaLevel = seaLevel;
    this._grndLevel = grndLevel;
    this._humidity = humidity;
    this._tempKf = tempKf;
  }

  num get temp => _temp;
  set temp(num temp) => _temp = temp;
  num get tempMin => _tempMin;
  set tempMin(num tempMin) => _tempMin = tempMin;
  num get tempMax => _tempMax;
  set tempMax(num tempMax) => _tempMax = tempMax;
  num get pressure => _pressure;
  set pressure(num pressure) => _pressure = pressure;
  num get seaLevel => _seaLevel;
  set seaLevel(num seaLevel) => _seaLevel = seaLevel;
  num get grndLevel => _grndLevel;
  set grndLevel(num grndLevel) => _grndLevel = grndLevel;
  int get humidity => _humidity;
  set humidity(int humidity) => _humidity = humidity;
  num get tempKf => _tempKf;
  set tempKf(num tempKf) => _tempKf = tempKf;

  Main.fromJson(Map<String, dynamic> json) {
    _temp = json['temp'];
    _tempMin = json['temp_min'];
    _tempMax = json['temp_max'];
    _pressure = json['pressure'];
    _seaLevel = json['sea_level'];
    _grndLevel = json['grnd_level'];
    _humidity = json['humidity'];
    _tempKf = json['temp_kf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this._temp;
    data['temp_min'] = this._tempMin;
    data['temp_max'] = this._tempMax;
    data['pressure'] = this._pressure;
    data['sea_level'] = this._seaLevel;
    data['grnd_level'] = this._grndLevel;
    data['humidity'] = this._humidity;
    data['temp_kf'] = this._tempKf;
    return data;
  }
}

class Weather {
  static const String ICON_URL = "http://openweathermap.org/img/w/{icon}.png";

  int _id;
  String _main;
  String _description;
  String _icon;

  Weather({int id, String main, String description, String icon}) {
    this._id = id;
    this._main = main;
    this._description = description;
    this._icon = icon;
  }


  String get icon => _icon;

  Weather.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = ICON_URL.replaceFirst("{icon}", json['icon']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['main'] = this._main;
    data['description'] = this._description;
    data['icon'] = this._icon;
    return data;
  }
}

class Clouds {
  int _all;

  Clouds({int all}) {
    this._all = all;
  }

  int get all => _all;
  set all(int all) => _all = all;

  Clouds.fromJson(Map<String, dynamic> json) {
    _all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this._all;
    return data;
  }
}

class Wind {
  num _speed;
  num _deg;

  Wind({num speed, num deg}) {
    this._speed = speed;
    this._deg = deg;
  }

  num get speed => _speed;
  set speed(num speed) => _speed = speed;
  num get deg => _deg;
  set deg(num deg) => _deg = deg;

  Wind.fromJson(Map<String, dynamic> json) {
    _speed = json['speed'];
    _deg = json['deg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this._speed;
    data['deg'] = this._deg;
    return data;
  }
}

class Rain {
  num _d3h;

  Rain({num d3h}) {
    this._d3h = d3h;
  }

  num get d3h => _d3h;
  set d3h(num d3h) => _d3h = d3h;

  Rain.fromJson(Map<String, dynamic> json) {
    _d3h = json['3h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['3h'] = this._d3h;
    return data;
  }
}

class Sys {
  String _pod;

  Sys({String pod}) {
    this._pod = pod;
  }

  String get pod => _pod;
  set pod(String pod) => _pod = pod;

  Sys.fromJson(Map<String, dynamic> json) {
    _pod = json['pod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pod'] = this._pod;
    return data;
  }
}

class City {
  int _id;
  String _name;
  Coord _coord;
  String _country;

  City({int id, String name, Coord coord, String country}) {
    this._id = id;
    this._name = name;
    this._coord = coord;
    this._country = country;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  Coord get coord => _coord;
  set coord(Coord coord) => _coord = coord;
  String get country => _country;
  set country(String country) => _country = country;

  City.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    _country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    if (this._coord != null) {
      data['coord'] = this._coord.toJson();
    }
    data['country'] = this._country;
    return data;
  }
}

class Coord {
  num _lat;
  num _lon;

  Coord({num lat, num lon}) {
    this._lat = lat;
    this._lon = lon;
  }

  num get lat => _lat;
  set lat(num lat) => _lat = lat;
  num get lon => _lon;
  set lon(num lon) => _lon = lon;

  Coord.fromJson(Map<String, dynamic> json) {
    _lat = json['lat'];
    _lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this._lat;
    data['lon'] = this._lon;
    return data;
  }
}
