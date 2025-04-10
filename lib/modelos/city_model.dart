class City {
  final String name;
  final String country;

  City({required this.name, required this.country});

  factory City.fromJson(Map<String, dynamic> json) {
    // Intenta obtener el país de múltiples fuentes
    final country = json['sys']?['country'] ??
        json['country'] ??
        (json['name']?.contains(',') ?? false
            ? json['name'].split(',')[1].trim()
            : 'Desconocido');

    final cityName = json['name']?.contains(',') ?? false
        ? json['name'].split(',')[0].trim()
        : json['name'] ?? 'Ciudad Desconocida';

    return City(
      name: cityName,
      country: country.isNotEmpty ? country : 'Desconocido',
    );
  }

  Future<void> toMap() async {}
}
