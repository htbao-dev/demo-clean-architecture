import 'package:clean_architech/domain/entities/weather.dart';
import 'package:clean_architech/domain/usecases/get_current_weather.dart';
import 'package:clean_architech/domain/usecases/predict_rain.dart';
import 'package:clean_architech/presentation/bloc/current_weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentWeatherScreen extends StatelessWidget {
  const CurrentWeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyProvider2<PredictRain, GetCurrentWeather, CurrentWeatherBloc>(
      update: (context, predictRain, getCurrentWeather, currentWeatherBloc) =>
          CurrentWeatherBloc(
        predictRain: predictRain,
        getCurrentWeather: getCurrentWeather,
      ),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Weather',
              style: TextStyle(color: Colors.orange),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Enter city name',
                  ),
                  onChanged: (query) {
                    context.read<CurrentWeatherBloc>().onCityChanged(query);
                  },
                ),
                const SizedBox(height: 32.0),
                StreamBuilder(
                    stream: context.read<CurrentWeatherBloc>().weatherStream,
                    initialData: null,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Weather weather = snapshot.data as Weather;
                        return Column(
                          key: const Key('weather_data'),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  weather.cityName,
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                  ),
                                ),
                                // Image(
                                //   image: NetworkImage(
                                //     Urls.weatherIcon(
                                //       state.result.iconCode,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            // Text(
                            //   '${state.result.main} | ${state.result.description}',
                            //   style: const TextStyle(
                            //     fontSize: 16.0,
                            //     letterSpacing: 1.2,
                            //   ),
                            // ),
                            const SizedBox(height: 24.0),
                            Table(
                              defaultColumnWidth: const FixedColumnWidth(150.0),
                              border: TableBorder.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                              children: [
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Temperature',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      weather.temperature.toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ), // Will be change later
                                ]),
                                // TableRow(children: [
                                //   Padding(
                                //     padding: EdgeInsets.all(8.0),
                                //     child: Text(
                                //       'Pressure',
                                //       style: TextStyle(
                                //         fontSize: 16.0,
                                //         letterSpacing: 1.2,
                                //       ),
                                //     ),
                                //   ),
                                //   Padding(
                                //     padding: EdgeInsets.all(8.0),
                                //     child: Text(
                                //       weather.pressure.toString(),
                                //       style: TextStyle(
                                //           fontSize: 16.0,
                                //           letterSpacing: 1.2,
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //   ), // Will be change later
                                // ]),
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Humidity',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      weather.humidity.toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ), // Will be change later
                                ]),
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrong!'),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
