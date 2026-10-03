import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class CaseAvatarItem extends StatelessWidget {
  final String petName;
  final String? imageUrl;
  final bool showOnlineStatus;
  final VoidCallback? onTap;

  const CaseAvatarItem({
    super.key,
    required this.petName,
    this.imageUrl,
    this.showOnlineStatus = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: ColorPalete.neutral.shade300,
                  backgroundImage:
                      imageUrl != null
                          ? (imageUrl!.startsWith('http')
                                  ? NetworkImage(imageUrl!)
                                  : AssetImage(imageUrl!))
                              as ImageProvider
                          : null,
                  child:
                      imageUrl == null ? Icon(Icons.pets, size: 28.sp) : null,
                ),
                if (showOnlineStatus)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        color: ColorPalete.healingGreen.shade500,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              petName,
              style: context.textBlackStyle().withSatoshi.largeBody,
            ),
          ],
        ),
      ),
    );
  }
}
