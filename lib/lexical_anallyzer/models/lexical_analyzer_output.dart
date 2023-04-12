import '../tokens/divider_tokens.dart';
import '../tokens/identiffier_token.dart';
import '../tokens/key_words_tokens.dart';
import '../tokens/operation_tokens.dart';
import '../tokens/token.dart';
import '../tokens/value_tokens.dart';

final class LexicalAnalyzerOutput {
  final List<Token> tokens;
  final List<KeyWordTokens> keyWords;
  final List<IdentifierToken> identifiers;
  final List<ValueToken> numberValues;
  final List<ValueToken> stringValues;
  final List<ValueToken> boolValues;
  final List<OperationTokens> operations;
  final List<DividerTokens> dividers;

  // create consctructor
  LexicalAnalyzerOutput({
    required this.tokens,
    required this.keyWords,
    required this.identifiers,
    required this.numberValues,
    required this.stringValues,
    required this.boolValues,
    required this.operations,
    required this.dividers,
  });
}
