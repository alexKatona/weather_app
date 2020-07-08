import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/weatherAppRedux/CustomWidgets/AppColors.dart';
import 'package:weather_app/weatherAppRedux/CustomWidgets/ScrollBehaviours.dart';
import 'package:weather_app/weatherAppRedux/CustomWidgets/Text.dart';
import 'package:weather_app/weatherAppRedux/Helpers/Helpers.dart';
import 'package:weather_app/weatherAppRedux/WeatherScreenWidgets/MinorInfoWidget.dart';
import 'package:weather_app/weatherAppRedux/WeatherViewState.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget createForecastWidget(BuildContext context, WsForecast forecast) {
  if (forecast == null) {
    return Container();
  } else {
    var forecastList = forecast.asList();
    return ListBody(
      children: _generateDailyForecastList(forecastList),
    );
  }
}

List<Widget> _generateDailyForecastList(List<ForecastForDay> forecastList) {
  List<Widget> list = List();
  list.add(Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextH0("Forecast"),
  ));
  forecastList.forEach((item) {
    list.add(_ForecastRow(item, item.forecast.hourlyForecast));
  });
  return list;
}

class _ForecastRow extends StatefulWidget {
  final ForecastForDay _forecastForDay;
  final List<WsForecastForHour> _list;

  _ForecastRow(this._forecastForDay, this._list);

  @override
  State<StatefulWidget> createState() {
    return _ForecastRowState(_forecastForDay, _list);
  }
}

class _ForecastRowState extends State<_ForecastRow> {
  final ForecastForDay forecastForDay;
  final List<WsForecastForHour> hourlyForecast;
  var overallWeatherIconShown = true;
  WsForecastForHour detailsOfHourlyForecast;

  var controller;

  _ForecastRowState(this.forecastForDay, this.hourlyForecast);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ExpansionTile(
            // backgroundColor: Colors.grey.withAlpha(24),
            leading: TextB0("${DateFormat("EEEE, MMM d").format(forecastForDay.date)}"),
            title: Text(""),
            onExpansionChanged: (isExpanded) {
              setState(() {
                overallWeatherIconShown = !isExpanded;
              });
            },
            trailing: AnimatedOpacity(
            opacity: overallWeatherIconShown ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: _createDailyForecastRow(hourlyForecast),
          ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                child: SizedBox(
                  width: getWindowWidth(context),
                  height: 100.0,
                  child: ScrollConfiguration(
                    behavior: RemovedOverscroll(),
                    child: detailsOfHourlyForecast != null
                        ? _createHourlyDetailsWidget(detailsOfHourlyForecast, this)
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: hourlyForecast.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Material(
                                  color: AppColors.secondaryColor,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        detailsOfHourlyForecast = hourlyForecast[index];
                                      });
                                    },
                                    splashColor: Colors.amberAccent,
                                    customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text("${hourlyForecast[index].temperature.toInt()}°C"),
                                        Image.network(hourlyForecast[index].weatherIcon),
                                        Text("${DateFormat("Hm").format(hourlyForecast[index].date)}")
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _createHourlyDetailsWidget(WsForecastForHour detailsOfHourlyForecast, _ForecastRowState forecastRowState) {
  return Dismissible(
    resizeDuration: Duration(milliseconds: 100),
    onDismissed: (direction) {
      forecastRowState.setState(() {
        forecastRowState.detailsOfHourlyForecast = null;
      });
    },
    key: Key("s"),
    child: InkWell(
      onTap: () {
        forecastRowState.setState(() {
          forecastRowState.detailsOfHourlyForecast = null;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("${DateFormat("HH:mm").format(detailsOfHourlyForecast.date)}"),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              createIconInfoWidget("${detailsOfHourlyForecast.humidityPercentage ?? 0}%", MdiIcons.waterPercent),
              createIconInfoWidget("${detailsOfHourlyForecast.pressuremPa?.toInt() ?? 0}hPa", MdiIcons.speedometer),
              createIconInfoWidget("${detailsOfHourlyForecast.cloudsPercentage ?? 0}%", MdiIcons.weatherCloudy),
              createIconInfoWidget("${detailsOfHourlyForecast.windSpeed ?? 0}m/s", MdiIcons.weatherWindy,
                  rotationDegrees:
                      (detailsOfHourlyForecast.windDegree?.toDouble() ?? 0.0) - 90.0) // rotate the icon to north (-90.0)
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ],
      ),
    ),
  );
}

Widget _createDailyForecastRow(List<WsForecastForHour> hourlyForecast) {
  List<WsForecastForHour> dayList = hourlyForecast.where((item) => item.date.hour < 18 && item.date.hour > 8).toList();
  var weatherIcons = groupBy(dayList, (WsForecastForHour item) => item.weatherIcon);
  String icon;
  icon = weatherIcons.values
      .where((list) => list.length == weatherIcons.values.map((it) => it.length).reduce(max))
      .map((item) => (item.first?.weatherIcon) ?? null)
      .firstWhere((s) => true, orElse: () => "");

  var weatherIcon = icon.isEmpty ? Container() : Image.network(icon);
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: weatherIcon,
      ),
      Container(
        width: 40.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("${hourlyForecast.map((item) => item.temperature).reduce(max).toInt()}°C"),
            Text(
              "${hourlyForecast.map((item) => item.temperature).reduce(min).toInt()}°C",
              style: TextStyle(color: Colors.black38),
            ),
          ],
        ),
      ),
    ],
  );
}
