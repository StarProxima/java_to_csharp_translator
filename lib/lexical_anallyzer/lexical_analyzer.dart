import 'package:flutter/material.dart';

import '../core/logger.dart';
import 'tokens/divider_tokens.dart';
import 'tokens/identiffier_token.dart';
import 'tokens/key_words_tokens.dart';
import 'tokens/operation_tokens.dart';
import 'tokens/token.dart';
import 'tokens/value_tokens.dart';

class LexicalAnalyzer {
  String sampleCode = """

		    double c = 3;
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

  String sampleCode2 = """
public class Main
{
	public static void main(String[] args) {
		    double c = 3;
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
            count++;
            if (count == 12) {
                break;
            }
        }
	}
}
""";

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

  void addAllTokens(List<Token?> tokens) => tokens.forEach(addToken);

  List<Token> execute(String inputCode) {
    logger.log(Log.info, title: "Start Lexical Analyze", message: inputCode);
    final buffer = StringBuffer();
    var isInString = false;

    for (int i = 0; i < inputCode.characters.length; i++) {
      var char = inputCode.characters.elementAt(i);

      var divider = DividerTokens.check(char);

      if (divider != null) {
        var str = buffer.toString();

        if (divider == DividerTokens.dot) {
          if (i > 0 && i < inputCode.characters.length - 1) {
            var prev = int.tryParse(inputCode.characters.elementAt(i - 1));
            var next = int.tryParse(inputCode.characters.elementAt(i + 1));
            if (prev != null && next != null) {
              buffer.write(char);
              continue;
            }
          }
        }

        if (divider == DividerTokens.quotes) {
          if (isInString) {
            handleString(str, divider);
            isInString = false;
            buffer.clear();
            continue;
          } else {
            isInString = true;
          }
        }

        if (isInString) {
          buffer.write(char);
        } else {
          if (buffer.isNotEmpty) {
            if (!handleKeyWords(str, divider)) {
              if (!handleOperations(str, divider)) {
                if (!handleValues(str, divider)) {
                  if (!handleIdentifiers(str, divider)) {
                    logger.log(
                      Log.warning,
                      title: "Failed to process text",
                      message: str,
                    );
                  }
                }
              }
            }
          }

          addToken(divider);
          buffer.clear();
        }
      } else {
        buffer.write(char);
      }
    }

    return outputTokens;
  }

  bool handleKeyWords(String str, DividerTokens divider) {
    KeyWordTokens? token = KeyWordTokens.check(str);
    if (token != null) {
      addToken(token);
    }
    return token != null;
  }

  bool handleOperations(String str, DividerTokens divider) {
    OperationTokens? token = OperationTokens.check(str);
    if (token != null) {
      addToken(token);
    }
    return token != null;
  }

  bool handleIdentifiers(String str, DividerTokens divider) {
    IdentifierToken? token;
    bool notStartWithNum = int.tryParse(str[0]) == null;
    bool notContainsSpecialSymbols = !str.trim().contains(RegExp(r"\W"));
    if (str.isNotEmpty && notStartWithNum && notContainsSpecialSymbols) {
      token = IdentifierToken(identifiers.length, str);
    }

    if (token != null) {
      addToken(token);
      identifiers.add(token);
    }
    return token != null;
  }

  bool handleValues(String str, DividerTokens divider) {
    ValueToken? token;
    if (num.tryParse(str) != null) {
      if (int.tryParse(str) != null) {
        token = ValueToken(valuesNums.length, ValueTypeTokens.int, str);
      } else {
        token = ValueToken(valuesNums.length, ValueTypeTokens.double, str);
      }
      valuesNums.add(token);
    } else if (str == "true" || str == "false") {
      token = ValueToken(valuesBool.length, ValueTypeTokens.bool, str);
      valuesBool.add(token);
    }
    if (token != null) {
      addToken(token);
    }
    return token != null;
  }

  void handleString(String str, DividerTokens divider) {
    ValueToken token =
        ValueToken(valuesString.length, ValueTypeTokens.string, str);
    addToken(token);
    valuesString.add(token);
  }
}
