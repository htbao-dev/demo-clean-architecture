import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;
  final double humidity;

  const Weather(
      {required this.cityName,
      required this.temperature,
      required this.humidity});

  @override
  List<Object?> get props => [cityName, temperature, humidity];
}
