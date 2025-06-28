import 'package:flutter/material.dart';
import 'weather_app.dart' as wa;

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: false),
      title: 'Weather App',
      home: wa.Page(),
    );
  }
}

run(dynamic app) {
  runApp(app);
}
