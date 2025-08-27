import 'package:chat_ai/home.dart' show Home;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

run(var x) {
  runApp(x);
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 0, 0)),
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
      ),
      home: Home(),
    );
  }
}