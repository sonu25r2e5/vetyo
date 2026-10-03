import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xFFFAFAFA),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              // Status bar spacing

              // Main content area with blue shape and text
              Expanded(
                child: Center(
                  child: SizedBox(
                    // width: 180.w,
                    // height: 220.h,
                    child: SvgPicture.asset(
                      AppImages.initalScreenLogo,
                      height: 220.h,
                      width: 180.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // Bottom section with button and login text
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    label: "Let's Begin'",
                    onPressed: () {
                      Navigator.pushNamed(context, RoutePaths.onboardingScreen);
                    },
                    labelStyle:
                        context
                            .textBlackStyle()
                            .large
                            .medium
                            .clinicCloud50
                            .withSatoshi,
                    gradient: LinearGradient(
                      colors: [
                        ColorPalete.brightSky.shade500,
                        ColorPalete.healingGreen.shade500,
                      ],
                    ),
                  ),

                  // SizedBox(height: 20.h),

                  // Login text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: context
                            .textBlackStyle()
                            .medium
                            .semiBold
                            .withSatoshi
                            .copyWith(color: ColorPalete.oceanTeal.shade900),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutePaths.loginScreen);
                        },
                        child: ShaderMask(
                          blendMode:
                              BlendMode
                                  .srcIn, // Ensures the gradient only shows where text exists
                          shaderCallback:
                              (bounds) => LinearGradient(
                                colors: [
                                  ColorPalete.brightSky.shade500,
                                  ColorPalete.healingGreen.shade500,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                          child: Text(
                            'Log in',
                            style:
                                context
                                    .textBlackStyle()
                                    .medium
                                    .bold
                                    .withSatoshi,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 60.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
