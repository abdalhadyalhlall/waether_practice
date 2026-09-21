import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/const.dart';
import 'package:weather_app/core/routs/routes.dart';
import 'package:weather_app/features/search/cubit/search_cubit.dart';
import 'package:weather_app/features/search/models/weather_model.dart';
import 'package:weather_app/features/search/services/weather_service.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? debounce;
  @override
  void dispose() {
    _searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query, SearchCubit cubit) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      cubit.searchCity(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(WeatherService()),
      child: Builder(builder: (context) {
        final cubit = context.read<SearchCubit>();
        final screenSize = MediaQuery.sizeOf(context);

        void onCitySelected(WeatherModel weatherModel, SearchCubit cubit) {
          _searchController.text = weatherModel.name;
          cubit.searchCity(weatherModel.name);
          context.read<SearchCubit>().resetState();
          Navigator.pushNamed(context, Routes.weather, arguments: weatherModel);
        }

        return Scaffold(
            body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: backgroundGradient,
          ),
          child: SafeArea(
              child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Search',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                 Container(
                   width: screenSize.width * 0.8,
                    height: screenSize.height * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.2),
                    ) ,
                   child: Column(children: [
                   
                    TextField(
                      controller: _searchController,
                      onChanged: (query) => _onSearchChanged(query, cubit),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.textColor,
                        ),
                        hintText: 'Enter city name',
                        hintStyle: const TextStyle(color: AppColors.textColor),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color:Color( 0xFF000000)),
                    ),
                    BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        if(
                          cubit.state is SearchLoadingState
                        ){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(cubit.state is SearchErrorState){
                          return Center(
                            child: Text(
                              (cubit.state as SearchErrorState).errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }
                                   
                        else if(cubit.state is SearchSuccessState){
                          final cities= (cubit.state as SearchSuccessState).weatherList;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                   
                            itemCount: cities.length,
                            itemBuilder: (context, index) {
                              final city = cities[index];
                              return Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.location_on,color: AppColors.textColor,),
                                    title: Text(
                                      city.name,
                                      style: const TextStyle(color: AppColors.textColor),
                                    ),
                                    subtitle: Text(
                                      city.country,
                                      style: const TextStyle(color: AppColors.textColor),
                                    ),
                                    
                                    onTap: () => onCitySelected(city, cubit),
                                  ),
                                 const Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 16.0),
                                    child:  Divider(color: AppColors.textColor,),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        return  Container();
                      }
                    ),
                   
                    ],),
                 )
                ],
              ),
            ),
          )),
        ));
      }),
    );
  }
}
