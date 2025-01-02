import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

import '../../utils/commons/commons.dart';
import '../models/field_model.dart';
import 'drop_down_field.dart';
import 'input_form_field.dart';

Widget buildInput(
    xml.XmlElement input,
    bool? isRow,
    Map<String, TextEditingController> controllers,
    Map<String, ValueNotifier<String?>> notifiers) {

  final label = input.getAttribute('Label') ?? '';
  final hint = input.getAttribute('Hint') ?? '';
  final type = input.getAttribute('Type');
  final required = input.getAttribute('Required') == 'true';
  final options = input
      .getAttribute('Options')
      ?.split(input.getAttribute('Delimiter') ?? ',');
  final color = input.getAttribute('Color').toString();
  final padding = input.getAttribute('Padding');

  final controller = TextEditingController();
  if (type != 'select' && required) {
    controllers[label] = controller;
  }

  final ValueNotifier<String?> notifier = ValueNotifier(null);
  if (type == 'Select'.toLowerCase() && required) {
    notifiers[label] = notifier;
  }

  switch (type) {
    case 'phone':
    case 'number':
      return Flexible(
        flex: 2,
        child: Padding(
          padding: parsePadding(
            padding,
          ),
          child: inputFormField(
            model: FieldModel(
              label: label,
              hint: hint,
              color: color,
              type: type.toString(),
              isRequired: required,
            ),
            controller: controller,
          ),
        ),
      );
    case 'select':
      return Flexible(
        flex: 1,
        child: Padding(
          padding: parsePadding(
            padding,
          ),
          child: dropDownField(
              model: FieldModel(
                label: label,
                hint: hint,
                color: color,
                type: type.toString(),
                isRequired: required,
                options: options,
              ),
              selectedValueNotifier: notifier),
        ),
      );
    default:
      return const SizedBox.shrink();
  }
}
