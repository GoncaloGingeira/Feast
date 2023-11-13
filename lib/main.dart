import 'package:flutter/material.dart';
import 'package:feast/my_profile.dart';

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
      home: const MyProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

