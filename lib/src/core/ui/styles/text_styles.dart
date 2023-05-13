import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  String get fontFamily => 'mplus1';

  TextStyle get light => TextStyle(
        fontWeight: FontWeight.w300,
        fontFamily: fontFamily,
      );
  TextStyle get regular => TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      );
  TextStyle get medium => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
      );
  TextStyle get semiBold => TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
      );
  TextStyle get bold => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
      );
  TextStyle get extraBold => TextStyle(
        fontWeight: FontWeight.w800,
        fontFamily: fontFamily,
      );

  TextStyle get buttonLabel => bold.copyWith(fontSize: 14);
  TextStyle get title => extraBold.copyWith(fontSize: 22);
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}
