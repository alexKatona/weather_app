import 'package:weather_app/incrementButtonScreenRedux/IncrementButtonActions.dart';
import 'package:weather_app/incrementButtonScreenRedux/IncrementButtonLogic.dart';
import 'package:weather_app/incrementButtonScreenRedux/IncrementButtonMwIncrementState.dart';
import 'package:weather_app/incrementButtonScreenRedux/IncrementButtonState.dart';
import 'package:redux/redux.dart';

/// class where all the logic should happen like storing to database, api calls or some calculations

List<Middleware<IncrementButtonState>> createIncrementButtonStoreMiddleware = [
  TypedMiddleware<IncrementButtonState, Increment>(createIncrement),
];

createIncrement(Store<IncrementButtonState> store, Increment action, NextDispatcher next) {
  incrementCounter(store.state.counter, store.state.counterSize)
      .then((nextState) => next(IncrementButtonMwIncrementState(nextState.counterValue, nextState.counterSize)));
}
