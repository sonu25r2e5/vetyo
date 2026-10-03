import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class GoogleRegistrationCompleteScreen extends StatefulWidget {
  final Map<String, dynamic>? googleUserData;
  const GoogleRegistrationCompleteScreen({super.key, this.googleUserData});

  @override
  State<GoogleRegistrationCompleteScreen> createState() =>
      _GoogleRegistrationCompleteScreenState();
}

class _GoogleRegistrationCompleteScreenState
    extends State<GoogleRegistrationCompleteScreen> {
  String _userName = 'Olivia';
  String _userEmail = 'oliviarodrigo@gmail.com';

  @override
  void initState() {
    super.initState();
    // Extract user data from Google sign-in if available
    if (widget.googleUserData != null) {
      _userName = widget.googleUserData!['displayName'] ?? 'User';
      _userEmail = widget.googleUserData!['email'] ?? '';
    }
  }

  void _handleContinue() {
    // Navigate to user registration flow
    Navigator.pushNamed(
      context,
      RoutePaths.googleRegistrationCompleteFlow,
      arguments: {'initialPage': 0},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      bodyColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              SizedBox(height: 50.h),

              // Main Container
              Column(
                children: [
                  // Vetyo Logo
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.appImage,
                          width: 120.w,
                          height: 160.h,
                        ),
                        SizedBox(height: 60.h),
                      ],
                    ),
                  ),

                  // Google Profile and Container
                  Column(
                    children: [
                      // Body Container with Profile
                      Container(
                        width: 280.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5), // healing-green/50
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Column(
                          children: [
                            // Profile Avatar Section
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: 56.w,
                                  height: 56.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFFD9D9D9),
                                    image: DecorationImage(
                                      image: AssetImage(AppImages.avatarImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Google Badge
                                Container(
                                  width: 18.w,
                                  height: 18.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: Image.asset(
                                      AppImages.googleImage,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),

                            // Text Content
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Welcome Message
                                Text(
                                  'Welcome, $_userName!',
                                  style: context
                                      .textBlackStyle()
                                      .header6
                                      .withSatoshi
                                      .copyWith(color: const Color(0xFF051E26)),
                                ),
                                SizedBox(height: 8.h),

                                // Email
                                Text(
                                  _userEmail,
                                  style: context
                                      .textBlackStyle()
                                      .large
                                      .copyWith(color: const Color(0xFF335D6B)),
                                ),
                                SizedBox(height: 8.h),

                                // Description
                                Text(
                                  'Your account has been created. Just 3 quick steps to complete your vetyo profile.',
                                  textAlign: TextAlign.center,
                                  style: context
                                      .textBlackStyle()
                                      .medium
                                      .copyWith(color: const Color(0xFF0A3D4D)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Continue Button
                      SizedBox(
                        width: 280.w,
                        height: 42.h,
                        child: CustomButton(
                          label: 'Continue',
                          onPressed: _handleContinue,
                          color: AppColor.brightSkyMain,
                          labelStyle: context
                              .textBlackStyle()
                              .medium
                              .fontWeightMedium
                              .withSatoshi
                              .copyWith(color: ColorPalete.brightSky.shade50),
                          buttonPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
