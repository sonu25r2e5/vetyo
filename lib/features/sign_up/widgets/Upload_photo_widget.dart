import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:vetyo/core/utils/image_utils.dart';

class AppImagePicker {
  AppImagePicker._();

  /// Camera Picker
  static Future<File?> pickFromCamera() async {
    final imageFile = await ImageUtils.customCameraPicker();

    if (imageFile is File) {
      return imageFile;
    }

    return null;
  }

  /// Gallery Picker
  static Future<File?> pickFromGallery() async {
    final imageFile = await ImageUtils.customImagePicker();

    if (imageFile is File) {
      return imageFile;
    }

    return null;
  }

  /// Reusable Dialog
  static Future<File?> show({
    required BuildContext context,

    /// Dynamic title
    String title = "Upload photo ?",

    /// Camera button label
    String cameraLabel = "Take a photo",

    /// Gallery button label
    String galleryLabel = "Choose from gallery",

    /// Cancel button label
    String cancelLabel = "Cancel",
  }) async {
    File? selectedImage;

    await showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context
                      .textBlackStyle()
                      .header6
                      .semiBold
                      .withSatoshi
                      .copyWith(color: const Color(0xFF03141A)),
                ),

                SizedBox(height: 8.h),

                _buildButton(
                  context: context,
                  label: cameraLabel,
                  iconWidget: iconoir.Camera(
                    width: 24.w,
                    height: 24.w,
                    color: const Color(0xFF062933),
                  ),
                  onPressed: () async {
                    selectedImage = await pickFromCamera();
                    Navigator.of(ctx).pop();
                  },
                ),

                SizedBox(height: 8.h),

                _buildButton(
                  context: context,
                  label: galleryLabel,
                  iconWidget: iconoir.MediaImage(
                    width: 24.w,
                    height: 24.w,
                    color: const Color(0xFF062933),
                  ),
                  onPressed: () async {
                    selectedImage = await pickFromGallery();
                    Navigator.of(ctx).pop();
                  },
                ),

                SizedBox(height: 8.h),

                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    cancelLabel,
                    style:
                        context
                            .textBlackStyle()
                            .medium
                            .withSatoshi
                            .brightSky950,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return selectedImage;
  }

  static Widget _buildButton({
    required BuildContext context,
    required String label,
    required Widget iconWidget,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            iconWidget,
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: context.textBlackStyle().medium.withSatoshi.copyWith(
                  color: const Color(0xFF03141A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
