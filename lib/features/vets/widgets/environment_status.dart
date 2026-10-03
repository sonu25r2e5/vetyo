import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';

class EnvironmentStatus extends StatelessWidget {
  final String temperature;
  final String weatherStatus;
  final String riskLevel;
  final String riskDescription;
  final List<String> recommendations;

  const EnvironmentStatus({
    super.key,
    this.temperature = '32',
    this.weatherStatus = 'Sunny',
    this.riskLevel = 'Heat Stress Risk',
    this.riskDescription =
        'High temperature may affect animals and crops today. Active monitoring is recommended for heat-sensitive herbs.',
    this.recommendations = const [
      'Provide extra water and shade',
      'Avoid mid-day outdoor activity',
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(26.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFC5C5C5), width: 0.15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with sun icon and title
          Row(
            children: [
              Icon(Icons.wb_sunny, size: 32.sp, color: const Color(0xFFFDB022)),
              SizedBox(width: 10.w),
              Text(
                'Environment Status',
                style:
                    context
                        .textBlackStyle()
                        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700)
                        .withSatoshi,
              ),
            ],
          ),
          SizedBox(height: 18.h),

          // Temperature and weather status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$temperature°',
                    style: context.textBlackStyle().copyWith(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'C',
                    style: context.textBlackStyle().copyWith(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                weatherStatus,
                style: context
                    .textStyle(palette: ColorPalete.neutral, swatch: 700)
                    .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 18.h),

          // Heat Stress Risk badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ColorPalete.healingGreen[500]!.withValues(alpha: 0.3),
                  ColorPalete.brightSky[500]!.withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              riskLevel,
              style: context.textBlackStyle().copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // Risk description
          Text(
            riskDescription,
            style: context
                .textStyle(palette: ColorPalete.neutral, swatch: 700)
                .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 12.h),

          // Recommendations list
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                recommendations
                    .map(
                      (rec) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          children: [
                            Icon(
                              recommendations.indexOf(rec) == 0
                                  ? Icons.water_drop_outlined
                                  : Icons.landscape_outlined,
                              size: 12.sp,
                              color: const Color(0xFF314158),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                rec,
                                style: context
                                    .textStyle(
                                      palette: ColorPalete.neutral,
                                      swatch: 700,
                                    )
                                    .copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
