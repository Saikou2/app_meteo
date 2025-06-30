import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherApi {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  // Injection obligatoire de la clé API
  WeatherApi({required this.apiKey});

  Future<Weather> fetchWeather(String city) async {
    final uri = Uri.parse(
      '$_baseUrl?q=${Uri.encodeComponent(city)}&units=metric&lang=fr&appid=$apiKey',
    );

    try {
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );
      return _handleResponse(response, city);
    } catch (e) {
      // Gestion des erreurs réseau ou inattendues
      throw Exception('Erreur lors de la récupération des données météo : $e');
    }
  }

  Weather _handleResponse(http.Response response, String city) {
    switch (response.statusCode) {
      case 200:
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return Weather.fromJson(jsonData);
      case 401:
        throw Exception('Clé API invalide. Vérifiez votre clé OpenWeatherMap.');
      case 404:
        throw Exception('Ville "$city" non trouvée.');
      case 429:
        throw Exception('Limite de requêtes dépassée. Réessayez plus tard.');
      default:
        throw Exception(
          'Erreur API (${response.statusCode}): ${response.reasonPhrase}',
        );
    }
  }
}
