import 'package:flutter/material.dart';

Color parseColor(String colorStr) {
  if (colorStr.isEmpty || colorStr == 'Null') return Colors.black;
  // Check if the color string starts with '#', 'rgb', or '0x'
  if (colorStr.startsWith('#')) {
    String colorHex = colorStr.substring(1); // Remove the '#'
    if (colorHex.length == 6) {
      colorHex = 'FF$colorHex';
    }
    final hexColor = int.tryParse(colorHex, radix: 16);
    if (hexColor != null) {
      return Color(hexColor);
    }
  } else if (colorStr.startsWith('rgb')) {
    final regex = RegExp(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)');
    final match = regex.firstMatch(colorStr);
    if (match != null) {
      final r = int.tryParse(match.group(1) ?? '') ?? 0;
      final g = int.tryParse(match.group(2) ?? '') ?? 0;
      final b = int.tryParse(match.group(3) ?? '') ?? 0;
      return Color.fromRGBO(r, g, b, 1.0);
    }
  } else if (colorStr.startsWith('0x')) {
    final hexColor = int.tryParse(colorStr, radix: 16);
    if (hexColor != null) {
      return Color(hexColor);
    }
  }

  // Return default color (black) if parsing fails
  return Colors.black;
}

Widget centerAlignment(String alignment, Widget childWidget) {
  switch (alignment.toLowerCase()) {
    case 'center':
      return Center(child: childWidget);
    case 'left':
      return Align(alignment: Alignment.centerLeft, child: childWidget);
    case 'right':
      return Align(alignment: Alignment.centerRight, child: childWidget);
    default:
      return childWidget;
  }
}

EdgeInsets parsePadding(String? paddingString) {
  if (paddingString == null || paddingString.isEmpty) {
    return const EdgeInsets.all(8.0); // Default value
  }

  final values = paddingString.split(',').map((e) => double.tryParse(e.trim()) ?? 8.0).toList();

  switch (values.length) {
    case 1: // Single value, use for all sides
      return EdgeInsets.all(values[0]);
    case 2: // Two values, use symmetric (vertical, horizontal)
      return EdgeInsets.symmetric(vertical: values[0], horizontal: values[1]);
    case 4: // Four values, use only
      return EdgeInsets.fromLTRB(values[0], values[1], values[2], values[3]);
    default: // Any other case, use default
      return const EdgeInsets.all(8.0);
  }
}



