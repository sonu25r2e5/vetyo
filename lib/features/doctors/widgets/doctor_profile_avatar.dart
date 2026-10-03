import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_fonts.dart';
import 'package:vetyo/constants/font_weight.dart';

class DoctorProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final bool showOnlineStatus;
  final double? size;
  final VoidCallback? onTap;

  const DoctorProfileAvatar({
    super.key,
    required this.imageUrl,
    this.showOnlineStatus = true,
    this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? 92.w;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image:
                    imageUrl.startsWith('http')
                        ? NetworkImage(imageUrl) as ImageProvider
                        : AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (showOnlineStatus)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: ColorPalete.success.shade500,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DoctorProfileInfo extends StatelessWidget {
  final String name;
  final String specialty;
  final TextStyle? nameStyle;
  final TextStyle? specialtyStyle;

  const DoctorProfileInfo({
    super.key,
    required this.name,
    required this.specialty,
    this.nameStyle,
    this.specialtyStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style:
              nameStyle ??
              TextStyle(
                fontSize: 18.sp,
                fontWeight: AppFontWeight.bold,
                color: Colors.black,
                fontFamily: AppFonts.satoshi,
              ),
        ),
        SizedBox(height: 2.h),
        Text(
          specialty,
          style:
              specialtyStyle ??
              TextStyle(
                fontSize: 16.sp,
                fontWeight: AppFontWeight.medium,
                color: ColorPalete.brightSky.shade500,
                fontFamily: AppFonts.satoshi,
              ),
        ),
      ],
    );
  }
}
