import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/constants/key_string.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/utils/shared_pref.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

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

  void _finishOnboarding() {
    SharedPref.setBoolValue(KeyString.onboardUser.name, true);
    Navigator.pushReplacementNamed(context, RoutePaths.loginScreen);
  }

  void _onNext() {
    if (_currentIndex == 2) {
      _finishOnboarding();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                children: const [_PageOne(), _PageTwo(), _PageThree()],
              ),
            ),

            /// NEXT BUTTON (same UI)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SizedBox(
                width: 327.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1DC7F2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFFAFAFA),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 32.h),

            /// INDICATORS (same UI)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final bool isActive = _currentIndex == index;
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  width: isActive ? 30.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color:
                        isActive
                            ? const Color(0xFF56F6CF)
                            : ColorPalete.oceanTeal.shade100,
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                );
              }),
            ),
            SizedBox(height: 16),

            /// SKIP (same behavior intent)
            if (_currentIndex != 2)
              GestureDetector(
                onTap: _finishOnboarding,
                child: Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF737373),
                  ),
                ),
              ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class _PageOne extends StatelessWidget {
  const _PageOne();

  @override
  Widget build(BuildContext context) {
    return _BasePage(
      showBackgroundCircle: true,
      image: AppImages.rabbit3,
      title: "One platform for every animal’s care.",
      subtitle:
          "From pets and livestock to poultry and aquaculture, VETYO helps you manage health, care, and veterinary support in one place.",
    );
  }
}

class _PageTwo extends StatelessWidget {
  const _PageTwo();

  @override
  Widget build(BuildContext context) {
    return _BasePage(
      image: AppImages.onboardingTwo,
      showBackgroundCircle: false,
      title: "Expert support, whenever you need it.",
      subtitle:
          "Connect with veterinarians, specialists, and care experts through chat, call, or video consultations, anytime, anywhere.",
    );
  }
}

class _PageThree extends StatelessWidget {
  const _PageThree();

  @override
  Widget build(BuildContext context) {
    return _BasePage(
      image: AppImages.leftRabbit,
      showBackgroundCircle: true,
      title: "Tailored for you and your pet.",
      subtitle:
          "Track records, monitor health, receive reminders, and manage care operations with ease.",
    );
  }
}

class _BasePage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final bool showBackgroundCircle;

  const _BasePage({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.showBackgroundCircle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ImageSection(backgroundCircle: showBackgroundCircle, image: image),
        _ContentSection(title: title, subtitle: subtitle),
      ],
    );
  }
}

class _ImageSection extends StatelessWidget {
  final bool backgroundCircle;
  final String image;

  const _ImageSection({required this.backgroundCircle, required this.image});

  /// Helper method to determine if the image is an SVG
  bool _isSvgImage(String imagePath) {
    return imagePath.toLowerCase().endsWith('.svg');
  }

  /// Build the appropriate image widget based on file type
  Widget _buildImageWidget(String imagePath) {
    if (_isSvgImage(imagePath)) {
      return SvgPicture.asset(
        imagePath,
        width: 240.w,
        height: 340.h,
        fit: BoxFit.contain,
      );
    } else {
      // PNG, JPEG, or other raster formats
      return Image.asset(
        imagePath,
        width: 240.w,
        height: 340.h,
        fit: BoxFit.contain,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (backgroundCircle)
              Image.asset(
                AppImages.ellipse29,
                width: 323.w,
                height: 323.w,
                fit: BoxFit.cover,
              ),
            _buildImageWidget(image),
          ],
        ),
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ContentSection({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: const Color(0xFF0F172B) /* Brand-slate-tints-900 */,
                fontSize: 32,
                fontFamily: 'Baloo 2',
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              child: Text(
                subtitle,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color(0xFF314158) /* Brand-slate-tints-700 */,
                  fontSize: 16,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
