import '../../core/extensions.dart';
import 'token.dart';

enum DividerTokens implements Token {
  whitespace(" "), // 0
  startBracket("{"), // 1
  endBracket("}"), // 2
  startRoundBracket("("), // 3
  endRoundBracket(")"), // 4
  newLine("\n"), // 5
  newLineWindows("\r\n"), //6
  comma(","), // 7
  semicolon(";"), // 8
  quotes("\""), // 9
  dot("."), // 10
  startSquareBracket("["), // 11
  endSquareBracket("]"); // 12

  @override
  final String mark;
  const DividerTokens(this.mark);

  static DividerTokens? check(String str) =>
      DividerTokens.values.where((e) => e.mark == str).firstOrNull;

  @override
  String encode() => "${Tokens.divider.mark}_$index";

  static bool isNewLine(Token token) =>
      [newLine, newLineWindows].contains(token);
}
