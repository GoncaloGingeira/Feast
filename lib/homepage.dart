import 'dart:convert';
import 'dart:io'; // Import the dart:io library
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart'; // Import the path library

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> recipes = [];

  @override
  void initState() {
    super.initState();
    loadRecipeFiles();
  }

  Future<void> loadRecipeFiles() async {
    try {
      // Get the directory path for the 'assets/recipes' folder
      String directoryPath = 'assets/';
      // Remove the 'Directory' and 'listSync' calls

      // Get a list of files using 'rootBundle'
      List<String> filenames = await rootBundle
          .loadStructuredData<List<String>>(directoryPath, (jsonStr) async {
        // Convert the JSON string to a List<String> containing filenames
        return json.decode(jsonStr);
      });

      // Load and parse each file
      for (String filename in filenames) {
        String jsonString =
            await rootBundle.loadString('$directoryPath/$filename');
        Map<String, String> recipe = json.decode(jsonString);
        recipes.add(recipe);
      }

      // Update the state with the loaded recipes
      setState(() {});
    } catch (e) {
      print('Error loading recipes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Feast',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Recommended'),
                style: ElevatedButton.styleFrom(primary: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Recent'),
                style: ElevatedButton.styleFrom(primary: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Following'),
                style: ElevatedButton.styleFrom(primary: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return buildRecipeCard(recipes[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget buildRecipeCard(Map<String, String> recipe) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        width: 400,
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
          children: [
            const Icon(
              Icons.fastfood,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe['name'] ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  recipe['duration'] ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
                Text(
                  recipe['tags'] ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
