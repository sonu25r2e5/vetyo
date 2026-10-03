import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaseStudyCard extends StatelessWidget {
  final String title;
  final String description;
  final String tag;
  final String timestamp;
  final IconData icon;

  const CaseStudyCard({
    super.key,
    required this.title,
    required this.description,
    required this.tag,
    required this.timestamp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF8EE6FE), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D000000),
            blurRadius: 10.r,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            icon,
                            size: 16.sp,
                            color: const Color(0xFF1DCDFE),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Satoshi',
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF314158),
                          fontFamily: 'Satoshi',
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                  // RARE badge positioned at top-right
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 2.h,
                      ),
                      height: 18.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC9C9),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF9F0712),
                            fontFamily: 'Satoshi',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Container(height: 0.5, color: const Color(0xFFE5E5E5)),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 10.sp,
                color: const Color(0xFF4F4F4F),
              ),
              SizedBox(width: 8.w),
              Text(
                timestamp,
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF4F4F4F),
                  fontFamily: 'Satoshi',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
