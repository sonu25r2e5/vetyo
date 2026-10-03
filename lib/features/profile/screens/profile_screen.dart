import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/app_single_child_scroll_view/app_single_child_scroll_view.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/generated/l10n/app_localizations.dart';
import 'package:vetyo/features/profile/widgets/profile_menu_options.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: AppSingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Profile',
                    style: context
                        .textBlackStyle()
                        .semiBold
                        .withBaloo2
                        .copyWith(
                          color: ColorPalete.oceanTeal.shade900,
                          fontSize: 28.sp,
                        ),
                  ),
                  Spacer(),

                  GestureDetector(
                    onTap: () {
                      _showOptionsMenu(context);
                    },

                    child: Icon(
                      Icons.more_vert,
                      size: 24.sp,
                      color: ColorPalete.oceanTeal.shade900,
                    ),
                  ),
                ],
              ),
              _buildProfileSection(),
              SizedBox(height: 18.h),
              _buildStatsRow(),
              SizedBox(height: 22.h),
              _buildSectionLabel('ACCOUNT'),
              SizedBox(height: 10.h),
              _buildMenuCard(
                items: [
                  _ProfileMenuItemData(
                    icon: Icons.person_outline,
                    label: 'Edit Profile',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutePaths.editUserProfileScreen,
                      );
                    },
                  ),
                  _ProfileMenuItemData(
                    icon: Icons.favorite_border,
                    label: 'Favourites',
                    onTap: () {},
                  ),
                  _ProfileMenuItemData(
                    icon: Icons.notifications_none,
                    label: 'Notifications',
                    onTap: () {},
                  ),
                  _ProfileMenuItemData(
                    icon: Icons.badge_outlined,
                    label: 'Category Profile',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutePaths.categoryProfileScreen,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _buildSectionLabel('SUPPORT'),
              SizedBox(height: 10.h),
              _buildMenuCard(
                items: [
                  _ProfileMenuItemData(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    onTap: () {
                      Navigator.pushNamed(context, RoutePaths.settingScreen);
                    },
                  ),
                  _ProfileMenuItemData(
                    icon: Icons.help_outline,
                    label: 'Help & Support',
                    onTap: () {},
                  ),
                  _ProfileMenuItemData(
                    icon: Icons.description_outlined,
                    label: 'Terms & Conditions',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 22.h),
              _buildLogoutButton(),
              SizedBox(height: 28.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showMenu(
      context: context,
      color: Colors.transparent,
      elevation: 0,
      constraints: BoxConstraints.tightFor(width: 166.w),
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width - 182.w,
        kToolbarHeight + MediaQuery.of(context).padding.top + 4.h,
        16.w,
        0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      items: const [
        PopupMenuItem(
          enabled: true,
          padding: EdgeInsets.zero,
          child: ProfileMenuOptions(),
        ),
      ],
    );
  }

  Widget _buildProfileSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 92.w,
                height: 92.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE6ECEF),
                    width: 1.5,
                  ),
                  image: const DecorationImage(
                    image: AssetImage(AppImages.avatarImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: -1,
                bottom: 2,
                child: Container(
                  width: 22.w,
                  height: 22.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10C287),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'Olivia Rodrigo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF182A33),
              fontFamily: 'Satoshi',
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16.sp,
                color: const Color(0xFF6C8797),
              ),
              SizedBox(width: 4.w),
              Text(
                'Birtamode 5, Jhapa Nepal',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6C8797),
                  fontFamily: 'Satoshi',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatPill(
            onPressed: () {
              Navigator.pushNamed(
                context,
                RoutePaths.communityScreen,
                arguments: {'initialPage': 2},
              );
            },
            label: 'My Posts',
            value: '36',
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatPill(
            onPressed: () {
              Navigator.pushNamed(
                context,
                RoutePaths.communityScreen,
                arguments: {'initialPage': 1},
              );
            },
            label: 'Saved Posts',
            value: '12',
          ),
        ),
      ],
    );
  }

  Widget _buildStatPill({
    required String label,
    required VoidCallback onPressed,
    required String value,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F7F8),
          borderRadius: BorderRadius.circular(24.r),
        ),
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF1F2E37),
              fontFamily: 'Satoshi',
            ),
            children: [
              TextSpan(
                text: '$label ',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: '($value)',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
          color: const Color(0xFF6C8797),
          fontFamily: 'Satoshi',
        ),
      ),
    );
  }

  Widget _buildMenuCard({required List<_ProfileMenuItemData> items}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF1F4F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          for (final item in items) ...[
            _buildMenuItem(item),
            if (item != items.last)
              Padding(
                padding: EdgeInsets.only(left: 54.w),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: const Color(0xFFF5F7F8),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuItem(_ProfileMenuItemData item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF0F3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 20.sp,
                  color: const Color(0xFF6C8797),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F2E37),
                    fontFamily: 'Satoshi',
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 22.sp,
                color: const Color(0xFFB7C7D0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showLogoutDialog(context),
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: const Color(0xFFFF3B30), width: 1.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: const Color(0x1AFF3B30),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_outlined,
                  size: 16.sp,
                  color: const Color(0xFFFF3B30),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'Log out',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFFF3B30),
                  fontFamily: 'Satoshi',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(34.r)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0A3128),
                  fontFamily: "Satoshi",
                ),
              ),
              SizedBox(height: 16.h),

              // Separator
              Container(height: 1.h, color: const Color(0xFFF5F5F5)),
              SizedBox(height: 16.h),

              // Text
              Text(
                AppLocalizations.of(context).exitConfirmation,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF737373),
                  fontFamily: "Satoshi",
                ),
              ),
              SizedBox(height: 24.h),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(0, 36.h),
                        side: const BorderSide(color: Color(0xFFF5F5F5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.r),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context).cancel,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF737373),
                          fontFamily: 'Satoshi',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutePaths.loginScreen,
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(0, 36.h),
                        backgroundColor: const Color(0xFF34F4C6),
                        foregroundColor: const Color(0xFF0A3128),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        AppLocalizations.of(context).login,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Satoshi',
                          color: const Color(0xFF0A3128),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileMenuItemData {
  const _ProfileMenuItemData({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}
