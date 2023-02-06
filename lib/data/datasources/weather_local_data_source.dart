import 'package:clean_architech/data/models/weather_model.dart';

abstract class WeatherLocalDataSource {
  Future<WeatherModel?> getLastWeather(String cityName);
  Future<void> cacheWeather(WeatherModel weather);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  @override
  Future<WeatherModel?> getLastWeather(String cityName) async {
    return const WeatherModel(
        id: 'offline', cityName: 'Offline', temperature: 25, humidity: 30);
  }

  @override
  Future<void> cacheWeather(WeatherModel weather) async {}
}
