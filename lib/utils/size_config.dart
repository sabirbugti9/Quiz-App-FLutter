import 'package:flutter/material.dart';

class SizeConfig {
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double width(BuildContext context, {required double w}) {
    var value = screenWidth(context) * (w / 375);
    return value;
  }

  static double height(BuildContext context, {required double h}) {
    var value = screenWidth(context) * (h / 812);
    return value;
  }
}
