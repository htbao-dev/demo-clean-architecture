import 'package:clean_architech/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architech/data/models/weather_model.dart';

void main() {
  const tWeatherModel = WeatherModel(
    cityName: 'London',
    temperature: 26.0,
    humidity: 60.0,
    id: '1',
  );

  const tWeather = Weather(
    cityName: 'London',
    temperature: 26.0,
    humidity: 60.0,
  );
  group('to entity', () {
    test('should return weather entity', () {
      // assert
      expect(tWeatherModel.toEntity(), tWeather);
    });
  });

  group('to json', () {
    test('should return json map', () {
      // assert
      expect(tWeatherModel.toJson(), {
        'cityName': 'London',
        'temperature': 26.0,
        'humidity': 60.0,
        'id': '1',
      });
    });
  });

  group('from json', () {
    test('should return weather model', () {
      // act
      final result = WeatherModel.fromJson(const {
        'cityName': 'London',
        'temperature': 26.0,
        'humidity': 60.0,
        'id': '1'
      });

      // assert
      expect(result, tWeatherModel);
    });
  });
}
