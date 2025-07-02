import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'themes/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'services/weather_api.dart';
import 'providers/weather_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  runApp(const AppliMeteoFlutter());
}

class AppliMeteoFlutter extends StatelessWidget {
  const AppliMeteoFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    final apiKey = dotenv.env['WEATHER_API_KEY'] ?? '';

    return ChangeNotifierProvider(
      create: (_) {
        final provider = WeatherProvider(WeatherApi(apiKey: apiKey));
        provider.loadCities(['Dakar', 'Paris', 'Tokyo', 'New York', 'Conakry']);
        return provider;
      },
      child: MaterialApp(
        title: 'Appli Météo Flutter',
        theme: lightThemeData,
        darkTheme: darkThemeData,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const WelcomeScreen(),
      ),
    );
  }
}