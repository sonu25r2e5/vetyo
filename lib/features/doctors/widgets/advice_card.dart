import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdviceCard extends StatelessWidget {
  final String question;
  final int likes;
  final int views;
  final IconData icon;

  const AdviceCard({
    super.key,
    required this.question,
    required this.likes,
    required this.views,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFD2F5FF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFB4EEFF), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon container
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1DCDFE),
            ),
            child: Icon(icon, size: 20.sp, color: Colors.white),
          ),
          SizedBox(height: 14.h),
          // Question text
          Text(
            question,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF062933),
              fontFamily: 'Satoshi',
              height: 1.2,
            ),
          ),
          SizedBox(height: 24.h),
          // Likes and Views row
          Row(
            children: [
              // Likes
              Icon(
                Icons.favorite_border,
                size: 16.sp,
                color: const Color(0xFF62748E),
              ),
              SizedBox(width: 4.w),
              Text(
                likes > 999
                    ? '${(likes / 1000).toStringAsFixed(1)}k'
                    : '$likes',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF62748E),
                  fontFamily: 'Satoshi',
                  height: 1.2,
                ),
              ),
              SizedBox(width: 8.w),
              // Views
              Icon(
                Icons.visibility_outlined,
                size: 16.sp,
                color: const Color(0xFF62748E),
              ),
              SizedBox(width: 4.w),
              Text(
                views > 999
                    ? '${(views / 1000).toStringAsFixed(1)}k'
                    : '$views',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF62748E),
                  fontFamily: 'Satoshi',
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
