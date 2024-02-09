import 'dart:convert';

import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApi {
  Dio dio = Dio();
  var weatherApi = dotenv.env['WEATHER_API'];
  Future<ResponseData<dynamic>> getWeatherData(double lat, lng) async {
    try {
      var response = await dio.get(
        "http://api.weatherapi.com/v1/current.json?key=$weatherApi&q=$lat,$lng&aqi=yes",
      );
      // log(response.toString());
      final responseData = jsonDecode(response.toString());

      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: responseData);
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
  }

  Future<ResponseData<dynamic>> getWeatherForecastData(double lat, lng) async {
    try {
      var response = await dio.get(
        "http://api.weatherapi.com/v1/forecast.json?key=$weatherApi&q=$lat,$lng&days=6&aqi=no&alerts=no",
      );
      // log(response.toString());
      final responseData = jsonDecode(response.toString());

      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: responseData);
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
  }
}
