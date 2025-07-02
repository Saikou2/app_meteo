import 'package:flutter/material.dart';
import '../models/weather.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
    required this.weather,
    required this.onTap,
  });

  final Weather weather;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
          width: 50,
          height: 50,
          errorBuilder: (context, error, stackTrace) {
            // Image locale en cas d'erreur de chargement (CORS etc)
            return Image.asset(
              'assets/images/default_weather.jpg',
              width: 50,
              height: 50,
            );
          },
        ),
        title: Text(weather.city),
        subtitle: Text(
          "${weather.temp.toStringAsFixed(1)} °C • ${weather.description}",
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
