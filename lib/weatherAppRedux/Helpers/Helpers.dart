import 'package:flutter/material.dart';

double getWindowWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getWindowHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
