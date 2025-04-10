import 'package:flutter/material.dart';
import '../modelos/city_model.dart';

class FavoritesList extends StatelessWidget {
  final List<City> cities;
  final Function(City) onTap;
  final Function(City) onRemove;

  const FavoritesList({
    Key? key,
    required this.cities,
    required this.onTap,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];
        return ListTile(
          title: Text(
            '${city.name}, ${city.country}',
            style: TextStyle(color: const Color.fromARGB(255, 83, 33, 164)),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => onRemove(city),
          ),
          onTap: () => onTap(city),
        );
      },
    );
  }
}
