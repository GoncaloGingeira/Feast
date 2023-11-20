import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feast/recipe.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({Key? key}) : super(key: key);

  @override
  _ListsPageState createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  List<String> lists = [];

  @override
  void initState() {
    super.initState();
    loadLists();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Lists"),
      ),
      body: ListView.builder(
        itemCount: lists.length,
        itemBuilder: (context, index) {
          String list = lists[index];
          IconData icon = Icons.list;

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
                removeList(list);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewListDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showNewListDialog(BuildContext context) {
    String newListName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create a New List'),
          content: TextField(
            onChanged: (value) {
              newListName = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter list name',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newListName.isNotEmpty) {
                  createNewList(newListName);
                  Navigator.pop(context);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void createNewList(String newListName) {
    setState(() {
      lists.add(newListName);
    });

    saveListsToFile(lists);
  }

  Future<void> removeList(String list) async {
    try {
      lists = lists.where((l) => l != list).toList();

      // Update the lists.json file
      await saveListsToFile(lists);

      // Update the recipes to remove the deleted list
      await updateRecipeLists(list);

      // Show a Snackbar as a confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$list removed'),
        ),
      );

      // Refresh the current page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ListsPage(),
        ),
      );
    } catch (e) {
      print('Error removing list: $e');
    }
  }

  Future<void> updateRecipeLists(String removedList) async {
    try {
      List<Recipe> allRecipes = await loadRecipes();

      // Update the recipes to remove the deleted list
      for (Recipe recipe in allRecipes) {
        if (recipe.lists.contains(removedList)) {
          recipe.lists.remove(removedList);
        }
      }

      // Save the updated recipes
      await saveRecipes(allRecipes);
    } catch (e) {
      print('Error updating recipe lists: $e');
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

  Future<void> saveListsToFile(List<String> lists) async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      File file = File('${directory.path}/lists.json');
      await file.writeAsString(json.encode(lists));
      print(json.encode(lists));
    } catch (e) {
      print('Error saving lists to file: $e');
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
        File recipeFile = File(
            '${(await getApplicationDocumentsDirectory()).path}/$filename');
        String recipeJson = await recipeFile.readAsString();
        Map<String, dynamic> recipeMap = json.decode(recipeJson);
        recipes.add(Recipe.fromJson(recipeMap));
      }

      return recipes;
    } catch (e) {
      print('Error loading recipes: $e');
      return []; // Return an empty list or handle the error accordingly
    }
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: ListsPage(),
    ),
  );
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
    try {
      String recipeListJson =
          await rootBundle.loadString('assets/recipes/recipe_list.json');
      List<String> recipeFilenames =
          List<String>.from(json.decode(recipeListJson));

      List<Recipe> recipes = [];
      for (String filename in recipeFilenames) {
        File recipeFile = File(
            '${(await getApplicationDocumentsDirectory()).path}/$filename');
        String recipeJson = await recipeFile.readAsString();
        Map<String, dynamic> recipeMap = json.decode(recipeJson);
        recipes.add(Recipe.fromJson(recipeMap));
      }

      return recipes;
    } catch (e) {
      print('Error loading recipes: $e');
      return []; // Return an empty list or handle the error accordingly
    }
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
