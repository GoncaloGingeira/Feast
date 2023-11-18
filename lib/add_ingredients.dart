import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class AddIngredientsPage extends StatefulWidget {
  const AddIngredientsPage({Key? key});

  @override
  State<AddIngredientsPage> createState() => _AddIngredientsPageState();
}

class _AddIngredientsPageState extends State<AddIngredientsPage> {
  late List<dynamic> regionsData;
  List<String> filteredIngredients = [];
  List<String> ingredientTypes = [];
  String selectedIngredientType = 'Vegetables';
  TextEditingController searchController = TextEditingController();
  List<dynamic> ingredientsToAdd = [];


  @override
  void initState() {
    super.initState();
    _loadRegionsData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRegionsData() async {
    String jsonString = await rootBundle.loadString('assets/ingredients.json');
    Map<String, dynamic> data = json.decode(jsonString);
    setState(() {
      regionsData = data['regions'];
      for (var region in regionsData) {
        ingredientTypes.add(region['name']);
      }
    });
  }

  List<String> _getIngredientsByType(String type) {
    var region = regionsData.firstWhere(
          (region) => region['name'] == type,
      orElse: () => {'ingredients': []},
    );
    return region['ingredients'].cast<String>();
  }

  List<String> _filterIngredients(String query) {
    List<String> filteredList = [];
    for (var region in regionsData) {
      for (var ingredient in region['ingredients']) {
        if (ingredient.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add(ingredient);
        }
      }
    }
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Add Ingredients',
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 81, 35, 19),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: const Color.fromARGB(255, 81, 35, 19),
                  thickness: 0.5,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextField(
                        controller: searchController,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 81, 35, 19),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Search ingredients to add',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 81, 35, 19),
                            fontFamily: 'CustomFont2',
                          ),
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            filteredIngredients = _filterIngredients(value);
                          });
                        },
                      ),
                      if (searchController.text.isNotEmpty)
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              filteredIngredients = [];
                              searchController.clear();
                            });
                          },
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                if(searchController.text.isEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: ingredientTypes.map((type) {
                        bool isSelected = type == selectedIngredientType;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIngredientType = type;
                              filteredIngredients = [];
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: isSelected
                                  ? Color.fromARGB(255, 81, 35, 19)
                                  : Colors.grey.withOpacity(0.3),
                            ),
                            child: Text(
                              type,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Color.fromARGB(255, 81, 35, 19),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                SizedBox(height: 20),
                (filteredIngredients.isEmpty && searchController.text.isNotEmpty)
                ? Column(
                  children: [
                    SizedBox(height: 100,),
                    Center(
                      child: Container(
                        child: Text(
                          'There are no ingredients that \n match your search.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 81, 35, 19),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Container(
                        child: Text(
                          'Try something else.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 81, 35, 19),
                            fontFamily: 'CustomFont2',
                          ),
                        ),
                      ),
                    )
                  ],
                )
                 :Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: (searchController.text.isEmpty &&
                      selectedIngredientType.isNotEmpty)
                      ? _getIngredientsByType(selectedIngredientType)
                      .map((ingredient) {
                    return GestureDetector(
                      onTap: () {
                        // Add logic to add the ingredient to the new list
                        // For example:
                        // _addIngredientToList(ingredient);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 81, 35, 19),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          ingredient,
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 81, 35, 19),
                          ),
                        ),
                      ),
                    );
                  }).toList()
                      : filteredIngredients.map((ingredient) {
                    return GestureDetector(
                      onTap: () {
                        // Add logic to add the ingredient to the new list
                        // For example:
                        // _addIngredientToList(ingredient);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 81, 35, 19),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          ingredient,
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 81, 35, 19),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16.0),
          color: Color.fromARGB(255, 246, 240, 232),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CONFIRM SELECTION',
              style: TextStyle(
                fontSize: 13,
                color: const Color.fromARGB(255, 81, 35, 19),
              ),
            ),
          ),
        ),
      ),
    );
  }
}