final class AnotherLanguageGeneratorOutput {
  final List<String> rezult;
  final List<String> token = [];

  // create consctructor
  AnotherLanguageGeneratorOutput({
    required this.rezult,
  });

  AnotherLanguageGeneratorOutput.empty() : rezult = [];

  String get getBackText => token.fold(
      '',
      (previousValue, element) => previousValue == ''
          ? element
          : previousValue[previousValue.length - 1] == '\n'
              ? previousValue + element
              : previousValue + ' ' + element);
  //Босс, я устал говнокодить

  void generateTokens() {
    final tmpToken = convertToText().split(' ');
    for (int i = 0; i < tmpToken.length; i++) {
      if (tmpToken[i].contains('\n')) {
        List<String> tmp = tmpToken[i].replaceFirst('\n', ' ').split(' ');
        tmpToken[i] = tmp.last;
        tmpToken.insert(i, '\n');
        tmpToken.insert(i, tmp.first);
        i += 2;
      }
    }
    for (int i = 0; i < tmpToken.length; i++) {
      if (tmpToken[i].contains('(')) {
        List<String> tmp = tmpToken[i].replaceFirst('(', ' ').split(' ');
        tmpToken[i] = tmp.last;
        tmpToken.insert(i, '(');
        tmpToken.insert(i, tmp.first);
        i += 2;
      }
    }
    for (int i = 0; i < tmpToken.length; i++) {
      if (tmpToken[i].contains(')')) {
        List<String> tmp = tmpToken[i].replaceFirst(')', ' ').split(' ');
        tmpToken[i] = tmp.last;
        tmpToken.insert(i, ')');
        tmpToken.insert(i, tmp.first);
        i += 2;
      }
    }
    for (int i = 0; i < tmpToken.length; i++) {
      if (tmpToken[i].contains('[')) {
        List<String> tmp = tmpToken[i].replaceFirst('[', ' ').split(' ');
        tmpToken[i] = tmp.last;
        tmpToken.insert(i, '[');
        tmpToken.insert(i, tmp.first);
        i += 2;
      }
    }
    for (int i = 0; i < tmpToken.length; i++) {
      if (tmpToken[i].contains(']')) {
        List<String> tmp = tmpToken[i].replaceFirst(']', ' ').split(' ');
        tmpToken[i] = tmp.last;
        tmpToken.insert(i, ']');
        tmpToken.insert(i, tmp.first);
        i += 2;
      }
    }
    for (int i = 0; i < tmpToken.length; i++) {
      if (tmpToken[i].contains(',')) {
        List<String> tmp = tmpToken[i].replaceFirst(',', ' ').split(' ');
        tmpToken[i] = tmp.last;
        tmpToken.insert(i, ',');
        tmpToken.insert(i, tmp.first);
        i += 2;
      }
    }
    tmpToken.removeWhere((element) => element == '');
    tmpToken.add('');

    token.addAll(tmpToken);
  }

  String convertToText() {
    return rezult.fold(
      '',
      (previousValue, element) =>
          previousValue == '' ? element : '$previousValue\n$element',
    );
  }
}
