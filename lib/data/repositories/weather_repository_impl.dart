import 'package:clean_architech/data/datasources/weather_local_data_source.dart';
import 'package:clean_architech/data/datasources/weather_remote_data_source.dart';
import 'package:clean_architech/domain/entities/weather.dart';
import 'package:clean_architech/domain/repositories/weather_repository.dart';
import 'package:clean_architech/platform/network_info.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({
    required this.networkInfo,
    required this.weatherLocalDataSource,
    required this.weatherRemoteDataSource,
  });

  final WeatherRemoteDataSource weatherRemoteDataSource;
  final WeatherLocalDataSource weatherLocalDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Weather?> getCurrentWeather(String cityName) async {
    try {
      final isOnline = await networkInfo.isConnected;
      if (isOnline) {
        final weather =
            await weatherRemoteDataSource.getCurrentWeather(cityName);
        await weatherLocalDataSource.cacheWeather(weather!);
        return weather.toEntity();
      } else {
        final weather = await weatherLocalDataSource.getLastWeather(cityName);
        // weatherRemoteDataSource.getCurrentWeather(cityName);
        return weather?.toEntity();
      }
    } catch (_) {
      rethrow;
    }
  }
}
