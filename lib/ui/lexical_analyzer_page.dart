import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../lexical_anallyzer/lexical_analyzer.dart';
import '../lexical_anallyzer/models/lexical_analyzer_output.dart';
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
  void f() {
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

    outputController.text = output;

    setState(() {});
  }

  final inputController = TextEditingController(text: kSample1JaveCode);
  final outputController = TextEditingController();

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
                        'Enter Java code',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: inputController,
                        maxLines: 32,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(onPressed: f, child: const Text('  --->  ')),
              const SizedBox(width: 16),
              SizedBox(
                width: 400,
                child: Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Output Tokens',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: outputController,
                        maxLines: 32,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
