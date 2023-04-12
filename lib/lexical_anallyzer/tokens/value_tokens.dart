import 'token.dart';

enum ValueTypeTokens {
  int("Ni"),
  float("Nf"),
  double("Nd"),
  string("S"),
  bool("B");

  final String mark;
  const ValueTypeTokens(this.mark);
}

class ValueToken implements Token, ValToken {
  final int id;

  final ValueTypeTokens type;
  @override
  final dynamic value;

  @override
  String get lexeme => type.mark;

  ValueToken(this.id, this.type, this.value);

  @override
  String encode() => "${type.mark}_$id";
}
