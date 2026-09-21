import 'package:flutter/material.dart';
import 'package:weather_app/core/routs/routes.dart';
import 'package:weather_app/features/intro/ui/screen/intro_view.dart';
import 'package:weather_app/features/search/models/weather_model.dart';
import 'package:weather_app/features/search/ui/views/search_view.dart';
import 'package:weather_app/features/weather/repositry/weather_repo.dart';
import 'package:weather_app/features/weather/ui/screens/forecast_view.dart';
import 'package:weather_app/features/weather/ui/screens/weather_view.dart';

class AppRouters {
  Route<dynamic>? generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
      case Routes.intro:
        return MaterialPageRoute(builder: (_)=> const IntroView());
      case Routes.home:
        return MaterialPageRoute(builder: (_)=> const SearchView());
      case Routes.weather:
        return MaterialPageRoute(builder: (_)=> WeatherView(city: settings.arguments as WeatherModel,));
      case Routes.forecast:
        return MaterialPageRoute(builder: (_) => ForecastView(
          weather: settings.arguments as WeatherRepository,
        ));
       default:
        return null;
    }
  }
}