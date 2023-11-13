import 'package:feast/my_diet.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feast',
      theme: ThemeData(
        fontFamily: 'CustomFont1',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 242, 236, 229),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 242, 236, 229),
        ),
        textTheme: const TextTheme(),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child :Column(
          children: <Widget>[
          Container(
            color: const Color.fromARGB(255, 81, 35, 19),
            height: 150,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 55,),
                Row(
                  children: [
                    SizedBox(width: 20),
                    ClipOval(
                      child: Image.network(
                        'https://img.freepik.com/premium-vector/burger-king-vector-logo-design-burger-with-crown-icon-logo-concept_617472-644.jpg?w=2000',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ana',
                          style: TextStyle(
                            color: Color.fromARGB(255, 242, 236, 229),
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          '@ana123',
                          style: TextStyle(
                            color: Color.fromARGB(255, 242, 236, 229),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Container(
                      height: 70,
                      child: const VerticalDivider(
                        color: Color.fromARGB(255, 242, 236, 229),
                        thickness: 1,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      // Align Column children to the middle vertically
                      children: [
                        Text(
                          '24 followers',
                          style: TextStyle(
                            color: Color.fromARGB(255, 242, 236, 229),
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '10 following',
                          style: TextStyle(
                            color: Color.fromARGB(255, 242, 236, 229),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSquareTL(),
                    SizedBox(width: 20),
                    _buildSquareTR(),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSquareML(),
                    SizedBox(width: 20),
                    _buildSquareMR(),
                  ],
                ),
                SizedBox(height: 20),
                _buildSquareB(),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildSquareTL() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 75,
              height: 75,
              child: Image.asset('assets/fried-egg-cartoon-icon-png.png'),
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              'My Posts',
              style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(255, 81, 35, 19),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareTR() {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: Image.asset('assets/fridge-icon.png'),
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              'Digital Fridge',
              style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(255, 81, 35, 19),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareML() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: Image.asset('assets/lists-png.png'),
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              'My Lists',
              style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(255, 81, 35, 19),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareMR() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyDietPage(key: widget.key,)),
        );
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 75,
              height: 75,
              child: Image.asset(
                  'assets/diet-png.png'),
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              'My Diet',
              style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(255, 81, 35, 19),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareB() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 75,
              height: 75,
              child: Image.asset(
                  'assets/app-settings-png.png'),
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              'App Settings',
              style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(255, 81, 35, 19),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
