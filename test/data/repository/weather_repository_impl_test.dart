import 'package:clean_architech/data/datasources/weather_local_data_source.dart';
import 'package:clean_architech/data/datasources/weather_remote_data_source.dart';
import 'package:clean_architech/data/models/weather_model.dart';
import 'package:clean_architech/data/repositories/weather_repository_impl.dart';
import 'package:clean_architech/domain/entities/weather.dart';
import 'package:clean_architech/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([
  WeatherLocalDataSource,
  WeatherRemoteDataSource,
  NetworkInfo,
])
void main() {
  late MockWeatherLocalDataSource mockWeatherLocalDataSource;
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  String tCity = 'London';
  const tWeatherModel = WeatherModel(
    cityName: '',
    humidity: 0.0,
    id: '',
    temperature: 1,
  );
  setUp(() {
    mockWeatherLocalDataSource = MockWeatherLocalDataSource();
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    weatherRepositoryImpl = WeatherRepositoryImpl(
      networkInfo: mockNetworkInfo,
      weatherLocalDataSource: mockWeatherLocalDataSource,
      weatherRemoteDataSource: mockWeatherRemoteDataSource,
    );
    when(mockWeatherRemoteDataSource.getCurrentWeather(tCity))
        .thenAnswer((_) async => tWeatherModel);
    when(mockWeatherLocalDataSource.getLastWeather(tCity))
        .thenAnswer((_) async => tWeatherModel);
  });

  test('test when devices is online', () async {
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

    // act
    final data = await weatherRepositoryImpl.getCurrentWeather(tCity);

    // assert
    expect(data, isA<Weather?>());

    verify(mockWeatherRemoteDataSource.getCurrentWeather(tCity));
    verify(mockWeatherLocalDataSource.cacheWeather(tWeatherModel));
    verify(mockNetworkInfo.isConnected);
  });

  test('test when devices is offline', () async {
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

    // act
    final data = await weatherRepositoryImpl.getCurrentWeather(tCity);

    // assert
    expect(data, isA<Weather?>());
    verify(mockWeatherLocalDataSource.getLastWeather(tCity));
    verifyZeroInteractions(mockWeatherRemoteDataSource);
    verify(mockNetworkInfo.isConnected);
  });

  test('online but throw exception', () async {
    // arrange

    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockWeatherRemoteDataSource.getCurrentWeather(tCity))
        .thenThrow(Exception());

    // act
    final data = weatherRepositoryImpl.getCurrentWeather(tCity);

    // assert
    expect(data, throwsException);
    // verify(mockWeatherRemoteDataSource.getCurrentWeather(tCity));
    // verify(mockNetworkInfo.isConnected);
  });
}
