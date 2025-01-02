import 'package:flutter/material.dart';

import '../commons/commons.dart';

FontWeight parseFontWeight(String weight) {
  switch (weight.toLowerCase()) {
    case 'bold':
      return FontWeight.bold;
    case 'w100':
      return FontWeight.w100;
    case 'w200':
      return FontWeight.w200;
    case 'w300':
      return FontWeight.w300;
    case 'w400':
      return FontWeight.w400;
    case 'w500':
      return FontWeight.w500;
    case 'w600':
      return FontWeight.w600;
    case 'w700':
      return FontWeight.w700;
    case 'w800':
      return FontWeight.w800;
    case 'w900':
      return FontWeight.w900;
    default:
      return FontWeight.normal; // Default to normal
  }
}

FontStyle parseFontStyle(String style) {
  switch (style.toLowerCase()) {
    case 'italic':
      return FontStyle.italic;
    case 'normal':
    default:
      return FontStyle.normal;
  }
}

TextStyle parseTextStyle(Map<String, dynamic> ts) {
  if (ts.isEmpty) {
    return TextStyle(); // Default text style
  }
  return TextStyle(
    fontFamily: ts['fontFamily'] ?? '',
    fontSize: double.tryParse(ts['fontSize'].toString()),
    fontWeight: parseFontWeight(ts['fontWeight'].toString()),
    fontStyle: parseFontStyle(ts['fontStyle'] ?? ''),
    color: parseColor(ts['textColor'] ?? ''),
    letterSpacing: ts['letterSpacing'] ?? 1.0,
  );
}
