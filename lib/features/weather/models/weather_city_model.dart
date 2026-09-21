class WeatherCityModel {
  /*
  {
"location": {
"name": "London",
"region": "City of London, Greater London",
"country": "United Kingdom",
"lat": 51.5171,
"lon": -0.1062,
"tz_id": "Europe/London",
"localtime_epoch": 1789925751,
"localtime": "2026-09-20 18:35"
},
"current": {
"last_updated_epoch": 1789924500,
"last_updated": "2026-09-20 18:15",
"temp_c": 19.4,
"temp_f": 66.9,
"is_day": 1,
"condition": {
"text": "Overcast",
"icon": "//cdn.weatherapi.com/weather/64x64/day/122.png",
"code": 1009
},
"wind_mph": 6.3,
"wind_kph": 10.1,
"wind_degree": 314,
"wind_dir": "NW",
"pressure_mb": 1028,
"pressure_in": 30.36,
"precip_mm": 0,
"precip_in": 0,
"humidity": 35,
"cloud": 100,
"feelslike_c": 16,
"feelslike_f": 60.8,
"windchill_c": 19.4,
"windchill_f": 66.9,
"heatindex_c": 19.4,
"heatindex_f": 66.9,
"dewpoint_c": 3.5,
"dewpoint_f": 38.4,
"vis_km": 10,
"vis_miles": 6,
"uv": 0.2,
"gust_mph": 9.2,
"gust_kph": 14.8,
"will_it_rain": 0,
"chance_of_rain": 10,
"will_it_snow": 0,
"chance_of_snow": 0,
"wetbulb_c": 11.3,
"wetbulb_f": 52.3,
"short_rad": 426.88,
"diff_rad": 99.11,
"dni": 0,
"gti": 0
},
"forecast": {
"forecastday": [
{
"date": "2026-09-20",
"date_epoch": 1789862400,
"day": {
"maxtemp_c": 20.3,
"maxtemp_f": 68.6,
"mintemp_c": 14.8,
"mintemp_f": 58.6,
"avgtemp_c": 17.3,
"avgtemp_f": 63.1,
"maxwind_mph": 11.2,
"maxwind_kph": 18,
"totalprecip_mm": 0.02,
"totalprecip_in": 0,
"totalsnow_cm": 0,
"avgvis_km": 10,
"avgvis_miles": 6,
"avghumidity": 55,
"daily_will_it_rain": 0,
"daily_chance_of_rain": 11,
"daily_will_it_snow": 0,
"daily_chance_of_snow": 0,
"condition": {
"text": "Overcast",
"icon": "//cdn.weatherapi.com/weather/64x64/day/122.png",
"code": 1009
},
"uv": 3.2,
"avgwetbulb_c": 12.1,
"avgwetbulb_f": 53.7,
"maxwetbulb_c": 14.3,
"maxwetbulb_f": 57.8
},
"astro": {
"sunrise": "06:43 AM",
"sunset": "07:04 PM",
"moonrise": "05:03 PM",
"moonset": "Does not set today",
"moon_phase": "Waxing Gibbous",
"moon_illumination": 73,
"is_moon_up": 1,
"is_sun_up": 1
},
"hour": [
{
"time_epoch": 1789858800,
"time": "2026-09-20 00:00",
"temp_c": 17.3,
"temp_f": 63.1,
"is_day": 0,
"condition": {
"text": "Partly Cloudy",
"icon": "//cdn.weatherapi.com/weather/64x64/night/116.png",
"code": 1003
},
"wind_mph": 11.2,
"wind_kph": 18,
"wind_degree": 257,
"wind_dir": "WSW",
"pressure_mb": 1020,
"pressure_in": 30.12,
"precip_mm": 0,
"precip_in": 0,
"snow_cm": 0,
"humidity": 73,
"cloud": 25,
"feelslike_c": 14.5,
"feelslike_f": 58.1,
"windchill_c": 17.3,
"windchill_f": 63.1,
"heatindex_c": 17.3,
"heatindex_f": 63.1,
"dewpoint_c": 12.3,
"dewpoint_f": 54.2,
"will_it_rain": 0,
"chance_of_rain": 8,
"will_it_snow": 0,
"chance_of_snow": 0,
"vis_km": 10,
"vis_miles": 6,
"gust_mph": 25.1,
"gust_kph": 40.4,
"uv": 0,
"wetbulb_c": 14.3,
"wetbulb_f": 57.8,
"short_rad": 0,
"diff_rad": 0,
"dni": 0,
"gti": 0
},
{

   */
  final String CityName;
  final String date;
  final String conditionText;
  final String conditionIcon;
  final num MaxtempC;
  final num MintempC;
  final num AvgtempC;
  final String country;
  final List<dynamic> hour;
  final String sunrise;
  final String sunset;
  final num uv;
  final int airQualityIndex;

  WeatherCityModel({
    required this.CityName,
    required this.date,
    required this.conditionText,
    required this.conditionIcon,
    required this.MaxtempC,
    required this.MintempC,
    required this.AvgtempC,
    required this.country,
    required this.hour,
    required this.sunrise,
    required this.sunset,
    required this.uv,
    required this.airQualityIndex,
  });

  factory WeatherCityModel.fromJson(Map<String, dynamic> json,int dayIndex) {
    return WeatherCityModel(
      CityName: json['location']['name'],
      date: json['forecast']['forecastday'][dayIndex]['date'],
      conditionText: json['forecast']['forecastday'][dayIndex]['day']['condition']['text'],
      conditionIcon: json['forecast']['forecastday'][dayIndex]['day']['condition']['icon'],
      MaxtempC: json['forecast']['forecastday'][dayIndex]['day']['maxtemp_c'],
      MintempC: json['forecast']['forecastday'][dayIndex]['day']['mintemp_c'],
      AvgtempC: json['forecast']['forecastday'][dayIndex]['day']['avgtemp_c'],
      country: json['location']['country'],
      hour: json['forecast']['forecastday'][dayIndex]['hour'] as List<dynamic>,
      sunrise: json['forecast']['forecastday'][dayIndex]['astro']['sunrise'],
      sunset: json['forecast']['forecastday'][dayIndex]['astro']['sunset'],
      uv: json['forecast']['forecastday'][dayIndex]['day']['uv'],
      airQualityIndex: (json['current']['air_quality']?['us-epa-index'] ?? 0) as int,

    );
  }
}