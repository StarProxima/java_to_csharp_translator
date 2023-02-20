import 'package:flutter/material.dart';
import 'package:java_to_csharp_translator/ui/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator from Java to C#',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.blueGrey.shade50,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.blueGrey.shade100),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.blueGrey.shade100),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
