import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/features/cases/screens/user_cases_screen.dart';
import 'package:vetyo/features/home/screens/article_screen.dart';
import 'package:vetyo/features/profile/screens/profile_screen.dart';
import 'package:vetyo/features/vets/screens/vet_screen.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;

class HomePage extends StatefulWidget {
  final int initialTab;
  const HomePage({super.key, this.initialTab = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // IndexedStack pages: keep state per tab
  late final List<Widget> _pages = [
    VetScreen(),
    ArticleScreen(), // Your updated Home Page with Slivers

    UserCasesScreen(), // Cases placeholder
    UserProfileScreen(), // Profile placeholder
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
    // Ensure keyboard is dismissed when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        // Dismiss keyboard on back navigation
        FocusScope.of(context).unfocus();
      },
      child: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping anywhere
          FocusScope.of(context).unfocus();
        },
        child: BasePage(
          showAppBar: false,
          body: IndexedStack(index: _currentIndex, children: _pages),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    // building the navigation Bar in here . // nothing else. do to do .
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  color: ColorPalete.brightSky[900],
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
                  width: 54.sp,
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
      onTap: () {
        // Dismiss keyboard when changing tabs
        FocusScope.of(context).unfocus();
        setState(() => _currentIndex = index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isActive ? activeIcon : icon,
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
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
        // Dismiss keyboard before navigation
        FocusScope.of(context).unfocus();
        Navigator.pushNamed(context, '/addCase');
      },
      child: Container(
        width: 22.w,
        // height: 42.w,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Column(
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 35.sp,
              color: ColorPalete.slate[500],
            ),
          ],
        ),
      ),
    );
  }
}
