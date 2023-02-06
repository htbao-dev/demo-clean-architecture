import 'package:clean_architech/domain/entities/weather.dart';
import 'package:clean_architech/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository weatherRepository;

  GetCurrentWeather({required this.weatherRepository});

  Future<Weather?> call(String cityName) async {
    return await weatherRepository.getCurrentWeather(cityName);
  }
}
