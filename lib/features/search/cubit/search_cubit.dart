import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/features/search/models/weather_model.dart';
import 'package:weather_app/features/search/services/weather_service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {

  final WeatherService _weatherService;
  SearchCubit(this._weatherService) : super(SearchInitial());

  Future<void> searchCity(String cityName) async {
   final String trimmedCityName = cityName.trim();
   if (trimmedCityName.isEmpty || trimmedCityName.length < 3) {
      emit(SearchErrorState('City name cannot be empty'));
      return;
    }
    emit(SearchLoadingState());
    try{
      final List<WeatherModel> weatherList = await _weatherService.searchCity(  trimmedCityName);
      emit(SearchSuccessState(weatherList));
    }catch(e){
      emit(SearchErrorState(e.toString()));
    }
  }

  void resetState() {
    emit(SearchInitial());
  }

}
