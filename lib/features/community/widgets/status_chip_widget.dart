import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class UserType extends StatelessWidget {
  final String userType;

  const UserType({required this.userType, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ColorPalete.brightSky.shade50,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            userType,
            style: context.textBlackStyle().medium.bold.withSatoshi.copyWith(
              color: ColorPalete.brightSky.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
