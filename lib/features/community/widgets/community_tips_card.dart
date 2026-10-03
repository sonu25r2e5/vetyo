import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';

class CommunityTipsCard extends StatelessWidget {
  const CommunityTipsCard({
    super.key,
    required this.question,
    required this.likes,
    required this.views,
    this.onTap,
    this.onLike,
  });

  final String question;
  final String likes;
  final String views;
  final VoidCallback? onTap;
  final VoidCallback? onLike;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Color(0xFFD2F5FF), // Light blue background
          border: Border.all(
            color: Color(0xFFB4EEFF), // Blue border
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top container with icon and question
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question mark icon container
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: ColorPalete.brightSky[500], // Primary brand color
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.question_mark,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: 14.h),

                // Question text
                Text(
                  question,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorPalete.supporting2[900],
                    fontFamily: "Satoshi",
                    height: 1.2,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Bottom container with likes and views
            Row(
              children: [
                // Likes container
                GestureDetector(
                  onTap: onLike,
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 16.sp,
                        color: ColorPalete.supporting2[600],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        likes,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorPalete.supporting2[600],
                          fontFamily: "Satoshi",
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 8.w),

                // Views container
                Row(
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      size: 16.sp,
                      color: ColorPalete.supporting2[600],
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      views,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorPalete.supporting2[600],
                        fontFamily: "Satoshi",
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
