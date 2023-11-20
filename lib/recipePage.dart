import 'package:feast/recipeExecute.dart';

import 'package:flutter/material.dart';
import 'package:feast/recipe.dart';
import 'package:feast/recipePage.dart';
import 'package:feast/recipe.dart';
import 'dart:io';

class RecipePage extends StatefulWidget {
  final Recipe recipe;

  const RecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

int _currentRate = 0;

class _RecipePageState extends State<RecipePage> {
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
                // Add save functionality
                // This is where you can save the recipe or perform other save-related actions
                // For example, you can save the recipe to a file or database
                // Once saved, you might want to show a confirmation message
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
                      child: getImage(),
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
  Widget getRateIconWidgets()
  {
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

  Widget getImage() {
    if(widget.recipe.photoPath.contains('assets')){
      Widget image = Image.asset(
        widget.recipe.photoPath,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      );
      print('COULD DO IT');
      return image;
    }
    else{
      print('COULD NOT DO IT');
      return Image.file(
        File(widget.recipe.photoPath),
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      );
    }

  }

}
