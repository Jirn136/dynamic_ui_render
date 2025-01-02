import 'package:dynamic_ui_render/src/models/field_model.dart';
import 'package:dynamic_ui_render/utils/text_utils/text_utils.dart';
import 'package:flutter/material.dart';

Widget inputFormField(
    {required FieldModel model,
    required TextEditingController controller}) {
  var textModel = {'textColor': model.color};
  var widget = TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: model.label,
      hintText: model.hint,
      labelStyle: parseTextStyle(textModel),
      hintStyle: parseTextStyle(textModel),
    ),
    keyboardType: _getInputType(model.type),
    validator: model.isRequired
        ? (value) => value?.isEmpty == true ? 'Required' : null
        : null,
  );
  return widget;
}

TextInputType? _getInputType(String type) {
  if (type.isEmpty) return TextInputType.text;
  switch (type) {
    case 'number':
      return TextInputType.number;
    case 'multiline':
      return TextInputType.multiline;
    case 'phone':
      return TextInputType.phone;
    case 'dateTime':
      return TextInputType.datetime;
    case 'email':
      return TextInputType.emailAddress;
    case 'url':
      return TextInputType.url;
    case 'visiblePassword':
      return TextInputType.visiblePassword;
    case 'name':
      return TextInputType.name;
    case 'streetAddress':
      return TextInputType.streetAddress;
    case 'none':
      return TextInputType.none;
  }
  return TextInputType.text;
}
