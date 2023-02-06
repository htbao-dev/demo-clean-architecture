import 'package:clean_architech/data/datasources/weather_local_data_source.dart';
import 'package:clean_architech/data/datasources/weather_remote_data_source.dart';
import 'package:clean_architech/data/repositories/weather_repository_impl.dart';
import 'package:clean_architech/domain/repositories/weather_repository.dart';
import 'package:clean_architech/domain/usecases/get_current_weather.dart';
import 'package:clean_architech/domain/usecases/predict_rain.dart';
import 'package:clean_architech/platform/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

Widget coreDependencyInjection({required Widget child}) {
  return MultiProvider(
    providers: [
      Provider<NetworkInfo>(
        create: (_) => NetworkInfoImpl(
          connectivity: Connectivity(),
        ),
      ),
    ],
    child: child,
  );
}

Widget datasourceDependencyInjection({required Widget child}) {
  return MultiProvider(
    providers: [
      ProxyProvider0<WeatherLocalDataSource>(update: (context, _) {
        return WeatherLocalDataSourceImpl();
      }),
      ProxyProvider0<WeatherRemoteDataSource>(update: (context, _) {
        return WeatherRemoteDataSourceImpl(httpClient: http.Client());
      }),
    ],
    child: child,
  );
}

Widget repositoryDependencyInjection({required Widget child}) {
  return MultiProvider(
    providers: [
      ProxyProvider3<WeatherRemoteDataSource, WeatherLocalDataSource,
              NetworkInfo, WeatherRepository>(
          update: (context, weatherRemoteDataSource, weatherLocalDataSource,
                  networkInfo, _) =>
              WeatherRepositoryImpl(
                weatherRemoteDataSource: weatherRemoteDataSource,
                weatherLocalDataSource: weatherLocalDataSource,
                networkInfo: networkInfo,
              )),
    ],
    child: child,
  );
}

Widget usecaseDependencyInjection({required Widget child}) {
  return MultiProvider(
    providers: [
      ProxyProvider<WeatherRepository, GetCurrentWeather>(
        update: (context, weatherRepository, getCurrentWeather) =>
            GetCurrentWeather(
          weatherRepository: weatherRepository,
        ),
      ),
      ProxyProvider0<PredictRain>(
        update: (context, predictRain) => PredictRain(),
      )
    ],
    child: child,
  );
}
