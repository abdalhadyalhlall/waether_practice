import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/core/utils/handle_dio_error.dart';
import 'package:weather_app/features/weather/repositry/weather_repo.dart';
import 'package:weather_app/features/weather/services/weather_city_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherCityService weatherCityModel;
  WeatherCubit(this.weatherCityModel) : super(WeatherInitial());

  Future<void> getWeather(String cityName)async{
    emit(WeatherLoadingState());
    try{
      final  weatherModels = await weatherCityModel.getWeatherByCity(cityName);
      emit(WeatherSuccessState(weatherModels ));
      //for weak internet connection, we can use cached data from local storage
    }on DioException catch (errorMessage) {
      emit(WeatherErrorState(handleDioError(errorMessage)));}
     catch (e) {
      emit(WeatherErrorState(e.toString()));
    }
  }
}
