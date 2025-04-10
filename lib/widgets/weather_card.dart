import 'package:flutter/material.dart';
import '../modelos/weather_modelo.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weather;

  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              weather.cityName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.green,
                  ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                  width: 60,
                  height: 60,
                ),
                Text(
                  '${weather.temperature.toStringAsFixed(1)}°C',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            Text(
              weather.description,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: const Color.fromARGB(255, 249, 130, 3)),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Humedad: ${weather.humidity}%',
                  style:
                      TextStyle(color: const Color.fromARGB(255, 33, 149, 243)),
                ),
                Text(
                  'Viento: ${weather.windSpeed.toStringAsFixed(1)} km/h',
                  style:
                      TextStyle(color: const Color.fromARGB(255, 33, 149, 243)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
