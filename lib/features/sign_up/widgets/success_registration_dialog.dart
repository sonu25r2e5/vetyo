import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/helpers/dialogs.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class SuccessRegistrationDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onContinue;

  const SuccessRegistrationDialog({
    super.key,
    this.title,
    this.message,
    this.onContinue,
  });

  /// Shows the success registration dialog using the app's `PlatformDialog`.
  /// Returns the dialog result (true when confirmed).
  static Future<bool?> show(
    BuildContext context, {
    String? title,
    String? message,
    VoidCallback? onContinue,
  }) async {
    final result = await PlatformDialog.showDesignDialog(
      isIconRequired: true,
      iconWidget: Container(
        width: 72.w,
        height: 72.w,
        decoration: const BoxDecoration(
          color: AppColor.brightSkyMain,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 36),
      ),
      context: context,
      title: title ?? 'Account created',
      content: Text(
        message ?? 'Your account has been created successfully.',
        textAlign: TextAlign.center,
        style: context.textBlackStyle().medium.regular.withSatoshi.copyWith(
          color: ColorPalete.oceanTeal.shade900,
        ),
      ),
      backgroundColor: Colors.white,
      confirmText: 'Continue',
      barrierDismissible: false,
    );

    if (result == true && onContinue != null) onContinue();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
