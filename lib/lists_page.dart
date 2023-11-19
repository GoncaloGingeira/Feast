import 'package:flutter/material.dart';
import 'package:feast/recipe.dart'; // Assuming there is a Recipe class in recipe.dart
import 'dart:convert';

class ListsPage extends StatelessWidget {
  final List<String> predefinedLists = [
    "Favorites",
    "For her",
    "Dinner recipes"
  ];

  ListsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Lists"),
      ),
      body: ListView.builder(
        itemCount: predefinedLists.length,
        itemBuilder: (context, index) {
          String list = predefinedLists[index];

          return ListTile(
            title: Text(list),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipesInListPage(list),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class RecipesInListPage extends StatelessWidget {
  final String listName;

  RecipesInListPage(this.listName);

  @override
  Widget build(BuildContext context) {
    // Load recipe filenames from recipe_list.json
    List<String> recipeFilenames = loadRecipeFilenames();

    // Filter recipes based on the listName
    List<Recipe> recipesInList = filterRecipesByList(listName, recipeFilenames);

    return Scaffold(
      appBar: AppBar(
        title: Text(listName),
      ),
      body: ListView.builder(
        itemCount: recipesInList.length,
        itemBuilder: (context, index) {
          Recipe recipe = recipesInList[index];

          return ListTile(
            title: Text(recipe.name),
            // Add more details or actions as needed
          );
        },
      ),
    );
  }

  // Load recipe filenames from recipe_list.json
  List<String> loadRecipeFilenames() {
    // Load content of recipe_list.json;
    String recipeListJson =
        "recipe_list.json"; // Change this to your actual method of loading the content
    return List<String>.from(json.decode(recipeListJson));
  }

  // Filter recipes based on the listName
  List<Recipe> filterRecipesByList(
      String listName, List<String> allRecipeFilenames) {
    return allRecipeFilenames
        .map((filename) => loadRecipeFromFilename(filename))
        .where((recipe) => recipe.lists.contains(listName))
        .toList();
  }

  // Load a Recipe from a JSON file
  Recipe loadRecipeFromFilename(String filename) {
    // Load content of the recipe file
    String recipeJson =
        filename; // Change this to your actual method of loading the content
    Map<String, dynamic> recipeMap = json.decode(recipeJson);
    return Recipe.fromJson(recipeMap);
  }
}
