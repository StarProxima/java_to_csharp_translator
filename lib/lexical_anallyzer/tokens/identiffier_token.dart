import 'token.dart';

class IdentifierToken implements Token, ValToken {
  final int id;

  @override
  final dynamic value;

  @override
  final String lexeme = "I";
  IdentifierToken(this.id, this.value);

  @override
  String encode() => "${lexeme}_$id";
}
