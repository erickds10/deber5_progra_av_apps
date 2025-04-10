import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../modelos/city_model.dart';

class StorageService {
  static const String _favoritesKey = 'favoriteCities';

  Future<List<City>> getFavoriteCities() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? favoritesString = prefs.getString(_favoritesKey);

      if (favoritesString == null) return [];

      final List<dynamic> jsonData = jsonDecode(favoritesString);
      return jsonData.map((item) => City.fromJson(item)).toList();
    } catch (e) {
      print('Error loading favorites: $e');
      return [];
    }
  }

  Future<bool> saveFavoriteCity(City city) async {
    try {
      final favorites = await getFavoriteCities();

      // Evita duplicados
      if (!favorites
          .any((c) => c.name == city.name && c.country == city.country)) {
        favorites.add(city);
        return await _saveCities(favorites);
      }
      return true;
    } catch (e) {
      print('Error saving city: $e');
      return false;
    }
  }

  Future<bool> removeFavoriteCity(City city) async {
    try {
      final favorites = await getFavoriteCities();
      favorites
          .removeWhere((c) => c.name == city.name && c.country == city.country);
      return await _saveCities(favorites);
    } catch (e) {
      print('Error removing city: $e');
      return false;
    }
  }

  Future<bool> _saveCities(List<City> cities) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Convertimos a lista de Map serializable
      final serializableList = cities.map((city) {
        return {
          'name': city.name,
          'country': city.country,
        };
      }).toList();

      return await prefs.setString(_favoritesKey, jsonEncode(serializableList));
    } catch (e) {
      print('Error encoding cities: $e');
      return false;
    }
  }
}
