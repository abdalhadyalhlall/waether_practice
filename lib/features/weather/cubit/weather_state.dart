part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoadingState extends WeatherState {}

final class WeatherSuccessState extends WeatherState {
  final WeatherRepository weatherModels;

  WeatherSuccessState(this.weatherModels);
}

final class WeatherErrorState extends WeatherState {
  final String errorMessage;

  WeatherErrorState(this.errorMessage);
} 

