import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app/features/search/models/weather_model.dart';

class WeatherService {
  late  Dio _dio;
  final String _baseUrl = 'http://api.weatherapi.com/v1/';
  final String _apiKey = dotenv.env['apiKey']!;

  WeatherService(){
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
     _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );
  }

  //http://api.weatherapi.com/v1/search.json?key=177f816c47b541f2893114052262009&q=London
  Future<List<WeatherModel>> searchCity(String cityName) async {
    try {
      final response = await _dio.get('search.json', queryParameters: {
        'key': _apiKey,
        'q': cityName,
      });
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => WeatherModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }
}