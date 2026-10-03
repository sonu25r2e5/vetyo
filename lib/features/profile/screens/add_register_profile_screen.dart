import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/utils/image_utils.dart';

class AddRegisterProfileScreen extends StatefulWidget {
  const AddRegisterProfileScreen({super.key});

  @override
  State<AddRegisterProfileScreen> createState() =>
      _AddRegisterProfileScreenState();
}

class _AddRegisterProfileScreenState extends State<AddRegisterProfileScreen> {
  File? _profileImage;

  // Pick profile image from camera
  Future<void> _pickFromCamera() async {
    try {
      final pickedFile = await ImageUtils.customCameraPicker();
      if (pickedFile != null && pickedFile is File) {
        setState(() {
          _profileImage = pickedFile;
        });
      }
    } catch (e) {
      _showErrorSnackBar('Error picking image from camera: $e');
    }
  }

  // Pick profile image from gallery
  Future<void> _pickFromGallery() async {
    try {
      final pickedFile = await ImageUtils.customImagePicker();
      if (pickedFile != null && pickedFile is File) {
        setState(() {
          _profileImage = pickedFile;
        });
      }
    } catch (e) {
      _showErrorSnackBar('Error picking image from gallery: $e');
    }
  }

  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Close indicator
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 24.h),

                /// Title
                Text(
                  'Choose Photo Source',
                  style: context.textBlackStyle().header4.semiBold,
                ),
                SizedBox(height: 24.h),

                /// Camera Option
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _pickFromCamera();
                  },
                  child: Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.brightSkyMain,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 24.sp,
                            color: AppColor.brightSkyMain,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Take a Photo',
                            style:
                                context
                                    .textStyle(
                                      palette: ColorPalete.brightSky,
                                      swatch: 500,
                                    )
                                    .large
                                    .semiBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                /// Gallery Option
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _pickFromGallery();
                  },
                  child: Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.brightSkyMain,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_search,
                            size: 24.sp,
                            color: AppColor.brightSkyMain,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Choose from Gallery',
                            style:
                                context
                                    .textStyle(
                                      palette: ColorPalete.brightSky,
                                      swatch: 500,
                                    )
                                    .large
                                    .semiBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                /// Cancel Button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: context.textBlackStyle().large.semiBold,
                      ),
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

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _handleContinue() {
    // Handle continue with or without image
    print('Profile Image: ${_profileImage?.path}');
    Navigator.pushNamed(context, RoutePaths.userTypeScreen);
    // Navigate to next screen
  }

  void _handleSkip() {
    // Skip image upload and navigate to next screen
    print('Skipped image upload');
    Navigator.pushNamed(
      context,
      RoutePaths.userTypeScreen,
    ); // Replace with actual route
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      bodyColor: AppColor.whiteColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Title Section
                Text(
                  'Add a Profile Image',
                  textAlign: TextAlign.center,
                  style: context.textBlackStyle().header4.semiBold.withSatoshi,
                ),
                SizedBox(height: 8.h),

                /// Subtitle
                Text(
                  'Add profile picture of your choice or you\ncan also skip if you don\'t like to upload',
                  textAlign: TextAlign.center,
                  style:
                      context
                          .textStyle(palette: ColorPalete.slate, swatch: 500)
                          .medium
                          .regular,
                ),
                SizedBox(height: 32.h),

                /// Image Upload Area
                GestureDetector(
                  onTap: _showImagePickerBottomSheet,
                  child: Container(
                    width: double.infinity,
                    height: 340.h,
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFFD2F5FF,
                      ).withAlpha(128), // rgba(210,245,255,0.5)
                      border: Border.all(
                        color: AppColor.brightSkyMain,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child:
                        _profileImage != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(18.r),
                              child: Image.file(
                                _profileImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                            : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: 48.sp,
                                    color: AppColor.brightSkyMain,
                                  ),
                                ],
                              ),
                            ),
                  ),
                ),
                SizedBox(height: 163.h),

                /// Buttons Section
                CustomButton(
                  height: 55,
                  gradient: LinearGradient(
                    colors: [AppColor.brightSkyMain, AppColor.healingGreenMain],
                  ),
                  label: "Continue",
                  buttonPadding: EdgeInsets.zero,
                  color: context.applyAppColor(palette: ColorPalete.brand),
                  labelStyle:
                      context
                          .textStyle(palette: ColorPalete.white)
                          .xlarge
                          .semiBold,
                  onPressed: _handleContinue,
                ),
                SizedBox(height: 8.h),

                /// Skip Button
                GestureDetector(
                  onTap: _handleSkip,
                  child: Container(
                    width: double.infinity,
                    height: 40.h,
                    alignment: Alignment.center,
                    child: Text(
                      'Skip',
                      style:
                          context
                              .textStyle(
                                palette: ColorPalete.brightSky,
                                swatch: 950,
                              )
                              .large
                              .medium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
