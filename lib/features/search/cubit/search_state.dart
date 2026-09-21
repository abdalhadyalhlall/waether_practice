part of 'search_cubit.dart';

@immutable
sealed class SearchState {
}

final class SearchInitial extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchSuccessState extends SearchState {
  final List<WeatherModel> weatherList;

  SearchSuccessState(this.weatherList);
}

final class SearchErrorState extends SearchState {
  final String errorMessage;

  SearchErrorState(this.errorMessage);
}

