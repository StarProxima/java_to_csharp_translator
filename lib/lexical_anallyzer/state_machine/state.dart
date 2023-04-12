part of 'state_machine.dart';

sealed class State {
  bool _isNumber(String str) => int.tryParse(str) != null;
  bool _isKeyWord(String str) => KeyWordTokens.check(str) != null;
  bool _isDivider(String str) => DividerTokens.check(str) != null;
  bool _isOperation(String str) => OperationTokens.check(str) != null;
  bool _isSymbol(String str) =>
      !_isNumber(str) && !_isDivider(str) && !_isOperation(str);

  // ignore: prefer_final_fields
  static bool _isLastSymbol = false;
  // ignore: prefer_final_fields
  static String _inputCode = '';

  (State? nextState, SemanticProcedure? procedure) call(String str);
}
