import '../../core/extensions.dart';
import 'token.dart';

enum KeyWordTokens implements Token {
  class_("class"), // 0
  if_("if"), // 1
  else_("else"), // 2
  for_("for"), // 3
  while_("while"), // 4
  integer_("int"), // 5
  float_("float"), // 6
  double_("double"), // 7
  string_("String"), // 8
  nameSpace_("namespace"), // 9
  void_("void"), // 10
  static_("static"), // 11
  import_("import"), // 12
  system_("System"), // 13
  break_("break"), // 14
  final_("final"), // 15
  return_("return"), // 16
  public_("public"), // 17
  private_("private"), // 18
  continue_("continue"); // 19

  @override
  final String mark;
  const KeyWordTokens(this.mark);

  static KeyWordTokens? check(String str) =>
      KeyWordTokens.values.where((e) => e.mark == str).firstOrNull;

  @override
  String encode() => "${Tokens.keyWord.mark}_$index";
}
