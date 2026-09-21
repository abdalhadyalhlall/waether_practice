class WeatherModel {
  /*
   {
        "id": 2801268,
        "name": "London",
        "region": "City of London, Greater London",
        "country": "United Kingdom",
        "lat": 51.52,
        "lon": -0.11,
        "url": "london-city-of-london-greater-london-united-kingdom"
    },
   */
  final int  id;
  final String name;
  final String region;  
  final String country;
  final double lat;   
  final double lon;
  final String url;

  WeatherModel({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json['id'],
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      url: json['url'],
    );
  }
}