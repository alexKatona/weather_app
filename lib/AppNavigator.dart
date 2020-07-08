import 'package:flutter/material.dart';
import 'package:weather_app/incrementButtonScreenBloc/IncrementButtonBlocWidget.dart';
import 'package:weather_app/incrementButtonScreenRedux/IncrementButtonWidget.dart';
import 'package:weather_app/incrementButtonScreenStreams/IncrButtonWidget.dart';
import 'package:weather_app/weatherAppRedux/WeatherScreen.dart';

void navigateTo(AppRoutes appRoute, BuildContext context) {
  switch (appRoute) {
    case AppRoutes.IncrementButtonRedux:
      Navigator.push(context, MaterialPageRoute(builder: (context) => ButtonIncrementWidget(title: 'FirstScreen')));
      break;
    case AppRoutes.IncrementButtonStreams:
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
      break;
    case AppRoutes.IncrementButtonBloc:
      Navigator.push(context, MaterialPageRoute(builder: (context) => IncrementButtonBlocWidget()));
      break;
    case AppRoutes.WeatherAppRedux:
      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimationsEpicReduxWidget()));
      break;
  }
}

enum AppRoutes { IncrementButtonRedux, IncrementButtonStreams, IncrementButtonBloc, WeatherAppRedux }
