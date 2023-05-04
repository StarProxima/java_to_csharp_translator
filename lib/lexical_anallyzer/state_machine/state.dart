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

final kReversePolishEntry =
    '''static void Main string АЭМ args 1 1 НП x int n int d int x 453 = d 0 =  x 0 > М1 УПЛ d x 10 % = n 3 == n 5 > || М3 УПЛ n n d + = М3 x x 10 / = М1 БП double Func a double 2 2 КО 2 2 НП a a * 4 * БП КП funcNumber double 1Ф funcNumber Func 6 2 Ф = КП static bool IsEven n int 3 1 НП  n 2 % 0 == БП КП''';
