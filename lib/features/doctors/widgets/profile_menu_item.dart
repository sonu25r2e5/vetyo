import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_fonts.dart';
import 'package:vetyo/constants/font_weight.dart';
import 'package:vetyo/core/common/custom_listview/custom_list_tile.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showArrow;
  final Color? iconColor;
  final Color? titleColor;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.showArrow = true,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onPress: onTap,
      leading: Icon(
        icon,
        size: 24.sp,
        color: iconColor ?? ColorPalete.supporting2.shade800,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: AppFontWeight.medium,
          color: titleColor ?? ColorPalete.supporting2.shade800,
          fontFamily: AppFonts.satoshi,
        ),
      ),
      trailing:
          showArrow
              ? Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: ColorPalete.supporting2.shade800,
              )
              : null,
    );
  }
}
