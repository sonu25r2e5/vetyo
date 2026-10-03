import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vetyo/constants/app_images.dart';

class L10n {
  static const all = [Locale('en'), Locale('ne')];

  static String getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'EN';
      case 'ne':
        return 'नेपा';
      default:
        return 'EN';
    }
  }

  /// Returns a small flag SVG widget for the given language code.
  static Widget languageFlag(
    String code, {
    double width = 24,
    double height = 16,
  }) {
    String? asset;

    switch (code) {
      case 'en':
        asset = AppImages.englishFlag;
        return Image.asset(
          asset,
          width: width.w,
          height: height.h,
          fit: BoxFit.fill,
        );

      case 'ne':
        asset = AppImages.nepaliFlag;
        return SvgPicture.asset(
          asset,
          width: width.w,
          height: height.h,
          fit: BoxFit.fill,
        );

      default:
        asset = AppImages.englishFlag;
        return Image.asset(
          asset,
          width: width.w,
          height: height.h,
          fit: BoxFit.fill,
        );
    }
  }
}

/// ISO language mappings
const Map<String, String> isoLanguageCode = {"ENG": "en", "NEP": "ne"};

const Map<String, String> languageName = {"en": "ENG", "ne": "NEP"};

String getLanguageCode(String language) {
  return isoLanguageCode[language] ?? 'en';
}
