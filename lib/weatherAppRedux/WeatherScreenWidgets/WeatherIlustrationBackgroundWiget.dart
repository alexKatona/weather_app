import 'package:flutter/material.dart';
import 'package:weather_app/weatherAppRedux/CustomWidgets/AppColors.dart';
import 'package:weather_app/weatherAppRedux/Helpers/Helpers.dart';

Widget getBackground(bool isDay, BuildContext context) {
  return Stack(
    children: <Widget>[
      getBackgroundDayNight(isDay, context),
      Align(
          alignment: Alignment.topCenter,
          child: Center(
              child: Image.asset(
            "assets/city_background.png",
            height: getWindowHeight(context),
          ))),
    ],
  );
}

Widget getBackgroundDayNight(bool isDay, BuildContext context) {
  return Opacity(
    child: SizedBox.fromSize(
      size: Size.fromHeight(getWindowHeight(context)),
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.8],
                  colors: [isDay ? AppColors.dayColor : AppColors.nightColor, AppColors.whiteColor]))),
    ),
    opacity: isDay ? 0.3 : 1.0,
  );
}
