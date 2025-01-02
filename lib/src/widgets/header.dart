import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

Widget buildHeaderStyle(xml.XmlElement component, BuildContext context) {
  return Text(component.innerText,
      style: Theme.of(context).textTheme.headlineLarge);
}
