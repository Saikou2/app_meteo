import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:palette_generator/palette_generator.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_card.dart';
import 'city_detail_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Color backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  Future<void> _updatePalette() async {
    // ⚠️  Utiliser un ImageProvider (AssetImage), pas un widget Image
    final PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(
      const AssetImage('assets/images/default_weather.jpg'),
    );

    setState(() {
      backgroundColor = paletteGenerator.dominantColor?.color ?? Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    if (provider.loading) {
      return Scaffold(
        backgroundColor: backgroundColor.withOpacity(0.3),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.error != null) {
      return Scaffold(
        backgroundColor: backgroundColor.withOpacity(0.3),
        body: Center(
          child: Text(
            "Erreur : ${provider.error}",
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
    }

    final weathers = provider.weathers;

    if (weathers.isEmpty) {
      return Scaffold(
        backgroundColor: backgroundColor.withOpacity(0.3),
        body: const Center(child: Text("Aucune donnée météo disponible.")),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor.withOpacity(0.3),
      appBar: AppBar(title: const Text('Résultats Météo')),
      body: ListView.builder(
        itemCount: weathers.length,
        itemBuilder: (context, index) {
          final weather = weathers[index];
          return WeatherCard(
            weather: weather,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CityDetailScreen(weather: weather),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
