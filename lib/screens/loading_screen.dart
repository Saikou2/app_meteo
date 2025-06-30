import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'result_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key, required this.city});

  final String city;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progress = 0.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    final provider = context.read<WeatherProvider>();


    provider.loadWeatherForCity(widget.city);


    _timer = Timer.periodic(
      const Duration(milliseconds: 300),
          (timer) {
        setState(() => _progress = (_progress + 0.05).clamp(0.0, 1.0));
        final finished = _progress >= 1.0 && !provider.loading;
        if (finished) {
          timer.cancel();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const ResultScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const messages = [
      'Nous téléchargeons les données…',
      'C’est presque fini…',
      'Plus que quelques secondes…',
      'patientez',
    ];
    final msgIdx =
    (_progress * messages.length).floor().clamp(0, messages.length - 1);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(value: _progress),
            const SizedBox(height: 24),
            Text(messages[msgIdx]),
          ],
        ),
      ),
    );
  }
}
