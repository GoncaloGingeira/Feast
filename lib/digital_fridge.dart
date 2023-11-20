
import 'dart:io';
import 'package:feast/add_ingredients.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DigitalFridgePage extends StatefulWidget {
  const DigitalFridgePage({Key? key});

  @override
  State<DigitalFridgePage> createState() => _DigitalFridgePageState();
}

class _DigitalFridgePageState extends State<DigitalFridgePage> {
  late List<dynamic> regionsData = [];

  @override
  void initState() {
    super.initState();
    readJsonFromFile();
  }

  Future<void> readJsonFromFile() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/myingredients.json');

      if (await file.exists()) {
        String jsonString = await file.readAsString();
        Map<String, dynamic> data = json.decode(jsonString);

        setState(() {
          regionsData = data['regions'] ?? [];
        });
        print('Read data from file: ${file.path}');
      } else {
        setState(() {
          regionsData = [];
        });
        print('File does not exist, initialized empty values');
      }
    } catch (e) {
      print('Error reading JSON from file: $e');
    }
  }

  Future<void> removeIngredient(String regionName, String ingredientToRemove) async {
    int regionIndex = regionsData.indexWhere(
          (region) => region['name'] == regionName,
    );

    if (regionIndex != -1) {
      var region = regionsData[regionIndex];

      List<String> ingredients = List<String>.from(region['ingredients']);
      ingredients.remove(ingredientToRemove);

      regionsData[regionIndex]['ingredients'] = ingredients;

      setState(() {
        regionsData = List.from(regionsData);
      });
    }
  }

  Future<void> saveJsonToFile() async {
    try {
      Map<String, dynamic> data = {
        'regions': regionsData,
      };
      String jsonString = jsonEncode(data);
      final Directory directory = await getApplicationDocumentsDirectory();

      final File file = File('${directory.path}/myingredients.json');

      await file.writeAsString(jsonString);

      print('JSON saved to file: ${file.path}');
    } catch (e) {
      print('Error saving JSON to file: $e');
    }
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
          title: Text(
            'Digital Fridge',
            style: TextStyle(
              fontSize: 20,
              color: const Color.fromARGB(255, 81, 35, 19),
            ),
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
                    'Add the ingredient that you have at home to get recipes that you can cook.',
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 81, 35, 19),
                      fontFamily: 'CustomFont2',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: const Color.fromARGB(255, 81, 35, 19),
                  thickness: 0.5,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: regionsData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildIngredientsForRegion(
                        regionsData[index]['name']);
                  },
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AddIngredientsPage()),
              );
            },
            child: Text(
              'ADD INGREDIENTS',
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

  Widget _buildIngredientsForRegion(String regionName) {
    var region = regionsData.firstWhere(
      (region) => region['name'] == regionName,
      orElse: () => {'ingredients': []},
    );

    List<String> ingredients = region['ingredients'].cast<String>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 25.0, top: 20.0),
          child: Text(
            regionName,
            style: TextStyle(
              fontSize: 18,
              color: const Color.fromARGB(255, 81, 35, 19),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(ingredients.length, (index) {
                return GestureDetector(
                  onLongPress: () {
                    _showDeleteIngredientDialog(regionName, ingredients[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ingredients[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 81, 35, 19),
                            fontFamily: 'CustomFont2',
                          ),
                        ),
                        SizedBox(width: 4.0),
                        // Space between ingredient and cross
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        )
      ],
    );
  }

  void _showDeleteIngredientDialog(String regionName, String ingredientName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Remove Ingredient?',
            style: TextStyle(
              fontSize: 18,
              color: const Color.fromARGB(255, 81, 35, 19),
            ),
          ),
          content: Text(
            'Are you sure you want to remove $ingredientName from yours Fridge?',
            style: TextStyle(
              fontSize: 15,
              color: const Color.fromARGB(255, 81, 35, 19),
              fontFamily: 'CustomFont2',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: const Color.fromARGB(255, 81, 35, 19),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                removeIngredient(regionName, ingredientName);
                saveJsonToFile();

                Navigator.of(context).pop();
              },
              child: Text(
                'Remove',
                style: TextStyle(
                  color: const Color.fromARGB(255, 81, 35, 19),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
