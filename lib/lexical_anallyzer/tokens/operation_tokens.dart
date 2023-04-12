import '../../core/extensions.dart';
import 'token.dart';

enum OperationTokens implements Token {
  multiplier("*"),
  plus("+"),
  minus("-"),
  remainder("%"),
  divider("/"),
  exclamationMark("!"),
  doublePlus("++"),
  doubleMinus("--"),
  plusEqualTo("+="),
  minusEqualTo("-="),
  divideEqualTo("/="),
  multiplyEqualTo("*="),
  remaindEqualTo("%="),
  less("<"),
  lessOrEqual("<="),
  more(">"),
  moreOrEqual(">="),
  isEqual("=="),
  notEqual("!="),
  equalTo("=");

  @override
  final String lexeme;
  const OperationTokens(this.lexeme);

  static OperationTokens? check(String str) =>
      OperationTokens.values.where((e) => e.lexeme == str).firstOrNull;

  @override
  String encode() => "${Tokens.operation.lexeme}_$index";
}
