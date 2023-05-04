import '../lexical_anallyzer/models/lexical_analyzer_output.dart';

import '../reverse_polish_entry/reverse_polish_entry.dart';
import 'another_language_model.dart';

class AnotherLanguageGenerator {
  List<String> stack = [];
  List<String> rezult = [];
  final List<String> binary = [
    '<',
    '<=',
    '!=',
    '>',
    '>=',
    '+',
    '-',
    '+=',
    '-=',
    '*',
    '/',
    '%',
    '*=',
    '/=',
    '**',
    '&&',
    '||'
  ];
  final List<String> unary = [
    '++',
    '--',
    '!',
  ];
  int subVars = 0;
  int tabLevel = 0;
  List<String> forsMark = [];

  AnotherLanguageGeneratorOutput execute(
    ReversePolishEntryOutput polishInput,
    LexicalAnalyzerOutput lexicalInput,
  ) {
    List<String> identifiers =
        lexicalInput.identifiers.map((e) => e.value.toString()).toList();
    List<String> constants = [
      ...lexicalInput.numberValues.map((e) => e.value.toString()),
      ...lexicalInput.stringValues.map((e) => '"${e.value}"')
    ];

    for (int i = 0; i < polishInput.result.length; i++) {
      int nowTabLevel = tabLevel;
      String token = polishInput.result[i];
      if (identifiers.contains(token) || constants.contains(token)) {
        stack.add(token);
      } else {
        if (binary.contains(token)) {
          subVars++;
          String tmp = stack.removeLast();
          rezult.add('V$subVars = ${stack.removeLast()} $token $tmp');
          stack.add('V$subVars');
        } else if (unary.contains(token)) {
          subVars++;
          rezult.add('V$subVars = $token ${stack.removeLast()}');
          stack.add('V$subVars');
        } else if (['=', '<-'].contains(token)) {
          String tmp = stack.removeLast();
          rezult.add('${stack.removeLast()} = $tmp');
        } else if (RegExp(r'(\d+)F').hasMatch(token)) {
          //fun
          token = token.substring(0, token.length - 1);
          String rez = ')';
          for (int i = int.parse(token) - 1; i > 0; i--) {
            rez = ', ${stack.removeLast()}$rez';
          }
          rez = '${stack.removeLast()}(${rez.substring(2)}';

          subVars++;
          rezult.add('V$subVars = $rez');
          stack.add('V$subVars');
        } else if (RegExp(r'(\d+)AEM').hasMatch(token)) {
          //index
          token = token.substring(0, token.length - 3);
          String rez = ']';
          for (int i = int.parse(token) - 1; i > 0; i--) {
            rez = ', ${stack.removeLast()}$rez';
          }
          rez = '${stack.removeLast()}[${rez.substring(2)}';

          subVars++;
          rezult.add('V$subVars = $rez');
          stack.add('V$subVars');
        } else if (RegExp(r'(\d+)M YPL').hasMatch(token)) {
          token = token.substring(0, token.length - 4);
          rezult.add('if not ${stack.removeLast()} :');
          rezult.add('\tgoto .$token');
        } else if (RegExp(r'(\d+)M BP').hasMatch(token)) {
          token = token.substring(0, token.length - 3);
          rezult.add('goto .$token');
        } else if (RegExp(r'(\d+)M:').hasMatch(token)) {
          token = token.substring(0, token.length - 1);
          if (forsMark.contains(token)) {
            rezult.removeLast();
            tabLevel--;
            nowTabLevel--;
          } else {
            rezult.add('label .$token');
          }
        } else if (token == ':') {
          String tmp = stack.removeLast();
          stack.add('${stack.removeLast()}, $tmp');
        } else if (token == 'in') {
          String tmp = stack.removeLast();
          rezult.removeLast();
          rezult.add('for ${stack.removeLast()} ($tmp):');
          i++;
          String endMark = polishInput.result[i].substring(0, 2);
          forsMark.add(endMark);
          tabLevel++;
        }

        for (int i = 0; i < nowTabLevel; i++) {
          rezult[rezult.length - 1] = '\t${rezult[rezult.length - 1]}';
        }
      }
    }

    return AnotherLanguageGeneratorOutput(rezult: rezult);
  }
}
