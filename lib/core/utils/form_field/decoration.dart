import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/extention/color_extention.dart';

class FormFieldDecoration {
  static InputBorder getFocusedBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: context.applyAppColor(palette: ColorPalete.brand, swatch: 700),
        width: 0.5,
      ),
    );
  }

  static InputBorder getBoarder() {
    return UnderlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12),
    );
  }

  // static InputBorder getEnabledBorder(BuildContext context) {
  //   return OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(config.radius ?? 20),
  //     borderSide: BorderSide(
  //       color: context.applyAppColor(palette: ColorPalete.brand, swatch: 700),
  //       width: 1.0,
  //     ),
  //   );
  // }
}
