import 'package:flutter/material.dart';
import 'package:weather_app/NavigationDrawerWidget.dart';
import 'package:weather_app/weatherAppRedux/WeatherScreen.dart';

void main() {
  runApp(MaterialApp(
    home: MainAppScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter architecture examples")),
      drawer: buildDrawer(context),
      body: Center(
        child: Text("Choose an architecture example from drawer"),
      ),
    );
  }
}
