import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/snackbar/snackbar.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/utils/shared_pref.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  String? _selectedUserType; // 'personal' or 'farm'

  Widget _buildUserTypeCard({
    required String type,
    required String title,
    required String description,
    required IconData icon,
  }) {
    final isSelected = _selectedUserType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedUserType = type),
      child: Container(
        height: 64.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color:
                isSelected
                    ? ColorPalete.brightSky.shade500
                    : const Color(0xFF4B4C4C),
            width: 0.5,
          ),
          color: isSelected ? const Color(0xFFD2F5FF) : Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected
                          ? ColorPalete.brightSky.shade500
                          : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                size: 14.sp,
                color:
                    isSelected
                        ? ColorPalete.brightSky.shade500
                        : Colors.grey.shade400,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle().newheader4.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    description,
                    style: TextStyle().smallBody.copyWith(
                      color: ColorPalete.slate.shade700,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorPalete.brightSky.shade500,
                ),
                child: Icon(Icons.check, size: 12.sp, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                // Header Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Type',
                      style: context.textBlackStyle().newheader3.copyWith(
                        color: const Color(0xFF0F172B),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'This helps us customize your experience based on your needs',
                      style: context.textBlackStyle().largeBody.copyWith(
                        color: ColorPalete.slate.shade500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                // User Type Options
                Column(
                  children: [
                    _buildUserTypeCard(
                      type: 'personal',
                      title: 'Personal User',
                      description: 'For personal use or household',
                      icon: Icons.person,
                    ),
                    SizedBox(height: 8.h),
                    _buildUserTypeCard(
                      type: 'farm',
                      title: 'Farm Owner',
                      description: 'For managing farms & production',
                      icon: Icons.home,
                    ),
                  ],
                ),
                SizedBox(height: 373.h),
                // Continue Button
                Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        ColorPalete.brightSky.shade500,
                        ColorPalete.healingGreen.shade500,
                      ],
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap:
                          _selectedUserType != null
                              ? () async {
                                // Save user type to SharedPreferences
                                await SharedPref.setStringValue(
                                  'userType',
                                  _selectedUserType!.toLowerCase(),
                                );

                                if (!mounted) return;

                                if (_selectedUserType?.toLowerCase() ==
                                    'personal') {
                                  Navigator.pushNamed(
                                    context,
                                    RoutePaths.homeScreen,
                                  );
                                } else {
                                  // Handle farm owner logic here
                                  showSnackBar(
                                    context,
                                    'Farm Owner flow coming soon',
                                  );
                                  Navigator.pushNamed(
                                    context,
                                    RoutePaths.homeScreen,
                                  );
                                }
                              }
                              : null,
                      borderRadius: BorderRadius.circular(20.r),
                      child: Center(
                        child: Text(
                          'Continue',
                          style: TextStyle().semiBold.copyWith(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
