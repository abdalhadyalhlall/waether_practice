import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/const.dart';
import 'package:weather_app/core/routs/routes.dart';
import 'package:weather_app/features/search/models/weather_model.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/services/weather_city_service.dart';

class WeatherView extends StatelessWidget {
  final WeatherModel city;

  const WeatherView({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WeatherCubit(WeatherCityService())..getWeather(city.name),
      child: Scaffold(body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          final image =state is WeatherSuccessState ?
          state.weatherModels.CityImage
          :"";
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: backgroundGradient,
            ),
            child:Stack(
              fit: StackFit.expand,
              children: [
                if (image.isNotEmpty)
                  CachedNetworkImage(
                  // image: AssetImage('assets/images/icon_weather.png'),
                  // if(image.isNotEmpty )
                  imageUrl:image ,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                    const SizedBox.shrink(),
                                    
                                
                ),
                Stack(
                  children: [
                    SafeArea(child: _buildBody(context, state)),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 12,
                      child: SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _bottomButton(Icons.location_on_outlined, () {}),
                            _bottomButton(Icons.add_circle_outline, () {}),
                            _bottomButton(Icons.menu, () {
                              if (state is WeatherSuccessState &&
                                  state.weatherModels.weatherCityModel
                                      .skip(1)
                                      .take(7)
                                      .isNotEmpty) {
                                Navigator.pushNamed(
                                  context,
                                  Routes.forecast,
                                  arguments: state.weatherModels,
                                );
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      )),
    );
  }


  
  Widget _buildBody(BuildContext context,WeatherState state){
   final screenSize = MediaQuery.sizeOf(context);

  if (state is WeatherLoadingState || state is WeatherInitial) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      }
  if(state is WeatherErrorState){
    return const Center(
      child: Image(image: AssetImage('assets/images/no_weather.png')),
    );
  }    
  if(state is WeatherSuccessState){
    final day=state.weatherModels.weatherCityModel.first;
    final forecast = state.weatherModels.weatherCityModel.skip(1).take(7).toList();
    
    final currentHour = DateTime.now().hour;
    final startIndex = day.hour.indexWhere((hour) {
      final hourDate = DateTime.parse(hour['time'] as String);
      return hourDate.hour >= currentHour;
    });
    final firstHourIndex = startIndex == -1 ? 0 : startIndex;
    final hours = day.hour.skip(firstHourIndex).take(4).toList();
    return SingleChildScrollView(
      child:  Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: CachedNetworkImage(
                                          imageUrl:'https:${day.conditionIcon}' ,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                            const SizedBox.shrink(),
                                      
                                        ),
                      ),
                    ),
                     Text(
                      '${day.AvgtempC}°C',
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor),
                    ),
                    const Text(
                      'Precipitations',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor),
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Max : ${day.MaxtempC}°C',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor),
                        ),
                       const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Min : ${day.MintempC}°C',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height*0.1,
                    ),
                   Container(
                      height: screenSize.height*0.3,
                      width:screenSize.width,
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      color: Colors.black.withOpacity(0.5),
                      ),
                      child:  Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Today",style: TextStyle(color: AppColors.textColor,fontSize: 20),),
                                 Text(day.date,style: const TextStyle(color: AppColors.textColor,fontSize: 20),),
                              ],
                            ),
                        
                          ),
                         const  Divider(),
                          SizedBox(
                            height: 115,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              itemCount: hours.length,
                              itemBuilder: (context, index) {
                                final hour = hours[index];
                                final dateTime = DateTime.parse(hour['time'] as String);
                                final time = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
                                final icon = hour['condition']['icon'] as String;
                                final imageUrl = icon.startsWith('//') ? 'https:$icon' : icon;
                                return SizedBox(
                                  width: screenSize.width / 4.4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(time, style: const TextStyle(color: AppColors.textColor)),
                                      Image.network(imageUrl, width: 42, height: 42),
                                      Text(
                                        '${hour['temp_c']}°C',
                                        style: const TextStyle(color: AppColors.textColor),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                        ),

                    ),
                   
                  ],
                ), 
    );
  }
      return Container();

}

  Widget _bottomButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white, size: 28),
    );
  }

}


