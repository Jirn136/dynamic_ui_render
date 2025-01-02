import 'dart:ui';

class FieldModel {
  String label;
  String hint;
  String color;
  String type;
  bool isRequired;
  List<String>? options;

  FieldModel({
    required this.label,
    required this.hint,
    required this.color,
    required this.type,
    required this.isRequired,
    this.options,
  });
}
