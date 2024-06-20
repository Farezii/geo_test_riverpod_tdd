import 'package:flutter/material.dart';
import 'package:geo_test_riverpod/widgets/login_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocator test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 14, 13, 48), //Colors.pink,
          brightness: Brightness.dark,
        ),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const LoginForm(),
    );
  }
}
