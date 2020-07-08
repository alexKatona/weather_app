import 'package:flutter/material.dart';
import 'package:weather_app/weatherAppRedux/CustomWidgets/AppColors.dart';
import 'package:weather_app/weatherAppRedux/CustomWidgets/IconSkinned.dart';
import 'package:weather_app/weatherAppRedux/CustomWidgets/Text.dart';
import 'package:weather_app/weatherAppRedux/WeatherScreenWidgets/WeatherImageIcon.dart';
import 'package:weather_app/weatherAppRedux/WeatherViewState.dart';

Widget getWeatherBody(AnimationEpicReduxViewState widgetState) {
  if (widgetState.isInternetError) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: IconV1(Icons.signal_wifi_off),
        ),
      ],
    );
  } else if (widgetState.isLoading) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
        ),
      )
    ]);
  } else {
    return Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [_createTemperatureWidget(widgetState.temperature)]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [createWeatherImageIconWidget(widgetState.weatherIcon)]),
    ]);
  }
}

Widget _createTemperatureWidget(num temperature) {
  if (temperature == null) {
    return Text("Unknown");
  } else {
    return Padding(
      child: TextTemperature("${temperature.toInt()}°C"),
      padding: EdgeInsets.only(top: 50.0),
    );
  }
}
