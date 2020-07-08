import 'dart:async';

import 'package:weather_app/incrementButtonScreenRedux/IncrementButtonMwIncrementState.dart';

Future<IncrementButtonMwIncrementState> incrementCounter(int previousCounterValue, double previousCounterSize) async {
  return IncrementButtonMwIncrementState(previousCounterValue + 1, previousCounterSize + 2);
}