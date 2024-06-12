import 'package:flutter/material.dart';
import 'my_homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //build the material app
    return MaterialApp(
      //set the initial route
      initialRoute: 'HomePage',
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //set theme of the application
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF2EBE2),
        useMaterial3: true,
      ),
      //generated routes
      routes: {
        'HomePage': (context) => const MyHomePage(),
      },
    );
  }
}

