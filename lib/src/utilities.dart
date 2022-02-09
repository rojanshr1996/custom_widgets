part of custom_widgets;

class Utilities {
  static doubleBack(BuildContext context) {
    Utilities.closeActivity(context);
    Utilities.closeActivity(context);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static double screenWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  static double screenHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight;
  }

  static Orientation screenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  static getSnackBar({required BuildContext context, required SnackBar snackBar}) {
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<dynamic> openActivity(context, object) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => object),
    );
  }

  static Future<dynamic> fadeOpenActivity(context, object) async {
    return await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return object;
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  static Future<dynamic> fadeReplaceActivity(context, object) async {
    return await Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return object;
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  static void replaceActivity(context, object) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => object),
    );
  }

  static replaceNamedActivity(context, routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static openNamedActivity(context, routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void removeStackActivity(context, object) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => object), (r) => false);
  }

  static void removeNamedStackActivity(context, routeName, {Object? arguments}) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false, arguments: arguments);
  }

  static void closeActivity(context) {
    Navigator.pop(context);
  }

  static void returnDataCloseActivity(context, object) {
    Navigator.pop(context, object);
  }

  static String encodeJson(dynamic jsonData) {
    return json.encode(jsonData);
  }

  static dynamic decodeJson(String jsonString) {
    return json.decode(jsonString);
  }

  static String shortString(String str, [int length = 50]) {
    if (str.length > length) {
      return str.substring(0, length) + "...";
    } else {
      return str;
    }
  }

  static Widget myImage({required String imageUrl, double? width, double? height, fit}) {
    return Image.network(imageUrl, width: width, height: height, fit: fit ?? BoxFit.cover);
  }

  static bool isIOS() {
    return Platform.isIOS;
  }

  static bool keyboardIsVisible(BuildContext context) {
    return (MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  static fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
