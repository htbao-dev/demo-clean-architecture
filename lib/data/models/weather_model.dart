import 'package:clean_architech/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  final String id;
  final String cityName;
  final double temperature;
  final double humidity;

  const WeatherModel({
    required this.id,
    required this.cityName,
    required this.temperature,
    required this.humidity,
  });

  Weather toEntity() {
    return Weather(
      cityName: cityName,
      temperature: temperature,
      humidity: humidity,
    );
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json['id'],
      cityName: json['cityName'],
      temperature: json['temperature'].toDouble(),
      humidity: json['humidity'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cityName': cityName,
      'temperature': temperature,
      'humidity': humidity,
    };
  }

  @override
  List<Object?> get props => [id, cityName, temperature, humidity];
}
