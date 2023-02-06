import 'package:clean_architech/di.dart';
import 'package:clean_architech/presentation/ui/current_weather_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return coreDependencyInjection(
      child: datasourceDependencyInjection(
        child: repositoryDependencyInjection(
          child: usecaseDependencyInjection(
            child: const MaterialApp(
              home: CurrentWeatherScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
