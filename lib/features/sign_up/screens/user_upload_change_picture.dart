import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/utils/image_utils.dart';

class UserUploadChangePicture extends StatefulWidget {
  final ValueChanged<File?>? onImageChanged;

  const UserUploadChangePicture({super.key, this.onImageChanged});

  @override
  State<UserUploadChangePicture> createState() =>
      _UserUploadChangePictureState();
}

class _UserUploadChangePictureState extends State<UserUploadChangePicture> {
  File? _selectedImage;

  Future<void> _pickImageFromCamera() async {
    final imageFile = await ImageUtils.customCameraPicker();
    if (imageFile is File) {
      setState(() {
        _selectedImage = imageFile;
      });
      widget.onImageChanged?.call(_selectedImage);
    }
  }

  Future<void> _pickImageFromGallery() async {
    final imageFile = await ImageUtils.customImagePicker();
    if (imageFile is File) {
      setState(() {
        _selectedImage = imageFile;
      });
      widget.onImageChanged?.call(_selectedImage);
    }
  }

  void _showImagePickerDialog() {
    showDialog<void>(
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
                  'Change photo ?',
                  style: context
                      .textBlackStyle()
                      .header6
                      .semiBold
                      .withSatoshi
                      .copyWith(color: const Color(0xFF03141A)),
                ),
                SizedBox(height: 8.h),
                _buildPhotoButton(
                  label: "Take a photo",
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    _pickImageFromCamera();
                  },
                  iconWidget: iconoir.Camera(
                    width: 24.w,
                    height: 24.w,
                    color: const Color(0xFF062933),
                  ),
                ),
                SizedBox(height: 8.h),

                _buildPhotoButton(
                  label: "Choose from gallery",
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    _pickImageFromGallery();
                  },
                  iconWidget: iconoir.MediaImage(
                    width: 24.w,
                    height: 24.w,
                    color: const Color(0xFF062933),
                  ),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text(
                      'Cancel',
                      style:
                          context
                              .textBlackStyle()
                              .medium
                              .withSatoshi
                              .brightSky950,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Get the selected profile picture file
  File? getSelectedImage() => _selectedImage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Header Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Add a profile photo',
                  style: context
                      .textBlackStyle()
                      .header6
                      .semiBold
                      .withSatoshi
                      .copyWith(color: const Color(0xFF03141A)),
                ),
                SizedBox(height: 4.h),
                Text(
                  'You can change this anytime.',
                  style: context
                      .textBlackStyle()
                      .small
                      .medium
                      .withSatoshi
                      .copyWith(color: const Color(0xFF5C7E88)),
                ),
              ],
            ),
            SizedBox(height: 60.h),

            // Profile Picture Container
            Stack(
              alignment: Alignment.center,
              children: [
                // Circular background with user icon or image
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFCED8DB),
                    image:
                        _selectedImage != null
                            ? DecorationImage(
                              image: FileImage(_selectedImage!),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  child:
                      _selectedImage == null
                          ? Center(
                            child: iconoir.User(
                              width: 48.w,
                              height: 48.w,
                              color: const Color(0xFF5C7E88),
                            ),
                          )
                          : null,
                ),

                // Camera icon button (bottom right)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: AppColor.brightSkyMain,
                        width: 0.618,
                      ),
                    ),
                    child: Center(
                      child: iconoir.Camera(
                        width: 20.w,
                        height: 20.w,
                        color: AppColor.brightSkyMain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // CTA Buttons
            Column(
              children: [
                // Take a photo button
                _buildPhotoButton(
                  label: 'Change photo',
                  onPressed: _showImagePickerDialog,
                  iconWidget: iconoir.MediaImage(
                    width: 24.w,
                    height: 24.w,
                    color: const Color(0xFF062933),
                  ),
                ),
                SizedBox(height: 12.h),

                // // Choose from gallery button
                // _buildPhotoButton(
                //   label: 'Choose from gallery',
                //   onPressed: _pickImageFromGallery,
                //   iconWidget: iconoir.MediaImage(
                //     width: 24.w,
                //     height: 24.w,
                //     color: const Color(0xFF062933),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoButton({
    required String label,
    required VoidCallback onPressed,
    required Widget iconWidget,
  }) {
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
                iconWidget,
                SizedBox(width: 8.w),
                Text(
                  label,
                  style:
                      context.textBlackStyle()
                        ..medium.medium.withSatoshi.brightSky950,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
