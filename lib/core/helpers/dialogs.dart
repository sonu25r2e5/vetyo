import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class PlatformDialog {
  static showConfirmDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    String confirmText = "OK",
    String? cancelText,
    bool isTop = false,
    bool barrierDismissible = true,
    List<Widget>? actions,
  }) {
    if (isTop == false && ModalRoute.of(context)?.isCurrent != true)
      return null;
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder:
            (contextPop) => CupertinoAlertDialog(
              title: Text(
                title,
                style:
                    context
                        .textStyle(palette: ColorPalete.slate, swatch: 700)
                        .large
                        .semiBold,
              ),
              content: content,
              actions:
                  actions ??
                  [
                    if (cancelText != null)
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        isDefaultAction: true,
                        onPressed: () => Navigator.pop(contextPop, false),
                        child: Text(cancelText),
                      ),
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      isDestructiveAction: false,
                      onPressed: () => Navigator.pop(contextPop, true),
                      child: Text(confirmText),
                    ),
                  ],
            ),
      );
    } else {
      return showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder:
            (contextPop) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                title,
                style:
                    context
                        .textStyle(palette: ColorPalete.slate, swatch: 700)
                        .large
                        .semiBold,
              ),
              content: content,
              actions:
                  actions ??
                  [
                    if (cancelText != null)
                      TextButton(
                        onPressed: () => Navigator.pop(contextPop, false),
                        child: Text(
                          cancelText,
                          style: const TextStyle(
                            color: AppColor.redColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    TextButton(
                      onPressed: () => Navigator.pop(contextPop),
                      child: Text(
                        confirmText,
                        style: const TextStyle(
                          color: AppColor.appThemeColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
            ),
      );
    }
  }

  /// Shows the Figma-styled custom dialog (rounded card, shadow, custom actions)
  static showDesignDialog({
    required bool isIconRequired,
    Widget? iconWidget,
    required BuildContext context,
    required String title,
    required Widget content,
    required Color backgroundColor,
    String confirmText = "OK",
    String? cancelText,
    bool barrierDismissible = true,
    List<Widget>? actions,
  }) {
    if (ModalRoute.of(context)?.isCurrent != true) return null;
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (contextPop) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isIconRequired)
                  Align(alignment: Alignment.center, child: iconWidget),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style:
                      context
                          .textStyle(palette: ColorPalete.slate, swatch: 700)
                          .header4
                          .medium
                          .withSatoshi,
                ),
                const SizedBox(height: 12),
                DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: context
                      .textBlackStyle()
                      .medium
                      .regular
                      .withSatoshi
                      .copyWith(color: ColorPalete.oceanTeal.shade900),
                  child: content,
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                      actions ??
                      [
                        if (cancelText != null)
                          TextOutlinedButton(
                            label: "Add a Photo",
                            onPressed: () => Navigator.pop(contextPop, false),
                          ),
                        SizedBox(height: 10.h),

                        CustomButton(
                          label: confirmText,
                          onPressed: () => Navigator.pop(contextPop, true),
                          color: AppColor.brightSkyMain,
                          labelStyle:
                              context
                                  .textStyle(palette: ColorPalete.white)
                                  .xlarge
                                  .semiBold,
                        ),

                        //             CustomButton(
                        // height: 55,
                        // gradient: LinearGradient(
                        //   colors: [AppColor.brightSkyMain, AppColor.healingGreenMain],
                        // ),
                        // label: "Sign Up",
                        // buttonPadding: EdgeInsets.zero,
                        // color: context.applyAppColor(palette: ColorPalete.brand),
                        // labelStyle:
                        //     context.textStyle(palette: ColorPalete.white).xlarge.semiBold,
                        // onPressed: () {
                      ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showExitDialog({
    required context,
    required routePage,
    String? title,
    String? content,
    String? buttonLabel,
  }) {
    return showConfirmDialog(
      context: context,
      title: title ?? 'Exit',
      content: const Text('Are you sure you want to exit?'),
      actions: [
        CustomDialogButton(
          isDestructiveAction: true,
          label: buttonLabel ?? 'Exit',
          onPressed: () async {
            await Navigator.pushNamedAndRemoveUntil(
              context,
              routePage,
              (route) => false,
            );
          },
        ),
        CustomDialogButton(
          label: "Cancel",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  static showInputDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
  }) {
    if (ModalRoute.of(context)?.isCurrent != true) return null;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (contextPop) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              title,
              style:
                  context
                      .textStyle(palette: ColorPalete.slate, swatch: 700)
                      .large
                      .semiBold,
            ),
            content: content,
            actions: const [],
          ),
    );
  }
}
