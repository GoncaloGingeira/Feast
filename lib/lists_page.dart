import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feast/recipe.dart';
import 'dart:convert';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Lists"),
      ),
      body: FutureBuilder<List<String>>(
        future: loadLists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<String> lists = snapshot.data!;
            return ListView.builder(
              itemCount: lists.length,
              itemBuilder: (context, index) {
                String list = lists[index];
                IconData icon = Icons.list;

                if (list == "Favorites") {
                  icon = Icons.favorite;
                } else if (list == "For her") {
                  icon = Icons.person;
                } else if (list == "Dinner recipes") {
                  icon = Icons.dinner_dining;
                }

                return ListTile(
                  leading: Icon(icon),
                  title: Text(list),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipesInListPage(list),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      removeList(context, list);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> loadLists() async {
    String listsJson = await rootBundle.loadString('assets/recipes/lists.json');
    List<String> lists = List<String>.from(json.decode(listsJson));
    return lists;
  }

  void removeList(BuildContext context, String list) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$list removed'),
      ),
    );
  }
}

class RecipesInListPage extends StatelessWidget {
  final String listName;

  const RecipesInListPage(this.listName, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: loadRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Recipe> recipesInList =
              filterRecipesByList(listName, snapshot.data!);

          return Scaffold(
            appBar: AppBar(
              title: Text(listName),
            ),
            body: ListView.builder(
              itemCount: recipesInList.length,
              itemBuilder: (context, index) {
                Recipe recipe = recipesInList[index];

                return buildRecipeCard(recipe);
              },
            ),
          );
        }
      },
    );
  }

  Future<List<Recipe>> loadRecipes() async {
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
  }

  List<Recipe> filterRecipesByList(String listName, List<Recipe> allRecipes) {
    return allRecipes
        .where((recipe) => recipe.lists.contains(listName))
        .toList();
  }

  Widget buildRecipeCard(Recipe recipe) {
    return GestureDetector(
      child: Center(
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
                      recipe.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Duration: ${recipe.estimatedTime} minutes',
                      style: const TextStyle(
                        color: Colors.black,
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
