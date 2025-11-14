import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather/views/home_view.dart';

void main() {
  runApp(Weather());
}

class Weather extends StatelessWidget {
  const Weather({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<GetWeatherCubit, WeatherState>(
            builder: (context, state) => MaterialApp(
              theme: ThemeData(
                primarySwatch: getWeatherColorByDay(
                  BlocProvider.of<GetWeatherCubit>(
                    context,
                  ).weatherModel?.weatherCondition,
                ),
              ),
              debugShowCheckedModeBanner: false,
              home: HomeView(),
            ),
          );
        },
      ),
    );
  }
}

MaterialColor getWeatherColorByDay(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  switch (condition.toLowerCase()) {
    case 'sunny':
      return Colors.orange;

    case 'clear':
      return Colors.blue;

    case 'partly cloudy':
    case 'snow':
    case 'light snow':
    case 'moderate snow':
    case 'heavy snow':
      return Colors.lightBlue;

    case 'cloudy':
    case 'overcast':
      return Colors.blueGrey;

    case 'mist':
    case 'fog':
      return Colors.grey;

    case 'patchy rain possible':
    case 'light rain':
    case 'moderate rain':
    case 'heavy rain':
    case 'rain shower':
      return Colors.indigo;

    case 'sleet':
    case 'ice pellets':
      return Colors.teal;

    case 'thundery outbreaks possible':
    case 'rain with thunder':
    case 'snow with thunder':
      return Colors.deepPurple;

    default:
      return Colors.blueGrey;
  }
}
