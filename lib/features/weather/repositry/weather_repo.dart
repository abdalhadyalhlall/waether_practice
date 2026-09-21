import 'package:weather_app/features/weather/models/weather_city_model.dart';

class WeatherRepository {
  final List<WeatherCityModel> weatherCityModel;
  final String CityImage;

  WeatherRepository({required this.weatherCityModel, required this.CityImage});
   
 }