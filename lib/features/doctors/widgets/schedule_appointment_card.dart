import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_fonts.dart';
import 'package:vetyo/constants/font_weight.dart';

class ScheduleAppointmentCard extends StatelessWidget {
  final String petName;
  final String appointmentType;
  final String timeLeft;
  final String appointmentTime;
  final String? imageUrl;
  final VoidCallback? onTap;

  const ScheduleAppointmentCard({
    super.key,
    required this.petName,
    required this.appointmentType,
    required this.timeLeft,
    required this.appointmentTime,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240.w,
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: ColorPalete.neutral.shade300,
                borderRadius: BorderRadius.circular(8.r),
                image:
                    imageUrl != null
                        ? DecorationImage(
                          image:
                              imageUrl!.startsWith('http')
                                  ? NetworkImage(imageUrl!) as ImageProvider
                                  : AssetImage(imageUrl!),
                          fit: BoxFit.cover,
                        )
                        : null,
              ),
              child: imageUrl == null ? Icon(Icons.pets, size: 30.sp) : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            petName,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: AppFontWeight.bold,
                              fontFamily: AppFonts.satoshi,
                            ),
                          ),
                          Text(
                            appointmentType,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorPalete.brightSky.shade700,
                              fontFamily: AppFonts.satoshi,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        timeLeft,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: AppFonts.satoshi,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 12.sp),
                      SizedBox(width: 4.w),
                      Text(
                        appointmentTime,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: AppFonts.satoshi,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
