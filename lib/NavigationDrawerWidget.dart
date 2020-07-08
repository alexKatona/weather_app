import 'package:flutter/material.dart';
import 'package:weather_app/AppNavigator.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text("Archutecture examples by\n\nAlexander Katona - MBO 2018"),
          decoration: BoxDecoration(color: Colors.deepOrangeAccent),
        ),
        _createDrawerListItem(Icons.wc, "Redux increment button",
            "Implementing increment button example with redux including typedMiddlewares, typedReducers and business logic that mimics some Future calls",
            () {
          navigateTo(AppRoutes.IncrementButtonRedux, context);
        }),
        _createDrawerListItem(
            Icons.accessible, "Stream increment button", "Implementing increment button example with stream and stream friends",
            () {
          navigateTo(AppRoutes.IncrementButtonStreams, context);
        }),
        _createDrawerListItem(
            Icons.extension, "Bloc increment button", "Implementing increment button example with Bloc and streams", () {
          navigateTo(AppRoutes.IncrementButtonBloc, context);
        }),
        _createDrawerListItem(
            Icons.wb_sunny, "Redux", "Implementing weather app with redux and OpenWeather Api with current forecast and forecast", () {
          navigateTo(AppRoutes.WeatherAppRedux, context);
        })
      ],
    ),
  );
}

ListTile _createDrawerListItem(icon, title, subtitle, Function onTap) {
  return ListTile(
    contentPadding: EdgeInsets.all(20.0),
    leading: Icon(icon),
    title: Text(title),
    subtitle: Text(subtitle),
    onTap: onTap,
  );
}
