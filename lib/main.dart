import 'package:flutter/material.dart';
import 'package:feast/my_profile.dart';
import 'package:feast/homepage.dart';
import 'package:feast/searchpage.dart';
import 'package:feast/postpage.dart';
import 'package:feast/notifpage.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

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
        scaffoldBackgroundColor: const Color.fromARGB(
            255, 246, 240, 232), // Set the background color
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(
              255, 246, 240, 232), // Set app bar background color
        ),
        textTheme: const TextTheme(),
      ),
      home: LoginPage(), // Display the login page initially
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _index = 0;
  final screens = [
    HomePage(),
    SearchPage(),
    PostPage(),
    NotifPage(),
    MyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          print(value);
          setState(() {
            _index = value;
          });
        },
        selectedItemColor:
            Color.fromARGB(255, 230, 184, 1), // Set the selected item color
        unselectedItemColor:
            Color.fromARGB(255, 73, 27, 12), // Set the unselected item color
        showUnselectedLabels: true, // Show labels for unselected items
        elevation: 10.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Boxicons.bx_home_circle),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Boxicons.bx_search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Boxicons.bxs_plus_circle),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Boxicons.bx_bell),
            label: 'Notifs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Boxicons.bxs_user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/app-logo.png', // Replace with your app logo asset
          height: 90, // Adjust the height to make it bigger
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 8.0),
              _showError
                  ? Text(
                      'Username or password incorrect. Please try again.',
                      style: TextStyle(color: Colors.red, fontSize: 12.0),
                    )
                  : Container(),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Validation logic - replace with your authentication logic
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  if (username == "ana123" && password == "12345") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BottomTabBar()),
                    );
                  } else {
                    // Show an error message
                    setState(() {
                      _showError = true;
                    });
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      print("Forget Password?");
                    },
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
