class WeatherData {
  final String cityName;
  final String country;
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;

  WeatherData({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    // Extrae el país de diferentes posibles ubicaciones en el JSON
    final country = json['sys']?['country'] ??
        json['country'] ??
        (json['name']?.contains(',') ?? false
            ? json['name'].split(',')[1].trim()
            : 'Desconocido');

    // Extrae solo el nombre de la ciudad (sin país si viene combinado)
    final cityName = json['name']?.contains(',') ?? false
        ? json['name'].split(',')[0].trim()
        : json['name'] ?? 'Ciudad Desconocida';

    return WeatherData(
      cityName: cityName,
      country: country,
      temperature: json['main']?['temp']?.toDouble() ?? 0.0,
      description: json['weather']?[0]?['description'] ?? 'Sin descripción',
      icon: json['weather']?[0]?['icon'] ?? '01d',
      humidity: json['main']?['humidity']?.toInt() ?? 0,
      windSpeed: json['wind']?['speed']?.toDouble() ?? 0.0,
    );
  }
}
