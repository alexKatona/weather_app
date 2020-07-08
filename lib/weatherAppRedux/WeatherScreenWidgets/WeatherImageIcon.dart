import 'package:flutter/material.dart';

Widget createWeatherImageIconWidget(String url) {
  if (url != null) {
    return Image.network(url);
  } else {
    return Text("Unknown");
  }
}
