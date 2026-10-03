import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_padding.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:dotted_border/dotted_border.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double? height;
  final Color? color;
  final TextStyle? labelStyle;
  final bool? showLoading;
  final EdgeInsets? buttonPadding;
  final Gradient? gradient;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.color,
    this.gradient,
    this.labelStyle,
    this.buttonPadding,
    this.showLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: buttonPadding ?? AppPadding.customButtonPadding,
      child: SizedBox(
        height: height ?? 45,
        width: width ?? MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            color: gradient == null ? color ?? AppColor.appThemeColor : null,
            borderRadius: BorderRadius.circular(24),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
            ),
            onPressed: onPressed,
            child:
                showLoading == true
                    ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.whiteColor,
                      ),
                    )
                    : Text(
                      label,
                      style:
                          labelStyle ??
                          context
                              .textStyle(
                                palette: ColorPalete.slate,
                                swatch: 700,
                              )
                              .large
                              .semiBold,
                    ),
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double? height;
  final TextStyle? labelStyle;
  final bool? showLoading;
  final EdgeInsets? buttonPadding;

  const CustomTextButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.labelStyle,
    this.buttonPadding,
    this.showLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
        ),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed ?? () => Navigator.pop(context),
      child: Text(
        label,
        style:
            labelStyle ??
            context.textStyle(palette: ColorPalete.brand).large.semiBold,
      ),
    );
  }
}

class CustomButtonWidthBoxShadow extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? color;
  final TextStyle? labelStyle;
  final bool? showLoading;

  const CustomButtonWidthBoxShadow({
    super.key,
    required this.label,
    this.onPressed,
    this.color,
    this.labelStyle,
    this.showLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle labelTextStyle =
        labelStyle ??
        context.textStyle(palette: ColorPalete.white).medium.semiBold;
    Color buttonColor =
        color ?? context.applyAppColor(palette: ColorPalete.brand);
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 227, 227, 227),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(child: Text(label, style: labelTextStyle)),
      ),
    );
  }
}

class CustomDialogButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;

  final bool isDestructiveAction;

  const CustomDialogButton({
    super.key,
    required this.label,
    this.isDestructiveAction = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoDialogAction(
        isDefaultAction: true,
        isDestructiveAction: isDestructiveAction,
        onPressed: onPressed ?? () => Navigator.pop(context, false),
        child: Text(label),
      );
    } else {
      return TextButton(
        onPressed: onPressed ?? () => Navigator.pop(context, false),
        child: Text(
          label,
          style: TextStyle(
            color:
                isDestructiveAction
                    ? AppColor.redColor
                    : AppColor.appThemeColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }
  }
}

class CustomButtonWithoutIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final Color? color;
  final Color? labelColor;
  final bool? showLoading;

  const CustomButtonWithoutIcon({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.color,
    this.labelColor,
    this.showLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              color != null
                  ? WidgetStateProperty.all(color)
                  : WidgetStateProperty.all(
                    context.applyAppColor(
                      palette: ColorPalete.brand,
                      swatch: 500,
                    ),
                  ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        onPressed: onPressed,
        child:
            showLoading == true
                ? const Center(
                  child: CircularProgressIndicator(color: AppColor.whiteColor),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style:
                          context
                              .textStyle(
                                palette: ColorPalete.white,
                                swatch: 500,
                              )
                              .largeBody
                              .semiBold,
                    ),
                    // SizedBox(width: 10.w),
                    // Iconoir.ArrowRight(
                    //   width: 20.w,
                    //   height: 20.h,
                    //   color: context.applyAppColor(palette: ColorPalete.white),
                    // ),
                  ],
                ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? height;
  final double? width;
  final Color? color;
  final Color? labelColor;
  final bool? showLoading;

  const CustomButtonWithIcon({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.color,
    this.height,
    this.labelColor,
    this.showLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              color != null
                  ? WidgetStateProperty.all(color)
                  : WidgetStateProperty.all(
                    context.applyAppColor(
                      palette: ColorPalete.brand,
                      swatch: 500,
                    ),
                  ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        onPressed: onPressed,
        child:
            showLoading == true
                ? const Center(
                  child: CircularProgressIndicator(color: AppColor.whiteColor),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style:
                          context
                              .textStyle(
                                palette: ColorPalete.white,
                                swatch: 500,
                              )
                              .largeBody
                              .semiBold,
                    ),
                    SizedBox(width: 10.w),
                    iconoir.ArrowRight(
                      width: 20.w,
                      height: 20.h,
                      color: context.applyAppColor(palette: ColorPalete.white),
                    ),
                  ],
                ),
      ),
    );
  }
}

class CustomOutlinedButtonWithIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final Color? borderColor;
  final bool? showLoading;
  final Widget? icon;
  final bool isIconLeft;
  final TextStyle? labelStyle;

  const CustomOutlinedButtonWithIcon({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.borderColor,
    this.labelStyle,
    this.showLoading = false,
    this.icon,
    this.isIconLeft = false, // Default: Icon on the right
  });

  @override
  Widget build(BuildContext context) {
    TextStyle labelTextStyle =
        labelStyle ??
        context
            .textStyle(palette: ColorPalete.brand, swatch: 500)
            .large
            .semiBold;
    return SizedBox(
      height: 48.h,
      width: width ?? MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color:
                borderColor ??
                context.applyAppColor(palette: ColorPalete.brand, swatch: 500),
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressed,
        child:
            showLoading == true
                ? const Center(child: CircularProgressIndicator())
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isIconLeft && icon != null) icon!,
                    if (isIconLeft && icon != null) SizedBox(width: 10.w),
                    Text(label, style: labelTextStyle),
                    if (!isIconLeft && icon != null) SizedBox(width: 10.w),
                    if (!isIconLeft && icon != null) icon!,
                  ],
                ),
      ),
    );
  }
}

class CustomBorderButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double? borderRadius;
  final Color? borderColor;
  final TextStyle? labelStyle;
  final Color? labelColor;
  final bool? showLoading;
  final Widget? icon;
  final bool isIconLeft; // Controls icon position

  const CustomBorderButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.borderRadius,
    this.borderColor,
    this.labelColor,
    this.showLoading = false,
    this.icon,
    this.isIconLeft = false,
    this.labelStyle, // Default: Icon on the right
  });

  @override
  Widget build(BuildContext context) {
    TextStyle labelTextStyle =
        labelStyle ??
        context.textStyle(palette: ColorPalete.brand).medium.semiBold;
    return SizedBox(
      height: 45.h,
      width: width ?? MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color:
                borderColor ??
                context.applyAppColor(palette: ColorPalete.brand, swatch: 500),
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          ),
        ),
        onPressed: onPressed ?? () {},
        child:
            showLoading == true
                ? const Center(child: CircularProgressIndicator())
                : Text(label, style: labelTextStyle),
      ),
    );
  }
}

class MyCustomTextButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  const MyCustomTextButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0, // flat look
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.r), // pill shape
          ),
          minimumSize: Size(double.infinity, 36.h), // height 36
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "Satoshi",
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class CustomDottedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double? height;
  final Color? color;

  final Color? borderColor;
  final TextStyle? labelStyle;
  final Color? labelColor;
  final bool? showLoading;
  final Widget? icon;
  final bool isIconLeft;

  const CustomDottedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.borderColor,
    this.color,

    this.labelColor,
    this.showLoading = false,
    this.icon,
    this.isIconLeft = false,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorder =
        borderColor ??
        context.applyAppColor(palette: ColorPalete.brand, swatch: 500);

    final TextStyle effectiveLabelStyle =
        labelStyle ??
        context
            .textStyle(palette: ColorPalete.brand, swatch: 500)
            .large
            .semiBold;

    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(10.r),
      dashPattern: const [6, 3],
      color: effectiveBorder,
      strokeWidth: 2,
      padding: EdgeInsets.zero,
      child: Container(
        height: (height ?? 45).toDouble().h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,

            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(10.r),
            // ),
          ),
          onPressed: onPressed ?? () {},
          child:
              showLoading == true
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null && isIconLeft) ...[
                        icon!,
                        SizedBox(width: 8.w),
                      ],
                      Text(
                        label,
                        style: effectiveLabelStyle.copyWith(
                          color: labelColor ?? effectiveBorder,
                        ),
                      ),
                      if (icon != null && !isIconLeft) ...[
                        SizedBox(width: 8.w),
                        icon!,
                      ],
                    ],
                  ),
        ),
      ),
    );
  }
}

class TextOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const TextOutlinedButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42.h,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF0A4455), width: 2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(20.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style:
                      context
                          .textBlackStyle()
                          .medium
                          .medium
                          .withSatoshi
                          .brightSky950,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Widget iconWidget;
  final VoidCallback? onPressed;
  const CustomIconButton({super.key, required this.iconWidget, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42.w,
      height: 42.h,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF0A4455), width: 2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(20.r),
            child: Center(child: iconWidget),
          ),
        ),
      ),
    );
  }
}

class CustomTertiaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? frontIcon;
  final Widget? backIcon;
  final bool showFrontIcon;
  final bool showBackIcon;
  final TextStyle? labelStyle;
  final double? width;
  final double? height;
  final EdgeInsets? buttonPadding;
  final Color? borderColor;
  final Color? backgroundColor;

  const CustomTertiaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.frontIcon,
    this.backIcon,
    this.showFrontIcon = true,
    this.showBackIcon = true,
    this.labelStyle,
    this.width,
    this.height,
    this.buttonPadding,
    this.borderColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: buttonPadding ?? AppPadding.customButtonPadding,
      child: SizedBox(
        height: height ?? 42.h,
        width: width ?? MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? const Color(0xFF0A4455),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20.r),
            color: backgroundColor ?? Colors.white,
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showFrontIcon && frontIcon != null) ...[
                  frontIcon!,
                  SizedBox(width: 8.w),
                ],
                Text(
                  label,
                  style:
                      labelStyle ??
                      TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF062933),
                        fontFamily: 'Satoshi',
                      ),
                ),
                if (showBackIcon && backIcon != null) ...[
                  SizedBox(width: 8.w),
                  backIcon!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
