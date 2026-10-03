import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

// Asset URLs from Figma
const String imgEsewaLogo =
    "https://www.figma.com/api/mcp/asset/2c53f232-7d1f-4e74-8dfe-b99111dd68df";
const String imgCreditCard =
    "https://www.figma.com/api/mcp/asset/466dd586-3b4b-444b-b381-6452122415d3";

class AppoinmentPaymentScreen extends StatefulWidget {
  const AppoinmentPaymentScreen({super.key});

  @override
  State<AppoinmentPaymentScreen> createState() =>
      _AppoinmentPaymentScreenState();
}

class _AppoinmentPaymentScreenState extends State<AppoinmentPaymentScreen> {
  // int _currentStep = 0; // Track progress bar step

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      centerTitle: false,
      title: Text(
        'Payment',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF03141A),
          fontFamily: 'Satoshi',
        ),
      ),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),

                // "Choose a method" title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.5.w),
                  child: Text(
                    'Choose a method',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF03141A),
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // E-Sewa Payment Option
                _buildPaymentMethod(
                  imagePath: imgEsewaLogo,
                  title: 'e-Sewa',
                  description: 'Complete your payment process with e-Sewa',
                ),

                SizedBox(height: 16.h),

                // Debit Card Payment Option
                _buildPaymentMethod(
                  imagePath: imgCreditCard,
                  title: 'Debit Card',
                  description: 'Complete your payment process with debit card',
                ),

                SizedBox(height: 300.h), // Space for bottom button and progress
              ],
            ),
          ),

          // Bottom Progress Bar, Button and Home Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 36.0,
              ),
              child: CustomButton(
                label: "Continue",
                onPressed: () {},
                // width: 327.w,
                height: 40.h,
                color: const Color(0xFF1DC7F2),
                labelStyle:
                    context.textBlackStyle().large.semiBold.white.withSatoshi,
              ),
            ),
          ),
          SizedBox(height: 200.h),
        ],
      ),
    );
  }

  /// Build individual payment method card
  Widget _buildPaymentMethod({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 6),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo/Icon
          Container(
            width: 43.w,
            height: 43.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
            child: Image.network(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: ColorPalete.brightSky[100],
                  child: Icon(Icons.payment, color: ColorPalete.brightSky[500]),
                );
              },
            ),
          ),
          SizedBox(width: 17.w),

          // Title and Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0A3D4D),
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF335D6B),
                    fontFamily: 'Satoshi',
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build bottom section with progress bar, button, and home bar
  // Widget _buildBottomSection() {
  //   return Container(
  //     color: Colors.white,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.max,
  //       children: [
  //         // Progress bar and button container
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 18.5.w, vertical: 16.h),
  //           child: Column(
  //             children: [
  //               CustomButton(
  //                 label: "Continue",
  //                 onPressed: () {},
  //                 // width: 327.w,
  //                 height: 40.h,
  //                 color: const Color(0xFF1DC7F2),
  //                 labelStyle:
  //                     context.textBlackStyle().large.semiBold.white.withSatoshi,
  //               ),

  //               // Progress indicator
  //             ],
  //           ),
  //         ),

  //         // Home indicator ba
  //       ],
  //     ),
  //   );
  // }

  /// Build progress bar with 7 steps
}
