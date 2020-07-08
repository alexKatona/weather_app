import 'dart:async';

import 'package:weather_app/incrementButtonScreenBloc/IncrementButtonBlocLogicStates.dart';

class IncrementButtonBlocLogic {

  Future<IncrementButtonBlocLogicIncrementedState> getIncrementedState(int count, double counterSize) async {
    return IncrementButtonBlocLogicIncrementedState(count + 1, counterSize + 2.0);
  }

}
