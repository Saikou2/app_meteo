import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/weather.dart';

class CityDetailScreen extends StatelessWidget {
  const CityDetailScreen({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final latLng = LatLng(weather.lat, weather.lon);

    return Scaffold(
      appBar: AppBar(title: Text(weather.city)),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(center: latLng, zoom: 11),
              children: [
                TileLayer(
                  urlTemplate:
                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.appli_meteo_flutter',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: latLng,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.thermostat),
            title: Text("${weather.temp.toStringAsFixed(1)} °C"),
            subtitle: const Text('Température'),
          ),
          ListTile(
            leading: const Icon(Icons.water_drop),
            title: Text("${weather.humidity}%"),
            subtitle: const Text('Humidité'),
          ),
          ListTile(
            leading: const Icon(Icons.air),
            title: Text("${weather.wind} m/s"),
            subtitle: const Text('Vent'),
          ),
        ],
      ),
    );
  }
}
