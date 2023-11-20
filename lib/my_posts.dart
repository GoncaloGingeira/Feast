import 'dart:convert';

import 'package:feast/recipe.dart';
import 'package:feast/recipePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
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
          title: const Text('My Posts'),
        ),
        body: Column(children: [
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
        ]));
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
