import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../screens/loading_screen.dart';
import '../screens/city_detail_screen.dart';
import '../models/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

/* ───────── Palette & helper ───────── */
  final List<Color> _cardColors = [
    const Color(0xFFB3E5FC), // bleu
    const Color(0xFFC8E6C9), // vert
    const Color(0xFFFFF9C4), // jaune
    const Color(0xFFFFCCBC), // orange
  ];
  Color _textOn(Color bg) =>
      bg.computeLuminance() < 0.5 ? Colors.white : Colors.black;

  void _searchCity() {
    final city = _controller.text.trim();
    if (city.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => LoadingScreen(city: city)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final weathers = provider.weathers;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Appli Météo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          /* ───────── Image de fond ───────── */
          Image.asset(
            'assets/images/default_weather.jpg',
            fit: BoxFit.cover,
          ),
          /* ───────── Voile sombre ───────── */
          Container(color: Colors.black26),

          /* ───────── Contenu ───────── */
          Padding(
            padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 24, 16, 16),
            child: Column(
              children: [
                /* Barre de recherche */
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Rechercher une ville autre les 4 par defaut',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                  ),
                  onSubmitted: (_) => _searchCity(),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _searchCity,
                  child: const Text('Rechercher'),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: provider.loading
                      ? const Center(child: CircularProgressIndicator())
                      : provider.error != null
                      ? Center(child: Text('Erreur : ${provider.error}'))
                      : GridView.builder(
                    itemCount: weathers.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final weather = weathers[index];
                      final bg =
                      _cardColors[index % _cardColors.length];
                      return _buildCityCard(weather, bg);
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

  Widget _buildCityCard(Weather weather, Color bg) {
    final txt = _textOn(bg);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => CityDetailScreen(weather: weather)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(weather.city,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: txt),
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text("${weather.temp.toStringAsFixed(1)} °C",
                style: TextStyle(fontSize: 14, color: txt)),
            const SizedBox(height: 4),
            Text(weather.description,
                style: TextStyle(fontSize: 12, color: txt),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
