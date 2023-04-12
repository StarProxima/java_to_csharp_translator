import 'package:flutter/material.dart';

import 'package:java_to_csharp_translator/ui/lexical_analyzer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Translator from Java to C#'),
      ),
      body: const LexicalAnalyzerPage(),
    );
  }
}
