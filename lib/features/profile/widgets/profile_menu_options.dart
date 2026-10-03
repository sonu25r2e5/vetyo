import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/routes/route_paths.dart';

class ProfileMenuOptions extends StatelessWidget {
  const ProfileMenuOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000),
            offset: const Offset(0, 8),
            blurRadius: 16.r,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MenuActionItem(
            icon: Icons.lock_outline,
            label: 'Change Passord',
            textColor: const Color(0xFF083340),
            iconColor: const Color(0xFF083340),
            onTap: () {
              Navigator.pushNamed(context, RoutePaths.resetPasswordScreen);
            },
          ),
          SizedBox(height: 2.h),
          _MenuActionItem(
            icon: Icons.logout_outlined,
            label: 'Log Out',
            textColor: const Color(0xFFFB2C36),
            iconColor: const Color(0xFFFB2C36),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutePaths.loginScreen,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MenuActionItem extends StatelessWidget {
  const _MenuActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.textColor,
    required this.iconColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color textColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            children: [
              SizedBox(
                width: 20.w,
                height: 20.w,
                child: Icon(icon, size: 18.sp, color: iconColor),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: textColor,
                    fontFamily: 'Satoshi',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
