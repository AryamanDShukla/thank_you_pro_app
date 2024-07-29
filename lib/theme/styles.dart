import 'package:flutter/material.dart';
import 'package:thank_you_pro/utils/strings/strings.dart';

class Styles {
  // static Color primary = const Color.fromARGB(255, 0, 49, 83);
  static Color primary = const Color.fromARGB(255, 29, 38, 86);
  static Color blackColor = Colors.black;
  static Color orangeColor = const Color.fromARGB(255, 255, 140, 0);
  static Color greenColor = Colors.green;
  static Color whiteColor = Colors.white;
  static Color red = Colors.red;

  static TextStyle largeText(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).canvasColor,
        fontSize: 25,
        fontFamily: Strings.appFontThird,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w400);
  }

  static TextStyle largeBoldText(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).canvasColor,
        fontSize: 25,
        fontFamily: Strings.appFontThird,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w600);
  }

  static TextStyle mediumText(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).canvasColor,
        fontSize: 16,
        fontFamily: Strings.appFontThird,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w400);
  }

  static TextStyle mediumBoldText(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).canvasColor,
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
        fontFamily: Strings.appFontThird,
        fontWeight: FontWeight.w600);
  }

  static TextStyle smallBoldText(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).canvasColor,
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
        fontFamily: Strings.appFontThird,
        fontWeight: FontWeight.w600);
  }

  static TextStyle smallText(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).canvasColor,
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
        fontFamily: Strings.appFontThird,
        fontWeight: FontWeight.w500);
  }
}
