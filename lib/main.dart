import 'package:flutter/material.dart';
import 'package:deber5/modelos/city_model.dart';
import 'package:deber5/modelos/weather_modelo.dart';
import 'package:deber5/pantallas/home_screen.dart';
import 'package:deber5/pantallas/weather_detail_screen.dart';
import 'package:deber5/servicios/weather_servicio.dart';
import 'package:deber5/servicios/almacenamiento_servicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final WeatherService _weatherService = WeatherService();
  final StorageService _storageService = StorageService();
  List<City> _favoriteCities = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteCities();
  }

  Future<void> _loadFavoriteCities() async {
    final cities = await _storageService.getFavoriteCities();
    setState(() {
      _favoriteCities = cities;
    });
  }

  Future<void> _searchWeather(String cityName) async {
    try {
      final weather = await _weatherService.getWeather(cityName);
      final city = City(
          name: weather.cityName,
          country: weather.country); // Usamos el country de weather

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherDetailScreen(
            weather: weather,
            isFavorite: _favoriteCities
                .any((c) => c.name == city.name && c.country == city.country),
            onToggleFavorite: () => _toggleFavorite(city),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _toggleFavorite(City city) async {
    if (_favoriteCities.any((c) => c.name == city.name)) {
      await _storageService.removeFavoriteCity(city);
    } else {
      await _storageService.saveFavoriteCity(city);
    }
    await _loadFavoriteCities();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      onSearch: _searchWeather,
      favoriteCities: _favoriteCities,
      onCityTap: (city) => _searchWeather(city.name),
      onRemoveCity: (city) async {
        await _storageService.removeFavoriteCity(city);
        await _loadFavoriteCities();
      },
    );
  }
}
