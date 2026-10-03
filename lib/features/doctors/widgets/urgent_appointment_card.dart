import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_fonts.dart';
import 'package:vetyo/constants/font_weight.dart';

class UrgentAppointmentCard extends StatelessWidget {
  final String petName;
  final String species;
  final String severity;
  final String timeAgo;
  final String appointmentTime;
  final String symptoms;
  final VoidCallback? onRefer;
  final VoidCallback? onViewDetails;

  const UrgentAppointmentCard({
    super.key,
    required this.petName,
    required this.species,
    required this.severity,
    required this.timeAgo,
    required this.appointmentTime,
    required this.symptoms,
    this.onRefer,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,

      
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorPalete.error.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorPalete.error.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$petName ($species)',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: AppFontWeight.bold,
                      fontFamily: AppFonts.satoshi,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorPalete.error.shade200,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      severity,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: ColorPalete.error.shade600,
                        fontFamily: AppFonts.satoshi,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                timeAgo,
                style: TextStyle(fontSize: 12.sp, fontFamily: AppFonts.satoshi),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(height: 1),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.access_time, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                appointmentTime,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: AppFontWeight.medium,
                  fontFamily: AppFonts.satoshi,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '"$symptoms"',
            style: TextStyle(fontSize: 12.sp, fontFamily: AppFonts.satoshi),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'Refer',
                  onTap: onRefer,
                  isOutlined: true,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _ActionButton(
                  label: 'View Details',
                  onTap: onViewDetails,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isOutlined;

  const _ActionButton({
    required this.label,
    this.onTap,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
          color:
              isOutlined ? Colors.transparent : ColorPalete.brightSky.shade300,
          border:
              isOutlined
                  ? Border.all(color: ColorPalete.brightSky.shade300)
                  : null,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 14.sp, fontFamily: AppFonts.satoshi),
          ),
        ),
      ),
    );
  }
}
