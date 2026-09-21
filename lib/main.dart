import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/weather.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}
//177f816c47b541f2893114052262009