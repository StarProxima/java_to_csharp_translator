// ignore_for_file: constant_identifier_names

import '../../core/extensions.dart';
import 'token.dart';

enum KeyWordTokens implements Token {
  abstract_("abstract"),
  case_("case"),
  continue_("continue"),
  extends_("extends"),
  goto_("goto"),
  int_("int"),
  package_("package"),
  short_("short"),
  try_("try"),
  assert_("assert"),
  catch_("catch"),
  default_("default"),
  final_("final"),
  if_("if"),
  private_("private"),
  static_("static"),
  this_("this"),
  void_("void"),
  boolean_("boolean"),
  char_("char"),
  do_("do"),
  long_("long"),
  protected_("protected"),
  throw_("throw"),
  volatile_("volatile"),
  break_("break"),
  class_("class"),
  double_("double"),
  float_("float"),
  import_("import"),
  native_("native"),
  public_("public"),
  super_("super"),
  throws_("throws"),
  while_("while"),
  byte_("byte"),
  const_("const"),
  else_("else"),
  for_("for"),
  instanceof_("instanceof"),
  new_("new"),
  return_("return"),
  switch_("switch"),
  transient_("transient"),
  print_("print"),
  println_("println"),
  main_("main"),
  System_("System"),
  out_("out"),
  String_("String"),
  args_("args");

  @override
  final String lexeme;
  const KeyWordTokens(this.lexeme);

  static KeyWordTokens? check(String str) =>
      KeyWordTokens.values.where((e) => e.lexeme == str).firstOrNull;

  @override
  String encode() => "${Tokens.keyWord.lexeme}_$index";
}
