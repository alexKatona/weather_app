import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/api/WeatherApi.dart';
import 'package:weather_app/weatherAppRedux/CustomWidgets/AppColors.dart';
import 'package:weather_app/weatherAppRedux/WeatherActions.dart';
import 'package:weather_app/weatherAppRedux/WeatherLogic.dart';
import 'package:weather_app/weatherAppRedux/WeatherMiddleware.dart';
import 'package:weather_app/weatherAppRedux/WeatherReducer.dart';
import 'package:weather_app/weatherAppRedux/WeatherScreenWidgets/ForecastWidget.dart';
import 'package:weather_app/weatherAppRedux/WeatherScreenWidgets/MinorInfoWidget.dart';
import 'package:weather_app/weatherAppRedux/WeatherScreenWidgets/TemperatureWidget.dart';
import 'package:weather_app/weatherAppRedux/WeatherScreenWidgets/WeatherIlustrationBackgroundWiget.dart';
import 'package:weather_app/weatherAppRedux/WeatherViewState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class AnimationsEpicReduxWidget extends StatelessWidget {
  /// missing DI, horrible solution => should be reworked if there will be a proper solution/lib
  final Store store =
      AnimationsEpicReduxReducer(AnimationsEpicReduxMws(AnimationsEpicReduxLogic(WeatherApi())).createAnimationsEpicReduxMws())
          .createAnimationsEpicReduxStore();

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AnimationEpicReduxViewState>(
      store: store,
      child: new Scaffold(
        primary: true,
        body: RefreshIndicator(
            onRefresh: () => Future.delayed(Duration.zero).then((_) {
                  if (store.state is AnimationEpicReduxViewState &&
                      (store.state as AnimationEpicReduxViewState).forecast == null) {
                    store.dispatch(LoadForecastAction());
                  }
                  store.dispatch(UpdateWeatherAction());
                  return null;
                }),
            child: new StoreConnector<AnimationEpicReduxViewState, AnimationEpicReduxViewState>(
                converter: (store) => store.state,
                onInitialBuild: (viewState) {
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
                      statusBarColor: Colors.transparent,
                      systemNavigationBarColor: AppColors.primaryColor,
                      systemNavigationBarDividerColor: AppColors.primaryColor,
                      systemNavigationBarIconBrightness: Brightness.dark,
                      statusBarIconBrightness: Brightness.dark));
                  _dispatchEvent(UpdateWeatherAction());
                  return _dispatchEvent(LoadForecastAction());
                },
                builder: (context, widgetState) {
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Container(
                      decoration: BoxDecoration(color: AppColors.whiteColor),
                      child: ListView(
                        children: <Widget>[
                          Stack(children: [getBackground(widgetState.isDay, context), getWeatherBody(widgetState)]),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            child: getAdditionalInfo(widgetState),
                          ),
                          createForecastWidget(context, widgetState.forecast)
                        ],
                      ),
                    ),
                  );
                })),
      ),
    );
  }

  void _dispatchEvent(dynamic action){
    store.dispatch(action);
  }
}
