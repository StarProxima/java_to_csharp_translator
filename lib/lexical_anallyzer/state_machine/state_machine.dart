import '../lexical_analyzer.dart';
import '../../core/logger.dart';
import '../tokens/divider_tokens.dart';
import '../tokens/key_words_tokens.dart';
import '../tokens/operation_tokens.dart';

part 'state.dart';
part 'states.dart';

final class StateMachine {
  final String inputCode;

  State? _currentState = S();

  StateMachine(this.inputCode);

  Stream<(State?, SemanticProcedure?)> executeStream(
    String str,
    bool isLastLine,
  ) async* {
    State._isLastSymbol = isLastLine;
    while (_currentState != null) {
      final out = _currentState!(str);
      yield out;
      _currentState = out.$1;
    }
  }

  (State?, SemanticProcedure?) execute(int symbolIndex, bool isLastSymbol) {
    State._isLastSymbol = isLastSymbol;
    State._inputCode = inputCode;
    var out = _currentState!(inputCode[symbolIndex]);
    _currentState = out.$1;
    return out;
  }
}
