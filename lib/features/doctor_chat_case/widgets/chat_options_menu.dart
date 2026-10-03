import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class ChatOptionsMenu extends StatelessWidget {
  const ChatOptionsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OptionMenuItem(
            icon: Iconoir.Search(
              width: 20.w,
              height: 20.h,
              color: ColorPalete.oceanTeal.shade700,
            ),
            label: 'Search conversation',
            onTap: () {
              Navigator.pop(context);
              // Handle search conversation
            },
          ),
          SizedBox(height: 4.h),
          OptionMenuItem(
            icon: Iconoir.MediaImage(
              width: 20.w,
              height: 20.h,
              color: ColorPalete.oceanTeal.shade700,
            ),
            label: 'Media & Links',
            onTap: () {
              // Handle view all media
              Navigator.pushNamed(context, RoutePaths.casesMediaScreen);
            },
          ),
          SizedBox(height: 4.h),
          OptionMenuItem(
            icon: Iconoir.Page(
              width: 20.w,
              height: 20.h,
              color: ColorPalete.oceanTeal.shade700,
            ),
            label: 'Prescriptions',
            onTap: () {
              Navigator.pop(context);
              // Handle pinned messages
            },
          ),
          OptionMenuItem(
            icon: Iconoir.Pin(
              width: 20.w,
              height: 20.h,
              color: ColorPalete.oceanTeal.shade700,
            ),
            label: 'Pinned Messages',
            onTap: () {
              Navigator.pop(context);
              // Handle pinned messages
            },
          ),
        ],
      ),
    );
  }
}

class OptionMenuItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;
  const OptionMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 36.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 12.w),

            Text(label, style: context.textBlackStyle().small.withSatoshi),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}
