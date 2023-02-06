import 'package:clean_architech/domain/entities/weather.dart';
import 'package:clean_architech/domain/usecases/predict_rain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PredictRain usecase;

  setUp(() {
    usecase = PredictRain();
  });

  test('will rain', () {
    const tWeather = Weather(
      cityName: 'London',
      temperature: 26.0,
      humidity: 60.0,
    );

    expect(usecase(tWeather), true);
  });

  test('will not rain', () {
    const tWeather = Weather(
      cityName: 'London',
      temperature: 10.0,
      humidity: 10.0,
    );

    expect(usecase(tWeather), false);
  });
}
