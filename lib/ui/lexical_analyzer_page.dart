import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../lexical_anallyzer/lexical_analyzer.dart';
import '../lexical_anallyzer/models/lexical_analyzer_output.dart';
import '../lexical_anallyzer/state_machine/state_machine.dart';
import '../lexical_anallyzer/tokens/divider_tokens.dart';
import '../lexical_anallyzer/tokens/token.dart';

class LexicalAnalyzerPage extends ConsumerWidget {
  const LexicalAnalyzerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _LexicalAnalyzerPage();
  }
}

class _LexicalAnalyzerPage extends ConsumerStatefulWidget {
  const _LexicalAnalyzerPage();

  @override
  ConsumerState<_LexicalAnalyzerPage> createState() =>
      _LexicalAnalyzerPageState();
}

class _LexicalAnalyzerPageState extends ConsumerState<_LexicalAnalyzerPage> {
  LexicalAnalyzerOutput? anOutput;

  final inputController = TextEditingController(text: kSample1JaveCode);
  final lexemsController = TextEditingController();
  final polishController = TextEditingController();

  String internal(String inputText) {
    inputText = inputText.replaceAll('System.out.println', 'Console.WriteLine');
    inputText = inputText.replaceAll('boolean', 'bool');
    inputText = inputText.replaceAll('String', 'string');

    return inputText;
  }

  void generateTokens() {
    final an = LexicalAnalyzer();

    anOutput = an.execute(inputController.text);

    String output = anOutput!.tokens
        .map(
          (e) => e == DividerTokens.whitespace
              ? ""
              : DividerTokens.isNewLine(e)
                  ? "\n"
                  : e.encode(),
        )
        .join(" ");

    lexemsController.text = output;

    setState(() {});
  }

  void generateReversePolishEntry() {
    String inputText = inputController.text;

    final output1 = LexicalAnalyzer().execute(inputText);

    // String output = ReversePolishEntry().execute(output1).convertToText();
    String output = kReversePolishEntry;
    polishController.text = output;
  }

  void lab3() {
    String inputText = inputController.text;

    inputText = inputText.split('\n').map((e) => '  $e').join('\n');

    inputText = 'using System; \n\nclass Program { \n$inputText';

    inputText = internal(inputText);

    inputText = '$inputText\n}';

    // final output1 = LexicalAnalyzer().execute(inputText);

    // String output = ReversePolishEntry().execute(output1).convertToText();
    // String output = kReversePolishEntry;
    polishController.text = inputText;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 400,
                child: Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Код на Java',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: inputController,
                        maxLines: 32,
                        readOnly: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: generateTokens,
                child: const Text('  Lab1  '),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 400,
                child: Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Лексемы',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: lexemsController,
                        maxLines: 32,
                        readOnly: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: lab3,
                child: const Text('  Lab3  '),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 400,
                child: Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Выходной код на C#',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: polishController,
                        maxLines: 32,
                        readOnly: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (anOutput?.keyWords.isNotEmpty ?? false)
                  TokensTextField(
                    tokens: anOutput?.keyWords ?? [],
                  ),
                if (anOutput?.identifiers.isNotEmpty ?? false)
                  TokensTextField(
                    tokens: anOutput?.identifiers ?? [],
                  ),
                if (anOutput?.numberValues.isNotEmpty ?? false)
                  TokensTextField(
                    tokens: anOutput?.numberValues ?? [],
                  ),
                if (anOutput?.stringValues.isNotEmpty ?? false)
                  TokensTextField(
                    tokens: anOutput?.stringValues ?? [],
                  ),
                if (anOutput?.boolValues.isNotEmpty ?? false)
                  TokensTextField(
                    tokens: anOutput?.boolValues ?? [],
                  ),
                if (anOutput?.operations.isNotEmpty ?? false)
                  TokensTextField(
                    tokens: anOutput?.operations ?? [],
                  ),
                if (anOutput?.dividers.isNotEmpty ?? false)
                  TokensTextField(
                    tokens: anOutput?.dividers ?? [],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TokensTextField extends ConsumerWidget {
  final List<Token> tokens;

  const TokensTextField({required this.tokens, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var map =
        tokens.map((e) => "\"${e.encode()}\": \"${e.lexeme}\" ").join(",\n");
    if (tokens.isNotEmpty && tokens.first is ValToken) {
      final valTokens = tokens.whereType<ValToken>();
      map = valTokens
          .map((e) => "\"${e.encode()}\": \"${e.value}\" ")
          .join(",\n");
    }
    return Padding(
      padding: const EdgeInsets.only(right: 32),
      child: SizedBox(
        width: 200,
        child: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tokens.isNotEmpty
                    ? tokens.first.runtimeType.toString()
                    : 'Tokens',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: TextEditingController(text: map),
                maxLines: 32,
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
