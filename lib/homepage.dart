import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        centerTitle: true,
        title: const Text(
          'Feast',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the shadow
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            color: Colors.transparent, // Set the color to transparent
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Recommended'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 255, 255),
                      onPrimary: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Recent'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 255, 255, 255),
                      onPrimary: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Following'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 255, 255, 255),
                      onPrimary: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return buildRecipeCard(recipes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRecipeCard(Map<String, dynamic> recipe) {
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
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Duration: ${recipe['estimatedTime'] ?? ''} minutes',
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
    );
  }
}
