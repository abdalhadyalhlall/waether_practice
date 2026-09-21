
import 'package:flutter/material.dart';
import 'package:weather_app/core/routs/app_routers.dart';
import 'package:weather_app/core/routs/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'weather app',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouters().generateRoute,
      initialRoute: Routes.intro,

      onUnknownRoute: (settings){
        return MaterialPageRoute(builder:(context)=>const Scaffold(body: Center(child: Text('Page Not Found')),));
      }
    );
  }
}
