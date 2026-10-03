import 'package:flutter/material.dart';
import 'package:vetyo/constants/font_weight.dart';

extension AppFontWeightExtention on BuildContext {
  FontWeight get bold => AppFontWeight.bold;
  FontWeight get semiBold => AppFontWeight.semiBold;
  FontWeight get medium => AppFontWeight.medium;
  FontWeight get regular => AppFontWeight.regular;
  FontWeight get light => AppFontWeight.light;
}
