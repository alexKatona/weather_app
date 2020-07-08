import 'package:weather_app/weatherAppRedux/WeatherMiddleware.dart';
import 'package:weather_app/weatherAppRedux/WeatherViewState.dart';
import 'package:redux/redux.dart';

class AnimationsEpicReduxReducer {
  final List<Middleware<AnimationEpicReduxViewState>> middlewares;

  AnimationsEpicReduxReducer(this.middlewares);

  Reducer<AnimationEpicReduxViewState> _animationsEpicReduxReducers() {
    return combineReducers([
      TypedReducer<AnimationEpicReduxViewState, AnimationsEpicReduxMwWeatherUpdatedPartialState>(_updateWeatherReducer),
      TypedReducer<AnimationEpicReduxViewState, Loading>(_loadingReducer),
      TypedReducer<AnimationEpicReduxViewState, NoInternetConnection>(_internetErrorReducer),
      TypedReducer<AnimationEpicReduxViewState, WeatherMwForecastPartialState>(_updateForecastReducer)
    ]);
  }

  AnimationEpicReduxViewState _updateForecastReducer(
      AnimationEpicReduxViewState viewState, WeatherMwForecastPartialState partialState) {
    return viewState.copyWith(forecast: _convertMwStateToViewState(partialState.forecast));
  }

  AnimationEpicReduxViewState _internetErrorReducer(AnimationEpicReduxViewState viewState, NoInternetConnection partialState) {
    return viewState.copyWith(isInternetError: true);
  }

  AnimationEpicReduxViewState _loadingReducer(AnimationEpicReduxViewState viewState, Loading partialState) {
    return viewState.copyWith(isLoading: true, isInternetError: false);
  }

  AnimationEpicReduxViewState _updateWeatherReducer(
      AnimationEpicReduxViewState viewState, AnimationsEpicReduxMwWeatherUpdatedPartialState partialState) {
    return viewState.copyWith(
        weatherIcon: partialState.weatherIcon,
        temperature: partialState.temperature,
        isLoading: false,
        isDay: partialState.isDay,
        humidity: partialState.humidity,
        pressureHpa: partialState.pressureHpa,
        visibilityMeters: partialState.visibilityMeters,
        cloudlinessPercentage: partialState.cloudlinessPercentage,
        windSpeed: partialState.windSpeed,
        windDegree: partialState.windDegree,
        isInternetError: false);
  }

  Store createAnimationsEpicReduxStore() {
    return Store<AnimationEpicReduxViewState>(_animationsEpicReduxReducers(),
        initialState: AnimationEpicReduxViewState.initial(), middleware: middlewares);
  }

  /// converting mw state to uiState
  WsForecast _convertMwStateToViewState(Map<DateTime, MwForeCastForDay> forecast) {
    return WsForecast(forecast.map((key, value) => MapEntry(
        key,
        WsForeCastForDay(value.hourlyForecast
            .map((item) => WsForecastForHour(item.temperature, item.pressuremPa, item.humidityPercentage, item.weatherIcon,
                item.cloudsPercentage, item.windSpeed, item.windDegree, item.date))
            .toList()))));
  }
}
