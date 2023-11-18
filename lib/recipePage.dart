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
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black, // Adjust the border color
                        width: 2, // Adjust the border width
                      ),
                    ),
                    child: IntrinsicWidth(
                      child: Row(
                        children: [
                          Icon(Icons.play_arrow),
                          SizedBox(width: 8),
                          Text('Start'),
                        ],
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black, // Adjust the border color
                      width: 2, // Adjust the border width
                    ),
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
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black, // Adjust the border color
                      width: 2, // Adjust the border width
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('Rate : '),
                      SizedBox(width: 8),
                      Icon(Icons.star_border),
                      Icon(Icons.star_border),
                      Icon(Icons.star_border),
                      Icon(Icons.star_border),
                      Icon(Icons.star_border),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Ingredients : '),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 400, // Adjust the width as needed
              height: 300, // Adjust the height as needed
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black, // Adjust the border color
                  width: 2, // Adjust the border width
                ),
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
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black, // Adjust the border color
          width: 2, // Adjust the border width
        ),
      ),
      child: Column(
        children: [
          Icon(icon),
          SizedBox(height: 8),
          Text(text),
        ],
      ),
    );
  }
}
