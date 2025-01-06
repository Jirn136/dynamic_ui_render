import 'package:dynamic_ui_render/ui_builder.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

import '../../utils/commons/commons.dart';

Widget buildButton(
    xml.XmlElement button,
    GlobalKey<FormState> formKey,
    Map<String, ValueNotifier<String?>> notifiers,
    ActionHandler onAction,
    Map<String, String> Function() getFormData) {
  final hint = button.getAttribute('Hint') ?? 'Button';
  final action = button.getAttribute('Action');
  final backgroundColor =
      parseColor(button.getAttribute("BackgroundColor").toString());
  final alignment = button.getAttribute('Alignment') ?? 'center';
  final padding = button.getAttribute('Padding');

  Widget buttonWidget = Flexible(
    flex: 1,
    child: Padding(
      padding: parsePadding(
        padding,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            final invalidFields = notifiers.entries.where((entry) {
              // Check if the value in the notifier is empty or null
              return entry.value.value?.isEmpty ?? true;
            }).toList();

            if (invalidFields.isNotEmpty) {
              // Handle invalid fields (e.g., show error messages)
              for (var field in invalidFields) {
                print("Field ${field.key} is invalid");
              }
            } else {
              // All required fields are valid, proceed with the action
              final formData = getFormData();
              if (action != null) {
                onAction(action, formData);
              }
            }
          } else {
            // Handle form validation errors
            print("if condition failed");
          }
        },
        child: Text(
          hint,
        ),
      ),
    ),
  );
  return centerAlignment(
    alignment,
    buttonWidget,
  );
}
