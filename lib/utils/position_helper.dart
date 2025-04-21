import 'package:flutter/material.dart';

double heightToPosition(double height, BuildContext context) {
  double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
  return 1 - 2 * height / totalHeight;
} 