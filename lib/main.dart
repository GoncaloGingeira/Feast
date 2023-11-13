import 'package:flutter/material.dart';
import 'package:feast/my_profile.dart';
import 'package:feast/homepage.dart';
import 'package:feast/searchpage.dart';
import 'package:feast/postpage.dart';
import 'package:feast/notifpage.dart';
import 'package:feast/profilepage.dart';
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
      home: const BottomTabBar(),
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
    ProfilePage(),
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
            unselectedItemColor: Color.fromARGB(
                255, 73, 27, 12), // Set the unselected item color
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
              )
            ]));
  }
}
