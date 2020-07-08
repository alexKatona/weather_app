import 'dart:async';

import 'package:weather_app/incrementButtonScreenBloc/IncrementButtonBlocLogic.dart';
import 'package:weather_app/incrementButtonScreenBloc/IncrementButtonBlocViewState.dart';
import 'package:rxdart/rxdart.dart';

class IncrementButtonBlocBloc {
  // initialState
  static IncrementButtonBlocViewState _getInitialState() => IncrementButtonBlocViewState(0, 15.0);

  // Dependencies
  IncrementButtonBlocLogic _incrementLogic;

  // internal streams
  Observable<IncrementButtonBlocViewState> _counterStream = Observable.just(_getInitialState());

  // widget actions
  StreamController incrementClicked = StreamController();

  // getters
  Observable<IncrementButtonBlocViewState> get counterStream => _counterStream;

  // constructor
  IncrementButtonBlocBloc() {
    _incrementLogic = IncrementButtonBlocLogic();
    _counterStream = Observable(incrementClicked.stream)
        .scan(
            (int a, dynamic b, int i) => a + 1, // Add that 1 to the total
            0)
        .asyncMap((previous) => _incrementLogic.getIncrementedState(previous, 15.0))
        .map((logicState) => IncrementButtonBlocViewState(logicState.counterValue, logicState.counterSize))
        .startWith(_getInitialState())
        .asBroadcastStream();
  }

  void dispose() {
    incrementClicked.close();
  }
}
