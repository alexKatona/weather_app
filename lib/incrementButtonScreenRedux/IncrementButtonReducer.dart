import 'package:weather_app/incrementButtonScreenRedux/IncrementButtonMiddleware.dart';
import 'package:weather_app/incrementButtonScreenRedux/IncrementButtonMwIncrementState.dart';
import 'package:weather_app/incrementButtonScreenRedux/IncrementButtonState.dart';
import 'package:redux/redux.dart';

final Reducer<IncrementButtonState> _counterReducer =
    combineReducers([TypedReducer<IncrementButtonState, IncrementButtonMwIncrementState>(_mwIncrementReducer)]);

final _mwIncrementReducer = (IncrementButtonState state, IncrementButtonMwIncrementState partialState) =>
    state.copyWith(counter: partialState.counterValue, counterSize: partialState.counterSize);

Store createIncrementButtonStore() {
  return new Store<IncrementButtonState>(_counterReducer,
      initialState: IncrementButtonState.initial(), middleware: createIncrementButtonStoreMiddleware);
}
