import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';

// Asset URLs from Figma
const String _dogIllustration =
    "https://www.figma.com/api/mcp/asset/c1e1284a-46ac-42cd-85ad-289045fb5c89";

class HeathAdvisory extends StatelessWidget {
  const HeathAdvisory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(19.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: ColorPalete.brightSky[400] ?? const Color(0xFF43D5FE),
          width: 0.15,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Icon and Title
          Row(
            children: [
              Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        ColorPalete.brightSky[600] ?? const Color(0xFF18ABD4),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.warning_outlined,
                  size: 12.sp,
                  color: ColorPalete.brightSky[600] ?? const Color(0xFF18ABD4),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'Health Advisory',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Satoshi',
                  color: const Color(0xFF0F172B),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Dog Illustration (simplified - using placeholder)
          Center(
            child: Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.grey.shade100,
              ),
              child: Center(
                child: Image.network(
                  _dogIllustration,
                  height: 100.h,
                  width: 120.w,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.pets,
                      size: 48.sp,
                      color: Colors.grey.shade400,
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Advisory Title
          Text(
            'Tick & flea surge . Monsoon season',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Satoshi',
              color: ColorPalete.brightSky[800] ?? const Color(0xFF0F677F),
              height: 1.0,
            ),
          ),
          SizedBox(height: 10.h),

          // Advisory Description
          Text(
            'High humidity levels are accelerating parasite breeding across the region',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              fontFamily: 'Satoshi',
              color: const Color(0xFF314158),
              height: 1.0,
            ),
          ),
          SizedBox(height: 10.h),

          // Tips Section
          _buildAdvisoryTip(
            context,
            'Check coat daily, especially after walks',
          ),
          SizedBox(height: 10.h),
          _buildAdvisoryTip(
            context,
            'Administer preventive medication\nimmediately.',
          ),
          SizedBox(height: 10.h),
          _buildAdvisoryTip(
            context,
            'Sanitize pet bedding with flea-repellent\nspray',
          ),
        ],
      ),
    );
  }

  Widget _buildAdvisoryTip(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorPalete.brightSky[300] ?? const Color(0xFF68DEFE),
          ),
          child: Center(
            child: Icon(Icons.check, size: 10.sp, color: Colors.white),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
              fontFamily: 'Satoshi',
              color: const Color(0xFF1D293D),
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
