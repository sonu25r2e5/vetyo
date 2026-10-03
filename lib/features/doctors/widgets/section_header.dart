import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_fonts.dart';
import 'package:vetyo/constants/font_weight.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: AppFontWeight.semiBold,
            fontFamily: AppFonts.satoshi,
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              'See all',
              style: TextStyle(fontSize: 12.sp, fontFamily: AppFonts.satoshi),
            ),
          ),
      ],
    );
  }
}

class SectionContainer extends StatelessWidget {
  final String title;
  final Widget content;
  final double height;
  final VoidCallback? onSeeAll;

  const SectionContainer({
    super.key,
    required this.title,
    required this.content,
    required this.height,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: title, onSeeAll: onSeeAll),
        SizedBox(height: 12.h),
        SizedBox(height: height, child: content),
      ],
    );
  }
}
