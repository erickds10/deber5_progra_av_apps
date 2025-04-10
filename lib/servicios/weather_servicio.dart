import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelos/weather_modelo.dart';

class WeatherService {
  static const String _apiKey = '3ae9930271f68c695bb2ff66b41d9ad4';
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherData> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey&units=metric&lang=es'),
    );

    if (response.statusCode == 200) {
      return WeatherData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
