import 'models/lexical_analyzer_output.dart';
import 'state_machine/state_machine.dart';

import '../core/logger.dart';
import 'tokens/divider_tokens.dart';
import 'tokens/identiffier_token.dart';
import 'tokens/key_words_tokens.dart';
import 'tokens/operation_tokens.dart';
import 'tokens/token.dart';
import 'tokens/value_tokens.dart';

enum SemanticProcedure {
  p1,
  p2,
  p3,
  p4,
  p5,
  p6,
}

String kSample1JaveCode = """
int c = 3;
int b;
String f;
int a = 1;
int e3 = 2;
int chh = 0;
if (c > 2.79) {
    b = a * e3;
    f = "as ;ds";
    chh += 1;
}
int count = 0;
while(true) {
    count ++;
    if (count == 12) {
        break;
    }
}
""";

class LexicalAnalyzer {
  List<Token> outputTokens = [];
  List<IdentifierToken> identifiers = [];
  List<ValueToken> valuesNums = [];
  List<ValueToken> valuesBool = [];
  List<ValueToken> valuesString = [];

  void addToken(Token? token) {
    if (token != null) {
      outputTokens.add(token);
    }
  }

  int currentIndex = 0;
  String inputCode = '';

  void addAllTokens(List<Token?> tokens) => tokens.forEach(addToken);

  LexicalAnalyzerOutput execute(String inputCode) {
    logger.log(Log.info, title: "Start Lexical Analyze", message: inputCode);

    this.inputCode = inputCode;

    StateMachine stateMachine = StateMachine(inputCode);

    final buffer = StringBuffer();

    for (currentIndex = 0; currentIndex < inputCode.length; currentIndex++) {
      var char = inputCode[currentIndex];

      final (nextState, procedure) = stateMachine.execute(
        currentIndex,
        currentIndex == inputCode.length - 1,
      );

      final str = buffer.toString();

      final div = DividerTokens.check(char);

      switch (procedure) {
        case SemanticProcedure.p1:
          handleKeyWordsAndOperations(str);
          if (div == null) currentIndex--;
          handleDividers(char);
          break;
        case SemanticProcedure.p2:
          handleIdentifiers(str);
          handleDividers(char);
          break;
        case SemanticProcedure.p3:
          handleNumbers(str);
          handleDividers(char);
          break;
        case SemanticProcedure.p4:
          handleString(str);
          handleDividers(char);
          break;
        case SemanticProcedure.p5:
          handleOperations(char);
          handleDividers(char);
          break;
        case SemanticProcedure.p6:
          handleDividers(str);
          handleDividers(char);
          break;
        default:
          break;
      }

      if (nextState is S) buffer.clear();

      if (nextState is! S) buffer.write(char);

      // addToken(div);

      // if ([
      //   DividerTokens.whitespace,
      //   DividerTokens.newLine,
      //   DividerTokens.newLineWindows,
      // ].contains(div)) {
      //   addToken(div);
      // }
    }

    final output = LexicalAnalyzerOutput(
      tokens: outputTokens,
      keyWords: outputTokens.toSet().whereType<KeyWordTokens>().toList(),
      identifiers: identifiers,
      numberValues: valuesNums,
      stringValues: valuesString,
      boolValues: valuesBool,
      operations: outputTokens.toSet().whereType<OperationTokens>().toList(),
      dividers: outputTokens.toSet().whereType<DividerTokens>().toList(),
    );

    return output;
  }

  void handleKeyWordsAndOperations(String str) {
    // str = str.trim();
    Token? token = KeyWordTokens.check(str);
    if (token != null) {
      addToken(token);
    } else {
      token = OperationTokens.check(str);
      if (token != null) {
        handleOperations(str);
      } else {
        handleIdentifiers(str);
      }
    }
  }

  void handleIdentifiers(String str) {
    // if (DividerTokens.check(str) != null || str.isEmpty) return;
    IdentifierToken? token;

    bool? b = bool.tryParse(str);
    if (b != null) {
      var token = ValueToken(valuesBool.length, ValueTypeTokens.bool, str);
      valuesBool.add(token);
      addToken(token);
      return;
    }

    for (final identifier in identifiers) {
      if (identifier.value == str) token = identifier;
    }

    if (token == null) {
      var count = str.length;
      token = IdentifierToken(identifiers.length, str);
      identifiers.add(token);
    }

    addToken(token);
  }

  void handleNumbers(String str) {
    str = str.replaceAll(' ', '');
    ValueToken? token;

    if (num.tryParse(str) != null) {
      if (int.tryParse(str) != null) {
        token = ValueToken(valuesNums.length, ValueTypeTokens.int, str);
      } else {
        token = ValueToken(valuesNums.length, ValueTypeTokens.double, str);
      }
      valuesNums.add(token);
      addToken(token);
    } else {
      // throw Exception("handleNumbers error");
    }
  }

  void handleString(String str) {
    final token = ValueToken(valuesString.length, ValueTypeTokens.string, str);
    valuesString.add(token);
    addToken(token);
  }

  void handleOperations(String str) {
    var token = OperationTokens.check(str + inputCode[currentIndex + 1]);
    if (token != null) {
      currentIndex++;
    }
    token ??= OperationTokens.check(str);
    addToken(token);
  }

  void handleDividers(String str) {
    final token = DividerTokens.check(str);
    addToken(token);
  }
}
