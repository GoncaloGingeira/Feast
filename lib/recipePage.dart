import 'package:feast/recipeExecute.dart';
import 'package:flutter/material.dart';
import 'package:feast/recipe.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;

  const RecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

int _currentRate = 0;

class _RecipePageState extends State<RecipePage> {
  List<String> lists = [];

  @override
  void initState() {
    super.initState();
    loadLists();
  }

  @override
  Widget build(BuildContext context) {
    String path = widget.recipe.photoPath;
    print("--- $path");
    return Material(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              iconSize: 35.0,
              icon: const Icon(Icons.bookmark_border),
              onPressed: () {
                _showAddToListDialog();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Recipe saved!'),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 7,
            ),
            Center(
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    width: 400, // Adjust the width as needed
                    height: 200, // Adjust the height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // Adjust the border radius
                      border: Border.all(
                        color: Colors.black, // Adjust the border color
                        width: 2, // Adjust the border width
                      ),
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      // Adjust the border radius
                      child: Image.asset(
                        widget.recipe.photoPath,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        border: Border.all(
                          color: Colors.black, // Adjust the border color
                          width: 2, // Adjust the border width
                        ),
                      ),
                      child: Text(
                        widget.recipe.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoColumn(
                    Icons.timer, '${widget.recipe.estimatedTime} minutes'),
                _buildInfoColumn(
                    Icons.restaurant, '${widget.recipe.servings} servings'),
                _buildInfoColumn(Icons.local_fire_department,
                    '${widget.recipe.numOfCalories} calories'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 132, 0, 1),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.black, // Adjust the border color
                        width: 2, // Adjust the border width
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeExecutePage(
                              recipe: widget.recipe,
                            ),
                          ),
                        );
                      },
                      child: const IntrinsicWidth(
                        child: Row(
                          children: [
                            Icon(Icons.play_arrow),
                            SizedBox(width: 8),
                            Text('Start'),
                          ],
                        ),
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.black, // Adjust the border color
                      width: 2, // Adjust the border width
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star),
                      SizedBox(width: 8),
                      Text('${widget.recipe.rating}'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.black, // Adjust the border color
                      width: 2, // Adjust the border width
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Text('Rate : '),
                      SizedBox(width: 8),
                      getRateIconWidgets(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Ingredients : '),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 330,
              // Adjust the width as needed
              height: 300,
              // Adjust the height as needed
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.black, // Adjust the border color
                  width: 2, // Adjust the border width
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var ingredient in widget.recipe.ingredients)
                      Column(
                        children: [
                          Text(ingredient['name'] +
                              ' : ' +
                              ingredient['quantity'].toString() +
                              ' ' +
                              ingredient['unit']),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.black, // Adjust the border color
          width: 2, // Adjust the border width
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 8),
          Text(text),
        ],
      ),
    );
  }

  Widget getRateIconWidgets() {
    List<Widget> list = List<Widget>.generate(5, (int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _currentRate = index + 1;
          });
        },
        child: Icon(
          index < _currentRate ? Icons.star : Icons.star_border,
          color: Colors.black,
        ),
      );
    });

    return new Row(children: list);
  }

  void _showAddToListDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add to List'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: lists.map((list) {
              return ListTile(
                title: Text(list),
                onTap: () {
                  addRecipeToList(list, widget.recipe);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<void> addRecipeToList(String listName, Recipe recipe) async {
    try {
      // Add the listName to the recipe's lists
      recipe.lists.add(listName);

      // Update the recipe's JSON file
      await updateRecipeList(recipe);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recipe added to list'),
        ),
      );
    } catch (e) {
      print('Error adding recipe to list: $e');
    }
  }

  Future<void> updateRecipeList(Recipe recipe) async {
    try {
      // Load all recipes
      List<Recipe> allRecipes = await loadRecipes();

      // Find and update the recipe in the list
      int index = allRecipes.indexWhere((r) => r.id == recipe.id);
      if (index != -1) {
        allRecipes[index] = recipe;
      }

      // Save the updated list of recipes
      await saveRecipes(allRecipes);
    } catch (e) {
      print('Error updating recipe list: $e');
    }
  }

  Future<List<Recipe>> loadRecipes() async {
    try {
      String recipeListJson =
          await rootBundle.loadString('assets/recipes/recipe_list.json');
      List<String> recipeFilenames =
          List<String>.from(json.decode(recipeListJson));

      List<Recipe> recipes = [];
      for (String filename in recipeFilenames) {
        String recipeJson =
            await rootBundle.loadString('assets/recipes/$filename');
        Map<String, dynamic> recipeMap = json.decode(recipeJson);
        recipes.add(Recipe.fromJson(recipeMap));
      }

      return recipes;
    } catch (e) {
      print('Error loading recipes: $e');
      return []; // Return an empty list or handle the error accordingly
    }
  }

  Future<void> saveRecipes(List<Recipe> recipes) async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      File file = File('${directory.path}/recipe_list.json');

      List<String> recipeFilenames =
          recipes.map((recipe) => '${recipe.id}.json').toList();
      await file.writeAsString(json.encode(recipeFilenames));
      // Save each recipe
      for (Recipe recipe in recipes) {
        File recipeFile = File('${directory.path}/${recipe.id}.json');
        await recipeFile.writeAsString(json.encode(recipe.toJson()));
      }
    } catch (e) {
      print('Error saving recipes: $e');
    }
  }

  Future<void> loadLists() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      File file = File('${directory.path}/lists.json');

      if (file.existsSync()) {
        String listsJson = await file.readAsString();
        List<String> loadedLists = List<String>.from(json.decode(listsJson));

        setState(() {
          lists = loadedLists;
        });
      } else {
        String listsJson =
            await rootBundle.loadString('assets/recipes/lists.json');
        List<String> loadedLists = List<String>.from(json.decode(listsJson));

        setState(() {
          lists = loadedLists;
        });
      }
    } catch (e) {
      print('Error loading lists: $e');
    }
  }
}
