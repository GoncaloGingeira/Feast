import 'dart:convert';

import 'package:feast/filters.dart';
import 'package:feast/recipe.dart';
import 'package:feast/recipePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  bool _useMyDiet = false;
  bool _digitalFridge = false;

  List<Map<String, dynamic>> recipes = [];

  @override
  void initState() {
    super.initState();
    loadRecipeFiles();
  }

  Future<void> loadRecipeFiles() async {
    try {
      String jsonFileNames =
          await rootBundle.loadString('assets/recipes/recipe_list.json');
      List<dynamic> dynamicFileNames = json.decode(jsonFileNames);

      List<String> fileNames = [];

      for (var item in dynamicFileNames) {
        if (item is String) {
          fileNames.add(item);
        } else {
          print('Invalid data structure for file name: $item');
        }
      }

      for (String fileName in fileNames) {
        String assetPath = 'assets/recipes/$fileName';
        ByteData data = await rootBundle.load(assetPath);
        String jsonString = utf8.decode(data.buffer.asUint8List());
        Map<String, dynamic> recipeData = json.decode(jsonString);

        // Ensure that the loaded data has the correct structure
        if (recipeData is Map<String, dynamic>) {
          recipes.add(recipeData);
        } else {
          print('Invalid data structure for recipe: $recipeData');
        }
      }

      // Update the UI
      setState(() {});
    } catch (e) {
      print('Error loading recipe files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Search'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure full width
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
          Expanded(
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                // Check if the recipe matches the search query
                bool matchesSearch = recipe['name']
                        ?.toLowerCase()
                        .contains(_searchQuery.toLowerCase()) ??
                    false;

                // TODO: Check if other filtering criteria are met (e.g., My Diet, Digital Fridge)

                // Only display the recipe card if it matches the search query and other criteria
                if (matchesSearch) {
                  return buildRecipeCard(recipe);
                } else {
                  // Return an empty container if the recipe should be excluded
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRecipeCard(Map<String, dynamic> recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipePage(recipe: Recipe.fromJson(recipe)),
          ),
        );
      },
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image on the left side
              Container(
                width: 100, // Adjust the width as needed
                height: 90, // Adjust the height as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(recipe['photo'] ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe['name'] ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Duration: ${recipe['time'] ?? ''} minutes',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Tags: ${recipe['tags'] ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
