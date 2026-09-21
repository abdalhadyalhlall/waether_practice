import 'package:flutter/material.dart';
import 'package:weather_app/core/const.dart';
import 'package:weather_app/core/routs/routes.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:const BoxDecoration(
          gradient: backgroundGradient,
        ),
        child:  SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child:
              Column(children: [
                const Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Image(image:  AssetImage('assets/images/icon_weather.png'),
                  width: 300,height: 300,
                    )
                ),
                 const Text('Weather',style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold,color: Colors.white)   ) ,
                 const Text('Forecasts',style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold,color: Colors.yellow)   ),    
                 const SizedBox(height: 70,),                   
                 ElevatedButton(
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10)
                 ),
                  onPressed: (){
                  Navigator.pushNamed(context, Routes.home);
                 },
                 
                  child:  const Text('Get Started',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,))
                  )    
               
                ],)),
          ),
            ),
      )
    );
    
  }
}