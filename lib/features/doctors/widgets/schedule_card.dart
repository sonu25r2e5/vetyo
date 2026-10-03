import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_fonts.dart';
import 'package:vetyo/constants/font_weight.dart';

class ScheduleCard extends StatelessWidget {
  final String nextSlot;
  final String schedule;
  final VoidCallback? onTap;

  const ScheduleCard({
    super.key,
    required this.nextSlot,
    required this.schedule,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFCFEFF),
          border: Border.all(color: ColorPalete.brightSky.shade500, width: 1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nextSlot,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: AppFontWeight.medium,
                      color: Colors.black,
                      fontFamily: AppFonts.satoshi,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    schedule,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: AppFontWeight.regular,
                      color: Colors.black,
                      fontFamily: AppFonts.satoshi,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.calendar_today_outlined,
              size: 24.sp,
              color: ColorPalete.supporting2.shade800,
            ),
          ],
        ),
      ),
    );
  }
}
