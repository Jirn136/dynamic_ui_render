import 'package:dynamic_ui_render/src/models/field_model.dart';
import 'package:dynamic_ui_render/utils/text_utils/text_utils.dart';
import 'package:flutter/material.dart';

Widget dropDownField(
    {required FieldModel model,
    ValueNotifier<String?>? selectedValueNotifier}) {
  var textModel = {'textColor': model.color};
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: model.label,
      labelStyle: parseTextStyle(textModel),
    ),
    hint: Text(
      model.hint,
      style: parseTextStyle(
        textModel,
      ),
    ),
    items: model.options?.map(
      (option) {
        return DropdownMenuItem(
          value: option,
          child: Text(option),
        );
      },
    ).toList(),
    onChanged: (value) {
      selectedValueNotifier!.value = value;
    },
    validator:
        model.isRequired ? (value) => value == null ? 'Required' : null : null,
  );
}
