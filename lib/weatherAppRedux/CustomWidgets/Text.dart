import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/weatherAppRedux/CustomWidgets/AppColors.dart';

class TextH0 extends Text {
  TextH0(String data) : super(data, style: TextStyle(color: AppColors.primaryColor, fontSize: 28.0));
}

class TextOpenWeatherLogo extends Text {
  TextOpenWeatherLogo(String data)
      : super(data, style: TextStyle(color: Colors.black, fontSize: 16.0, fontStyle: FontStyle.italic));
}

class TextTemperature extends Text {
  TextTemperature(String data)
      : super(data, style: TextStyle(color: AppColors.primaryColor, fontSize: 64.0, fontStyle: FontStyle.normal));
}

class TextB0 extends Text {
  TextB0(String data) : super(data, style: TextStyle(color: Colors.black, fontSize: 16.0));
}
