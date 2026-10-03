import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/language/cubit/language_cubit.dart';
import 'package:vetyo/core/language/l10n.dart';

class BackgroundWithImageWidget extends StatelessWidget {
  const BackgroundWithImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 36.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: _buildLanguageSwitchButton(context),
            ),
          ),

          /// Center Logo
          Center(
            child: Image.asset(AppImages.appImage, width: 120.w, height: 180.h),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSwitchButton(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, currentLocale) {
        return Material(
          color: Colors.transparent,
          child: PopupMenuButton<String>(
            onSelected: (languageCode) {
              context.read<LanguageCubit>().changeLanguage(languageCode);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 6,
            color: Colors.white,
            offset: Offset(0, 10.h),

            itemBuilder: (context) {
              return L10n.all.map((locale) {
                final isSelected =
                    currentLocale.languageCode == locale.languageCode;

                return PopupMenuItem<String>(
                  value: locale.languageCode,
                  child: Row(
                    children: [
                      L10n.languageFlag(
                        locale.languageCode,
                        width: 18,
                        height: 18,
                      ),

                      SizedBox(width: 10.w),

                      Expanded(
                        child: Text(
                          L10n.getLanguageName(locale.languageCode),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      if (isSelected)
                        Icon(
                          Icons.check_rounded,
                          color: Colors.blue,
                          size: 18.sp,
                        ),
                    ],
                  ),
                );
              }).toList();
            },

            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  L10n.languageFlag(
                    currentLocale.languageCode,
                    width: 18,
                    height: 18,
                  ),

                  SizedBox(width: 8.w),

                  Text(
                    L10n.getLanguageName(currentLocale.languageCode),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(width: 4.w),

                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18.sp,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
