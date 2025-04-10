import 'package:flutter/material.dart';
import '../modelos/city_model.dart';
import '../widgets/city_search.dart';
import '../widgets/favoritos.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) onSearch;
  final List<City> favoriteCities;
  final Function(City) onCityTap;
  final Function(City) onRemoveCity;

  const HomeScreen({
    Key? key,
    required this.onSearch,
    required this.favoriteCities,
    required this.onCityTap,
    required this.onRemoveCity,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 253, 225),
      appBar: AppBar(
        title: const Text('Clima App'),
      ),
      body: Column(
        children: [
          CitySearch(onSearch: widget.onSearch),
          const SizedBox(height: 20),
          const Text(
            'Ciudades Favoritas 🌟❤️',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          Expanded(
            child: FavoritesList(
              cities: widget.favoriteCities,
              onTap: widget.onCityTap,
              onRemove: widget.onRemoveCity,
            ),
          ),
        ],
      ),
    );
  }
}
