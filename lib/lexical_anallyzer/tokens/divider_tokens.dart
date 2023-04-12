import '../../core/extensions.dart';
import 'token.dart';

enum DividerTokens implements Token {
  whitespace(" "),
  tab("\t"),
  newLine("\n"),
  newLineWindows("\r\n"),
  comma(","),
  colon(":"),
  semicolon(";"),
  slash("/"),
  star("*"),
  quotes("\""),
  dot("."),
  startBracket("{"),
  endBracket("}"),
  startRoundBracket("("),
  endRoundBracket(")"),
  startSquareBracket("["),
  endSquareBracket("]");

  @override
  final String lexeme;
  const DividerTokens(this.lexeme);

  static DividerTokens? check(String str) =>
      DividerTokens.values.where((e) => e.lexeme == str).firstOrNull;

  @override
  String encode() => "${Tokens.divider.lexeme}_$index";

  static bool isNewLine(Token? token) =>
      [newLine, newLineWindows].contains(token);
}
