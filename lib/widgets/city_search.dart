import 'package:flutter/material.dart';

class CitySearch extends StatefulWidget {
  final Function(String) onSearch;

  const CitySearch({Key? key, required this.onSearch}) : super(key: key);

  @override
  _CitySearchState createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Buscar ciudad',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                widget.onSearch(_controller.text);
              }
            },
          ),
        ],
      ),
    );
  }
}
