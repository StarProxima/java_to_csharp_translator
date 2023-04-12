import '../../core/extensions.dart';

abstract class Token {
  abstract final String lexeme;

  String encode();
}

abstract class ValToken implements Token {
  dynamic get value;
}

enum Tokens implements Token {
  keyWord("W"),
  identifier("I"),
  operation("O"),
  divider("D"),
  numberConstant("N"),
  stringConstant("S");

  @override
  final String lexeme;
  const Tokens(this.lexeme);

  static Tokens? check(String str) {
    return Tokens.values.where((e) => e.lexeme == str).firstOrNull;
  }

  @override
  String encode() => "${lexeme}_$index";
}
