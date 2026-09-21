import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app/features/weather/models/weather_city_model.dart';
import 'package:weather_app/features/weather/repositry/weather_repo.dart';

class WeatherCityService {
  
  late  Dio _dio;
  final String _baseUrl = 'http://api.weatherapi.com/v1/';
  final String _pexelBaseUrl = 'https://api.pexels.com/v1';
  final String _apiKey = dotenv.env['apiKey']!;
  final String _pexelApiKey = dotenv.env['pexelApiKey']!;

  WeatherCityService(){
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
  //http://api.weatherapi.com/v1/forecast.json?key=177f816c47b541f2893114052262009&q=London&days=1&aqi=no&alerts=no
  Future<WeatherRepository> getWeatherByCity(String cityName) async {
    try {
      final results = await Future.wait([
        _dio.get('forecast.json', queryParameters: {
          'key': _apiKey,
          'q': cityName,
          'days': 8,
          'aqi': 'yes',
          'alerts': 'no',
        }),
        getWeatherImage(cityName),
      ]);
      final response = results[0] as Response;
      final imageUrl = results[1] as String;
      // final response = await _dio.get('forecast.json', queryParameters: {
      //   'key': _apiKey,
      //   'q': cityName,
      //   'days': 7,
      //   'aqi': 'no',
      //   'alerts': 'no',
      // });
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final forecastDays = data['forecast']['forecastday'] as List;
        final dataList = List<WeatherCityModel>.generate(
          forecastDays.length,
          (index) => WeatherCityModel.fromJson(data, index),
        );

        return WeatherRepository(weatherCityModel: dataList, CityImage: imageUrl);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }

  Future<String> getWeatherImage(String city) async {
    if( _pexelApiKey.isEmpty){
       return "";
    }
    try {
      final response = await _dio.get(
        '$_pexelBaseUrl/search',
        queryParameters: {
          'query': city,
          'per_page': 1,
        },
        options: Options(
          headers: {
            'Authorization': _pexelApiKey,
          },
        ),
      );

      if (response.statusCode == 200) {
        final photos = response.data['photos'] as List;
        if (photos.isNotEmpty) {
          return photos[0]['src']['portrait'] ;
        } else {
          throw Exception('No image found for the given query');
        }
      } else {
        throw Exception('Failed to load image data');
      }
    } catch (e) {
      throw Exception('Failed to load image data: $e');
    }
  }

}