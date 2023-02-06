import 'package:clean_architech/domain/entities/weather.dart';

class PredictRain {
  bool call(Weather weather) {
    if (weather.temperature > 25 && weather.humidity > 50) {
      return true;
    }
    return false;
  }
}
