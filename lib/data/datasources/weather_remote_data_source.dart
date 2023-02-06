import 'dart:math';

import 'package:clean_architech/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel?> getCurrentWeather(String city);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client httpClient;

  WeatherRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<WeatherModel?> getCurrentWeather(String city) async {
    final ran = Random();
    return WeatherModel(
        id: ran.nextInt(10).toString(),
        cityName: 'Hue',
        temperature: ran.nextInt(100).toDouble(),
        humidity: ran.nextInt(100).toDouble());
  }
}
