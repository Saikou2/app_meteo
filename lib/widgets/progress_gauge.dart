
import 'package:flutter/material.dart';

class ProgressGauge extends StatelessWidget {
  const ProgressGauge({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 10,
          ),
          Center(
            child: Text(
              '\${(progress * 100).round()}%',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
