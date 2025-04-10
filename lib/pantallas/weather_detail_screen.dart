import 'package:flutter/material.dart';
import '../modelos/weather_modelo.dart';
import '../widgets/weather_card.dart';

class WeatherDetailScreen extends StatelessWidget {
  final WeatherData weather;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const WeatherDetailScreen({
    Key? key,
    required this.weather,
    required this.isFavorite,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(weather.cityName),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: onToggleFavorite,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: WeatherCard(weather: weather),
        ),
      ),
    );
  }
}
