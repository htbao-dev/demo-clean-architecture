import 'package:clean_architech/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather?> getCurrentWeather(String cityName);
}
