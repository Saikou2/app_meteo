import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_api.dart';

class WeatherProvider with ChangeNotifier {
  WeatherProvider(this._api);

  final WeatherApi _api;


  final Map<String, Weather> _cache = {};

  bool _loading = false;
  String? _error;

  bool get loading => _loading;
  String? get error => _error;


  List<Weather> get weathers =>
      _cache.values.toList()..sort((a, b) => a.city.compareTo(b.city));




  Future<void> loadCities(List<String> cities) async {
    _setLoading(true);
    try {
      final futures = cities.map(_api.fetchWeather);
      final results = await Future.wait(futures);
      for (final w in results) {
        _cache[w.city] = w;
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadWeatherForCity(String city) async {
    _setLoading(true);
    try {
      final weather = await _api.fetchWeather(city);
      _cache[city] = weather;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }



  Future<void> addCity(String city) => loadWeatherForCity(city);

  Weather getByCity(String city) {
    final weather = _cache[city];
    if (weather == null) {
      throw Exception("Pas de données météo pour '$city'.");
    }
    return weather;
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
