import '../../core/extensions.dart';

abstract class Token {
  abstract final String mark;

  String encode();
}

enum Tokens implements Token {
  keyWord("W"),
  identifier("I"),
  operation("O"),
  divider("D"),
  numberConstant("N"),
  stringConstant("S");

  @override
  final String mark;
  const Tokens(this.mark);

  static Tokens? check(String str) {
    return Tokens.values.where((e) => e.mark == str).firstOrNull;
  }

  @override
  String encode() => "${mark}_$index";
}
