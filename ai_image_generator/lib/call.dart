import 'home.dart' show HomePage;
import 'package:flutter/material.dart';

run(x) {
  runApp(x);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Generator AI',
      home: HomePage(),
      theme: ThemeData.light(),
    );
  }
}