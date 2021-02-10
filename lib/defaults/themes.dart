
import 'package:flutter/material.dart';

class DefaultThemes {

  static final Color primaryLight = Colors.blueGrey;
  static final Color primaryDark = Colors.black87;
  static final Color secondary = Colors.deepOrangeAccent;

  static Color getRefreshingCardColor(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      print("white");
      return Colors.white70;
    } else {
      print("black");
      return Colors.black12;
    }
  }

  static ThemeData appTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryLight,
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryDark,
    );
  }

}