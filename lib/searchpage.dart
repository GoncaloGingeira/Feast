import 'package:feast/filters.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  bool _useMyDiet = false;
  bool _digitalFridge = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search for recipes',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.1,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FiltersPage()),
                      );
                    },
                    backgroundColor: Colors.white,
                    child: const Text(
                      'Filters',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Switch(
                  value: _useMyDiet,
                  onChanged: (value) {
                    setState(() {
                      _useMyDiet = value;
                    });
                  },
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                  activeTrackColor: Color.fromARGB(255, 251, 227, 5),
                ),
                const Text('My Diet'),
                SizedBox(width: 10),
                Switch(
                  value: _digitalFridge,
                  onChanged: (value) {
                    setState(() {
                      _digitalFridge = value;
                    });
                  },
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                  activeTrackColor: Color.fromARGB(255, 251, 227, 5),
                ),
                const Text('Digital \nFridge'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
