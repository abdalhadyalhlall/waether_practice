import 'package:flutter/material.dart';
import 'package:weather_app/core/const.dart';
import 'package:weather_app/features/weather/repositry/weather_repo.dart';

class ForecastView extends StatelessWidget {
  final WeatherRepository weather;

  const ForecastView({super.key, required this.weather});

  String _iconUrl(String icon) {
    return icon.startsWith('//') ? 'https:$icon' : icon;
  }

  @override
  Widget build(BuildContext context) {
    final today = weather.weatherCityModel.first;
    final forecast = weather.weatherCityModel.skip(1).take(7).toList();
    final airQuality = _airQualityLabel(today.airQualityIndex);
    final uvLabel = _uvLabel(today.uv);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 8),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Text(
                  today.country,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  'Max: ${today.MaxtempC}°   Min: ${today.MintempC}°',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 26),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _sectionTitle('7-Days Forecasts'),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 112,
                  child: Row(
                    children: [
                      const Icon(Icons.chevron_left, color: Colors.white),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: forecast.length,
                          itemBuilder: (context, index) => _dayCard(forecast[index]),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _infoCard(
                  icon: Icons.air,
                  title: 'AIR QUALITY',
                  value: '${today.airQualityIndex}-$airQuality',
                  action: 'AQI index: ${today.airQualityIndex}',
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _smallInfoCard(
                        Icons.wb_sunny_outlined,
                        'SUNRISE',
                        today.sunrise,
                        'Sunset: ${today.sunset}',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _smallInfoCard(
                        Icons.wb_sunny,
                        'UV INDEX',
                        uvLabel,
                        'Value: ${today.uv}',
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String _airQualityLabel(int index) {
    switch (index) {
      case 1:
        return 'Good';
      case 2:
        return 'Moderate';
      case 3:
        return 'Low Health Risk';
      case 4:
        return 'Unhealthy';
      case 5:
        return 'Very Unhealthy';
      case 6:
        return 'Hazardous';
      default:
        return 'Unavailable';
    }
  }

  String _uvLabel(num value) {
    if (value < 3) return 'Low';
    if (value < 6) return 'Moderate';
    if (value < 8) return 'High';
    if (value < 11) return 'Very High';
    return 'Extreme';
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
    required String action,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.55),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                const SizedBox(height: 8),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 8),
                Text(action, style: const TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white),
        ],
      ),
    );
  }

  Widget _smallInfoCard(IconData icon, String title, String value, String subtitle) {
    return Container(
      height: 96,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(icon, color: Colors.white70, size: 15), const SizedBox(width: 4), Text(title, style: const TextStyle(color: Colors.white70, fontSize: 10))]),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 17)),
          Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _dayCard(dynamic day) {
    final date = DateTime.parse(day.date as String);
    const weekdays = <String>[
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.65),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${day.AvgtempC}°', style: const TextStyle(color: Colors.white, fontSize: 13)),
          Image.network(_iconUrl(day.conditionIcon), width: 38, height: 38),
          Text(
            weekdays[date.weekday - 1],
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
