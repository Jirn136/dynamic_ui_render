import 'package:dynamic_ui_render/src/widgets/elevated_button.dart';
import 'package:dynamic_ui_render/src/widgets/header.dart';
import 'package:dynamic_ui_render/src/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

typedef ActionHandler = void Function(String action, Map<String, String> data);

class DynamicUiBuilder {
  final String xmlData;
  final ActionHandler onAction;
  late BuildContext _context;

  DynamicUiBuilder(this.xmlData, this.onAction);

  final Map<String, TextEditingController> _controllers = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, ValueNotifier<String?>> _notifiers = {};

  Widget build() {
    final document = xml.XmlDocument.parse(xmlData);
    final miniAppSteps = document.findAllElements('MiniAppStep');

    return PageView.builder(
      itemCount: miniAppSteps.length,
      itemBuilder: (context, index) {
        _context = context;
        final step = miniAppSteps.elementAt(index);
        return _buildStep(step);
      },
    );
  }

  Widget _buildStep(xml.XmlElement step) {
    final ui = step.findElements('UI').first;
    final form = ui.findElements('Form').first;

    return Form(
      key: _formKey,
      child: Column(
        children: form.children
            .whereType<xml.XmlElement>()
            .map((child) => _buildComponent(child))
            .whereType<Widget>() // Filter out nulls
            .toList(),
      ),
    );
  }

  Widget _buildLayout(xml.XmlElement component) {
    if (component.name.local == 'Row') {
      return Row(
        children: component.children
            .whereType<xml.XmlElement>()
            .map((child) =>
                _buildComponent(child, true) ?? const SizedBox.shrink())
            .toList(),
      );
    } else if (component.name.local == 'Column') {
      return Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: component.children
              .whereType<xml.XmlElement>()
              .map((child) =>
                  _buildComponent(child, false) ?? const SizedBox.shrink())
              .toList(),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget? _buildComponent(xml.XmlElement component, [bool? isRow]) {
    if (component.name.local != "Form") {
      print("component:: ${component.name.local}");
      switch (component.name.local) {
        case 'Header':
          return buildHeaderStyle(component, _context);
        case 'Input':
          return buildInput(component, isRow, _controllers, _notifiers);
        case 'Button':
          return buildButton(
              component, _formKey, _notifiers, onAction, _getFormData);
        case 'Image':
        // return _buildImage(component);
        case 'Data':
          return Text(component.getAttribute('Content') ?? '');
        default:
          return _buildLayout(component);
      }
    } else {
      return null;
    }
  }

  Map<String, String> _getFormData() {
    final formData = <String, String>{};

    // Add values from controllers
    _controllers.forEach((key, controller) {
      formData[key] = controller.text;
    });

    // Add values from notifiers
    _notifiers.forEach((key, notifier) {
      formData[key] = notifier.value ?? '';
    });

    return formData;
  }

  /*Widget _buildImage(xml.XmlElement image) {
    final url = image.getAttribute('Url');
    if (url == null) return const SizedBox.shrink();
    final padding = style['padding'] ?? EdgeInsets.all(0);

    return GestureDetector(
      onTap: () {
        // Handle image tap if needed
      },
      child: Padding(
        padding: padding,
        child: Image.network(url),
      ),
    );
  }*/

  Widget _buildGenericComponent(xml.XmlElement component) {
    final content = component.innerText;
    final padding = EdgeInsets.all(8.0);
    final color = Colors.black;
    final fontSize = 14.0;

    return Padding(
      padding: padding,
      child: Text(
        content,
        style: TextStyle(color: color, fontSize: fontSize),
      ),
    );
  }
}
