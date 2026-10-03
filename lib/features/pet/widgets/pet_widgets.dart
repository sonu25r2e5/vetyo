import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class PetProfileCreationCard extends StatelessWidget {
  final VoidCallback? onCreatePressed;

  const PetProfileCreationCard({super.key, this.onCreatePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: ColorPalete.brightSky[100]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorPalete.brightSky[200]!, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildContent(context),
          SizedBox(height: 18.h),
          _buildCreateButton(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        // Title
        Text(
          "Create your pet's profile",
          style:
              context
                  .textStyle(palette: ColorPalete.supporting2)
                  .extraLarge
                  .bold,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),

        // Subtitle and Image section
        Column(
          children: [
            Text(
              "Add your furry friend and start their health journey",
              style:
                  context
                      .textStyle(palette: ColorPalete.supporting2)
                      .medium
                      .light,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),

            // Pet image
            SizedBox(
              width: 90.771.w,
              height: 50.031.h,
              child: Image.asset(AppImages.reddog2, fit: BoxFit.contain),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return SizedBox(
      width: 149.w,
      child: Container(
        height: 42.h,
        decoration: BoxDecoration(
          border: Border.all(color: ColorPalete.brightSky[900]!, width: 2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onCreatePressed,
            borderRadius: BorderRadius.circular(20.r),
            child: Center(
              child: Text(
                "Create",
                style:
                    context
                        .textStyle(palette: ColorPalete.brightSky, swatch: 950)
                        .medium
                        .medium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
