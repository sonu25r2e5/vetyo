import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_fonts.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/constants/font_weight.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/doctors/widgets/doctor_profile_avatar.dart';
import 'package:vetyo/features/doctors/widgets/profile_menu_item.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: Text(
        'Profile',
        style: context.textBlackStyle().medium.withSatoshi.xlarge.copyWith(
          color: ColorPalete.supporting2.shade800,
        ),
      ),
      centerTitle: true,
      showBackButton: false,
      bodyColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(),
            SizedBox(height: 24.h),

            // Profile Menu Items
            _buildProfileMenuSection(),
            SizedBox(height: 24.h),

            // Settings Section
            _buildSettingsSection(),
            SizedBox(height: 100.h), // Extra space for bottom navigation
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h),
      color: Colors.white,
      child: Column(
        children: [
          // Profile Avatar with Online Status
          DoctorProfileAvatar(
            imageUrl: AppImages.avatarImage,
            showOnlineStatus: true,
            size: 92.w,
          ),
          SizedBox(height: 12.h),

          // Doctor Info
          DoctorProfileInfo(
            name: 'Dr. Janami Rai',
            specialty: 'Senior surgeon',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuSection() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.person_outline,
            title: 'Personal information',
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutePaths.doctorProfileDetailsScreen,
              );
            },
          ),
          ProfileMenuItem(
            icon: Icons.description_outlined,
            title: 'License',
            onTap: () {
              // Navigate to license
            },
          ),
          ProfileMenuItem(
            icon: Icons.local_hospital_outlined,
            title: 'Hospital / Clinic',
            onTap: () {
              // Navigate to hospital/clinic
            },
          ),
          ProfileMenuItem(
            icon: Icons.medical_services_outlined,
            title: 'Specialization',
            onTap: () {
              // Navigate to specialization
            },
          ),
        ],
      ),
    );
  }

  // Widget _buildAvailabilitySection() {
  //   return Container(
  //     color: Colors.white,
  //     padding: EdgeInsets.all(24.w),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Availability',
  //           style: TextStyle(
  //             fontSize: 16.sp,
  //             fontWeight: AppFontWeight.bold,
  //             color: Colors.black,
  //             fontFamily: AppFonts.satoshi,
  //           ),
  //         ),
  //         SizedBox(height: 12.h),

  //         // Status Toggle Row
  //         Row(
  //           children: [
  //             Icon(
  //               Icons.check_circle_outline,
  //               size: 24.sp,
  //               color: ColorPalete.supporting2.shade800,
  //             ),
  //             SizedBox(width: 12.w),
  //             Expanded(
  //               child: Text(
  //                 'Status',
  //                 style: TextStyle(
  //                   fontSize: 16.sp,
  //                   fontWeight: AppFontWeight.medium,
  //                   color: ColorPalete.supporting2.shade800,
  //                   fontFamily: AppFonts.satoshi,
  //                 ),
  //               ),
  //             ),
  //             CustomToggleSwitch(
  //               value: isAvailable,
  //               onChanged: (value) {
  //                 setState(() {
  //                   isAvailable = value;
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 12.h),

  //         // Schedule Card
  //         ScheduleCard(
  //           nextSlot: 'Tomorrow, 09:00 AM',
  //           schedule: 'Mon-Fri, (9 am - 6 pm)',
  //           onTap: () {
  //             // Navigate to schedule management
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSettingsSection() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.settings_outlined,
            title: 'System and notification',
            onTap: () {
              // Navigate to settings
            },
          ),
          ProfileMenuItem(
            icon: Icons.language_outlined,
            title: 'Help and Support',
            onTap: () {
              // Navigate to help
            },
          ),
          ProfileMenuItem(
            icon: Icons.logout_outlined,
            title: 'Log out',
            onTap: () {
              _showLogoutDialog();
            },
            showArrow: false,
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Log Out',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: AppFontWeight.bold,
              color: Colors.black,
              fontFamily: AppFonts.satoshi,
            ),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: AppFontWeight.regular,
              color: ColorPalete.supporting2.shade600,
              fontFamily: AppFonts.satoshi,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: AppFontWeight.medium,
                  color: ColorPalete.supporting2.shade600,
                  fontFamily: AppFonts.satoshi,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: AppFontWeight.medium,
                  color: ColorPalete.error.shade500,
                  fontFamily: AppFonts.satoshi,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
