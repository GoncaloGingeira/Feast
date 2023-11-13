import 'package:flutter/material.dart';

class MyDietPage extends StatefulWidget {
  const MyDietPage({Key? key});

  @override
  State<MyDietPage> createState() => _MyDietPageState();
}

class _MyDietPageState extends State<MyDietPage> {
  String selectedDiet = ''; // Store the selected diet
  List<String> selectedAllergies = []; // Store the selected allergies

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
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Text(
                      'Do you follow any of \n these diets?',
                      style: TextStyle(
                        fontSize: 25,
                        color: const Color.fromARGB(255, 81, 35, 19),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'We will only display recipes for your \n dietary restrictions',
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 81, 35, 19),
                        fontFamily: 'CustomFont2',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Create five squares with rounded edges
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSquare('None', 'assets/none.png'),
                        SizedBox(
                          width: 15,
                        ),
                        _buildSquare('Vegetarian', 'assets/vegetarian.png'),
                        SizedBox(
                          width: 15,
                        ),
                        _buildSquare('Vegan', 'assets/vegan.png'),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSquare('Pescatarian', 'assets/pescatarian.png'),
                        SizedBox(
                          width: 15,
                        ),
                        _buildSquare('Paleo', 'assets/paleo.png'),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Are you intolerant or allergic to this?',
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 81, 35, 19),
                        fontFamily: 'CustomFont2',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildIntoleranceButton('Lactose'),
                        SizedBox(width: 10),
                        _buildIntoleranceButton('Gluten'),
                        SizedBox(width: 10),
                        _buildIntoleranceButton('Frutose'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildIntoleranceButton('Mustard'),
                        SizedBox(width: 10),
                        _buildIntoleranceButton('Egg'),
                        SizedBox(width: 10),
                        _buildIntoleranceButton('Peanuts'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildIntoleranceButton('Tree Nuts'),
                        SizedBox(width: 10),
                        _buildIntoleranceButton('Soy'),
                        SizedBox(width: 10),
                        _buildIntoleranceButton('Wheat'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildIntoleranceButton('Fish'),
                        SizedBox(width: 10),
                        _buildIntoleranceButton('Shellfish'),
                        SizedBox(width: 10),
                        _buildIntoleranceButton('Sesame'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
              'CONFIRM',
              style: TextStyle(
                fontSize: 15,
                color: const Color.fromARGB(255, 81, 35, 19),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntoleranceButton(String text) {
    bool isSelected = selectedAllergies.contains(text);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedAllergies.remove(text);
          } else {
            selectedAllergies.add(text);
          }
        });
      },
      child: Container(
        width: 100,
        height: 35,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : const Color.fromARGB(255, 81, 35, 19),
            width: isSelected ? 0 : 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 81, 35, 19),
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSquare(String diet, String imagePath) {
    bool isSelected = selectedDiet == diet;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedDiet = ''; // Deselect if already selected
          } else {
            selectedDiet = diet; // Select the current diet
          }
        });
      },
      child: Container(
        width: 95,
        height: 125,
        child: Stack(
          children: [
            // Background container with rounded corners
            Container(
              width: 95,
              height: 125,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  alignment: Alignment.topCenter, // Align asset at the top
                ),
              ),
            ),
            // Border overlay
            if (isSelected)
              Positioned.fill(
                child: Container(
                  width: 90,
                  height: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color.fromARGB(255, 81, 35, 19),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            // Text
            Positioned(
              bottom: 5.0,
              left: 1.0,
              right: 1.0,
              child: Container(
                //alignment: Alignment.bottomCenter,
                child: Text(
                  diet,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: const Color.fromARGB(255, 81, 35, 19),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
