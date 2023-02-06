import 'package:clean_architech/data/datasources/weather_local_data_source.dart';
import 'package:clean_architech/data/datasources/weather_remote_data_source.dart';
import 'package:clean_architech/domain/entities/weather.dart';
import 'package:clean_architech/domain/repositories/weather_repository.dart';
import 'package:clean_architech/domain/usecases/get_current_weather.dart';
import 'package:clean_architech/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_current_weather_test.mocks.dart';

@GenerateMocks([
  WeatherRepository,
  WeatherLocalDataSource,
  WeatherRemoteDataSource,
  NetworkInfo,
])
void main() {
  late GetCurrentWeather usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(weatherRepository: mockWeatherRepository);
  });

  test('get current weather from repo', () async {
    const tWeather = Weather(
      cityName: 'London',
      temperature: 10.0,
      humidity: 10.0,
    );
    // arrange
    when(mockWeatherRepository.getCurrentWeather('London'))
        .thenAnswer((_) async => tWeather);

    // act
    final result = await usecase('London');

    // assert
    expect(result, equals(tWeather));
  });

  test('return null', () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather('London'))
        .thenAnswer((_) async => null);

    // act
    final result = await usecase('London');

    // assert
    expect(result, equals(null));
  });
}
