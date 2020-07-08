import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/NavigationDrawerWidget.dart';

final Logger appLogger = Logger(
    filter: null,
    printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: false),
    output: null);

void main() {
  runApp(MaterialApp(
    home: MainAppScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

//TODO: extract strings into xml/json files once the libraries will be recommedent/stable/usable
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
