import 'package:flutter/material.dart';

class MyDietPage extends StatefulWidget {
  const MyDietPage({Key? key});

  @override
  State<MyDietPage> createState() => _MyDietPageState();
}

class _MyDietPageState extends State<MyDietPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(height: 10,),
                  Text(
                    'We will only display recipes for your \n dietary restrictions',
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 81, 35, 19),
                      fontFamily: 'CustomFont2',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20,),
                  // Create five squares with rounded edges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSquareTL(),
                      SizedBox(width: 15,),
                      _buildSquareTM(),
                      SizedBox(width: 15,),
                      _buildSquareTR(),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSquareBL(),
                      SizedBox(width: 15,),
                      _buildSquareBR(),
                    ],
                  ),

                  SizedBox(height: 20,),
                  Text(
                    'Are you intolerante or allergic to this?',
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 81, 35, 19),
                      fontFamily: 'CustomFont2',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareTL() {
    return Container(
        width: 90,
        height: 125,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/none.png',
              width: 90,
              height: 90,
            ),
            SizedBox(height: 5,),
            Align(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'None',
                  style: TextStyle(
                    fontSize: 15,
                    color:  const Color.fromARGB(255, 81, 35, 19),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }


  Widget _buildSquareTM() {
    return Container(
        width: 90,
        height: 125,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/vegetarian.png',
              width: 90,
              height: 90,
            ),
            SizedBox(height: 5,),
            Align(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Vegetarian',
                  style: TextStyle(
                    fontSize: 13,
                    color:  const Color.fromARGB(255, 81, 35, 19),
                  ),
                ),
              ),
            ),
          ],
        )
    );

  }

  Widget _buildSquareTR() {
    return Container(
        width: 90,
        height: 125,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/vegan.png',
              width: 90,
              height: 90,
            ),
            SizedBox(height: 5,),
            Align(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Vegan',
                  style: TextStyle(
                    fontSize: 15,
                    color:  const Color.fromARGB(255, 81, 35, 19),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget _buildSquareBL() {
    return Container(
        width: 90,
        height: 125,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/pescatarian.png',
              width: 90,
              height: 90,
            ),
            SizedBox(height: 5,),
            Align(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Pescatarian',
                  style: TextStyle(
                    fontSize: 13,
                    color:  const Color.fromARGB(255, 81, 35, 19),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget _buildSquareBR() {
    return Container(
        width: 90,
        height: 125,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/paleo.png',
              width: 90,
              height: 90,
            ),
            SizedBox(height: 5,),
            Align(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Paleo',
                  style: TextStyle(
                    fontSize: 15,
                    color:  const Color.fromARGB(255, 81, 35, 19),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
