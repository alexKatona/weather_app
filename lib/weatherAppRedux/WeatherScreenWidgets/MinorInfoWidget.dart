import 'package:flutter/material.dart';
import 'package:weather_app/weatherAppRedux/CustomWidgets/IconSkinned.dart';
import 'package:weather_app/weatherAppRedux/WeatherViewState.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vector_math/vector_math_64.dart' as vectorMath;

Widget getAdditionalInfo(AnimationEpicReduxViewState widgetState) {
  if (widgetState.isInternetError || widgetState.isLoading) {
    return Container();
  } else {
    return Row(
      children: <Widget>[
        createIconInfoWidget("${widgetState.humidity ?? 0}%", MdiIcons.waterPercent),
        createIconInfoWidget("${widgetState.pressureHpa ?? 0}hPa", MdiIcons.speedometer),
        createIconInfoWidget(
            "${widgetState.visibilityMeters == null ? 0 : widgetState.pressureHpa / 1000}km", MdiIcons.binoculars),
        createIconInfoWidget("${widgetState.cloudlinessPercentage ?? 0}%", MdiIcons.weatherCloudy),
        createIconInfoWidget("${widgetState.windSpeed ?? 0}m/s", MdiIcons.weatherWindy,
            rotationDegrees: (widgetState.windDegree?.toDouble() ?? 0.0) - 90.0) // rotate the icon to north (-90.0)
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}

Widget createIconInfoWidget(String text, IconData icon, {double rotationDegrees = 0.0}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Transform(
          alignment: FractionalOffset.center,
          transform: new Matrix4.rotationZ(vectorMath.radians(rotationDegrees)),
          child: IconV1(icon)),
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(text),
      )
    ],
  );
}
