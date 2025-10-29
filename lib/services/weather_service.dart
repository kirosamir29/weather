import 'dart:math';

import 'package:dio/dio.dart';
import 'package:weather/models/weather_model.dart';

class WeatherService {
  final Dio dio;

  WeatherService(this.dio);

  final String baseUrl = "https://api.weatherapi.com/v1";
  final String apiKey = "68c6d5eff04b408d8fb174244252610&q";

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio.get(
        "$baseUrl/forecast.json?key=$apiKey=$cityName&days=1",
      );
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['error']['message'] ??
          "there was an error, try later";
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception("there was an error, try later");
    }
  }
}
