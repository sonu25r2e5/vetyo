import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/features/doctors/doctor_case/screens/doctor_cases_screen.dart';
import 'package:vetyo/features/doctors/screens/doctor_profile_screen.dart';
import 'package:vetyo/features/doctors/screens/doctor_vet_screen.dart';
import 'package:vetyo/features/home/screens/article_screen.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  int _currentIndex = 0;

  // IndexedStack pages: keep state per tab
  late final List<Widget> _pages = [
    DoctorVetScreen(),
    ArticleScreen(), // Your updated Home Page with Slivers

    DoctorCasesScreen(), // Cases placeholder
    DoctorProfileScreen(), // Profile placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 84.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x40082720),
            blurRadius: 24.7,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                Iconoir.HomeSimpleDoor(
                  width: 24.sp,
                  height: 24.sp,
                  color: ColorPalete.slate[500],
                ),
                Iconoir.HomeSimpleDoor(
                  width: 24.sp,
                  height: 24.sp,
                  color: const Color(0xFF1DC7F2),
                ),
                'Home',
                0,
              ),

              _buildNavItem(
                Iconoir.Page(
                  width: 24.sp,
                  height: 24.sp,
                  color: ColorPalete.slate[500],
                ),
                Iconoir.Page(
                  width: 24.sp,
                  height: 24.sp,
                  color: const Color(0xFF1DC7F2),
                ),
                'Articles',
                1,
              ),

              _buildCenterButton(), // Keep this as-is

              _buildNavItem(
                Iconoir.MultiplePages(
                  width: 24.sp,
                  height: 24.sp,
                  color: ColorPalete.slate[500],
                ),
                Iconoir.MultiplePages(
                  width: 24.sp,
                  height: 24.sp,
                  color: const Color(0xFF1DC7F2),
                ),
                'Cases',
                2,
              ),

              _buildNavItem(
                Iconoir.UserCircle(
                  width: 24.sp,
                  height: 24.sp,
                  color: ColorPalete.slate[500],
                ),
                Iconoir.UserCircle(
                  width: 24.sp,
                  height: 24.sp,
                  color: const Color(0xFF1DC7F2),
                ),
                'Profile',
                3,
              ),
            ],
          ),
          SizedBox(height: 34.h),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    Widget icon,
    Widget activeIcon,
    String label,
    int index,
  ) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isActive ? activeIcon : icon,

          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color:
                  isActive ? const Color(0xFF1DC7F2) : ColorPalete.slate[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/addCase');
      },
      child: Container(
        width: 42.w,
        height: 42.w,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add_circle_outline,
          size: 42.sp,
          color: ColorPalete.slate[500],
        ),
      ),
    );
  }
}
