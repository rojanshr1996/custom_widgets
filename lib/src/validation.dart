part of custom_widgets;

String? validateEmail({required BuildContext context, required String value, String fieldName = "Email"}) {
  value = value.trim();
  if (value.isEmpty) {
    return "$fieldName cannot be empty";
  }
  String regExpression = r"^(?=^.{6,255}$)([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,85}$";
  RegExp regExp = RegExp(regExpression);
  if (!regExp.hasMatch(value)) {
    return "Enter a valid email";
  }
  return null;
}

String? validatePassword(
    {required BuildContext context, required String value, bool validateLength = false, String? comparePassword = ""}) {
  if (value.isEmpty) {
    return "Password cannot be empty";
  } else if (validateLength) {
    if (!(value.length >= 8) && value.isNotEmpty) {
      return "Password should contains alteast 8 character";
    }
  } else if (comparePassword != "") {
    if (comparePassword! != value) {
      return "Password does not match";
    }
  }

  return null;
}

String? validateField(
    {required BuildContext context, String? value, required String fieldName, int minCharater = 0, int? maxCharacter}) {
  if (value!.isEmpty) {
    return "$fieldName cannot be empty";
  } else if (!(value.length >= minCharater) && value.isNotEmpty) {
    return "$fieldName should contains alteast $minCharater character";
  } else if (maxCharacter != null && value.length >= maxCharacter) {
    return "$fieldName has exceeded $maxCharacter characters";
  }
  return null;
}

String getInitialsFromString(String name) {
  List<String> names = name.split(" ");
  String initials = "";
  int numWords = 1;

  if (numWords < names.length) {
    numWords = names.length;
  }
  for (var i = 0; i < numWords; i++) {
    initials += names[i][0];
  }
  return initials;
}

List<TextSpan> highlightTextOccurrences(
    {required String source, required String query, Color textColor = Colors.black}) {
  if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
    return [TextSpan(text: source)];
  }
  final matches = query.toLowerCase().allMatches(source.toLowerCase());

  int lastMatchEnd = 0;

  final List<TextSpan> children = [];
  for (var i = 0; i < matches.length; i++) {
    final match = matches.elementAt(i);

    if (match.start != lastMatchEnd) {
      children.add(TextSpan(
        text: source.substring(lastMatchEnd, match.start),
      ));
    }

    children.add(TextSpan(
      text: source.substring(match.start, match.end),
      style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
    ));

    if (i == matches.length - 1 && match.end != source.length) {
      children.add(TextSpan(
        text: source.substring(match.end, source.length),
      ));
    }

    lastMatchEnd = match.end;
  }
  return children;
}

getUuidIdentifier() {
  return const Uuid().v4();
}

Future<List<dynamic>> loadCountryCode() async {
  String jsonStringValues = await rootBundle.loadString('lib/src/assets/country_code.json');
  List<dynamic> countryList = json.decode(jsonStringValues);
  return countryList;
}
