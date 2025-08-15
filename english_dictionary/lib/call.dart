import 'package:flutter/material.dart';
import 'home.dart';

run(var x) {
  runApp(x);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
      title: 'English Dictionary',
    );
  }
}
