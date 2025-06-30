class Weather {
  Weather({
    required this.city,
    required this.temp,
    required this.description,
    required this.humidity,
    required this.pressure,
    required this.wind,
    required this.icon,
    required this.lat,
    required this.lon,
  });

  final String city;
  final double temp;
  final String description;
  final int humidity;
  final int pressure;
  final double wind;
  final String icon;
  final double lat;
  final double lon;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temp: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      wind: (json['wind']['speed'] as num).toDouble(),
      icon: json['weather'][0]['icon'],
      lat: (json['coord']['lat'] as num).toDouble(),
      lon: (json['coord']['lon'] as num).toDouble(),
    );
  }
}
