import 'package:flutter/material.dart';



Widget spacer({double x = 5, double y = 5}) => SizedBox(width: x, height: y);

Size screen(BuildContext context) => MediaQuery.of(context).size;

ColorScheme colors(BuildContext context) => Theme.of(context).colorScheme;