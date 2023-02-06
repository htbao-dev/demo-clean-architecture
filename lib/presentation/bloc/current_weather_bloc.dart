import 'dart:async';

import 'package:clean_architech/domain/entities/weather.dart';
import 'package:clean_architech/domain/usecases/get_current_weather.dart';
import 'package:clean_architech/domain/usecases/predict_rain.dart';

class CurrentWeatherBloc {
  final GetCurrentWeather getCurrentWeather;
  final PredictRain predictRain;
  CurrentWeatherBloc(
      {required this.predictRain, required this.getCurrentWeather});

  final StreamController<Weather> _weatherStreamController =
      StreamController<Weather>();

  Stream<Weather> get weatherStream => _weatherStreamController.stream;

  void onCityChanged(String city) async {
    final weather = await getCurrentWeather(city);
    if (weather != null) {
      _weatherStreamController.sink.add(weather);
    } else {
      _weatherStreamController.sink.addError('No weather found');
    }
  }

  void dispose() {
    _weatherStreamController.close();
  }
}
