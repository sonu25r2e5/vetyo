import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/routes/route_paths.dart';

class DoctorProfileDetailsScreen extends StatefulWidget {
  const DoctorProfileDetailsScreen({super.key});

  @override
  State<DoctorProfileDetailsScreen> createState() =>
      _DoctorProfileDetailsScreenState();
}

class _DoctorProfileDetailsScreenState
    extends State<DoctorProfileDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      bodyColor: const Color(0xFFF6F6F6),
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            child: Column(
              children: [
                // Header with Gradient Background and Profile
                _buildProfileHeader(),

                // Profile Details Content
                _buildProfileContent(),

                SizedBox(height: 100.h), // Bottom padding for safe area
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      height: 248.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.18371, 0.80506],
          colors: [
            Color.fromRGBO(52, 245, 198, 0.5), // rgba(52,245,198,0.5)
            Color.fromRGBO(29, 205, 254, 0.5), // rgba(29,205,254,0.5)
          ],
        ),
      ),
      child: Stack(
        children: [
          // Navigation Icons
          Positioned(
            top: 52.h,
            left: 17.w,
            right: 17.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Arrow
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                ),

                // Edit Icon
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.editDoctorProfileDetails,
                    );
                  },
                  child: Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Icon(Icons.edit, size: 18.sp, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),

          // Profile Image
          Positioned(
            top: 47.h,
            left: 86.w,
            child: Container(
              width: 204.w,
              height: 211.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(139.776.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(139.776.r),
                child: Image.asset(
                  AppImages.vet1, // Doctor profile image
                  width: 204.w,
                  height: 211.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 204.w,
                      height: 211.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(139.776.r),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 80.sp,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),

            // Doctor Name and Rating
            _buildDoctorNameSection(),

            SizedBox(height: 32.h),

            // Stats Section
            _buildStatsSection(),

            SizedBox(height: 32.h),

            // About Me Section
            _buildAboutMeSection(),

            SizedBox(height: 32.h),

            // Area of Expertise Section
            _buildExpertiseSection(),

            SizedBox(height: 32.h),

            // Awards & Certifications Section
            _buildAwardsSection(),

            SizedBox(height: 32.h),

            // Reviews Section
            _buildReviewsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorNameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dr. Saanvi Sharma',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF002C22),
                fontFamily: "Satoshi",
              ),
            ),
            // Star Rating
            Row(
              children: List.generate(
                5,
                (index) => Icon(Icons.star, size: 16.sp, color: Colors.orange),
              ),
            ),
          ],
        ),

        SizedBox(height: 5.h),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BVSc & AH, MVSc (Small Animal Surgery)',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF0A3128),
                fontFamily: "Satoshi",
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'NVC-2076-1483',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF0A3128),
                fontFamily: "Satoshi",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem(Icons.group, '2,000+', 'patients'),
        _buildStatItem(Icons.star, '10+', 'experience'),
        _buildStatItem(Icons.star_border, '5', 'rating'),
        _buildStatItem(Icons.message, '1,872', 'reviews'),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String number, String label) {
    return Column(
      children: [
        Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(28.r),
          ),
          child: Icon(icon, size: 24.sp, color: Colors.grey[600]),
        ),
        SizedBox(height: 8.h),
        Text(
          number,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF525252),
            fontFamily: "Satoshi",
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF737373),
            fontFamily: "Satoshi",
          ),
        ),
      ],
    );
  }

  Widget _buildAboutMeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Me',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF115242),
            fontFamily: "Satoshi",
          ),
        ),
        SizedBox(height: 8.h),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF2F2F2F),
              fontFamily: "Satoshi",
              height: 1.5,
            ),
            children: [
              const TextSpan(
                text:
                    'I am a dedicated veterinary surgeon with over 8 years of experience in small animal care. My focus lies in preventive healthcare, nutrition, and compassionate treatment. ',
              ),
              TextSpan(
                text: 'View More',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF115242),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpertiseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Area Of Expertise',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF115242),
            fontFamily: "Satoshi",
          ),
        ),
        SizedBox(height: 6.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExpertiseItem('Skin & Allergy Treatment'),
            _buildExpertiseItem('Preventive Healthcare & Vaccination'),
            _buildExpertiseItem('Pet Nutrition Planning'),
          ],
        ),
      ],
    );
  }

  Widget _buildExpertiseItem(String expertise) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Text(
        expertise,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF2F2F2F),
          fontFamily: "Satoshi",
          height: 2.0,
        ),
      ),
    );
  }

  Widget _buildAwardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Award & Certifications',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF115242),
                fontFamily: "Satoshi",
              ),
            ),
            Icon(
              Icons.emoji_events,
              size: 24.sp,
              color: const Color(0xFF115242),
            ),
          ],
        ),
        SizedBox(height: 13.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAwardItem('Certified in Advanced Small Animal Surgery'),
            _buildAwardItem('Completed Emergency & Critical Care Training'),
            _buildAwardItem('Speaker at Veterinary Surgical Workshop'),
            _buildAwardItem('Excellence in Clinical Practice Award (2021)'),
          ],
        ),
      ],
    );
  }

  Widget _buildAwardItem(String award) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Text(
        award,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF2F2F2F),
          fontFamily: "Satoshi",
          height: 2.0,
        ),
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reviews',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF115242),
                fontFamily: "Satoshi",
              ),
            ),
            Text(
              'See All',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF737373),
                fontFamily: "Satoshi",
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _buildReviewItem(),
      ],
    );
  }

  Widget _buildReviewItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 57.w,
              height: 57.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(41.r),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(41.r),
                child: Image.asset(
                  AppImages.vet2, // Review user image
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      size: 30.sp,
                      color: Colors.grey[600],
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Emily Anderson',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0A3128),
                    fontFamily: "Satoshi",
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      '5.0',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF737373),
                        fontFamily: "Satoshi",
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Row(
                      children: List.generate(
                        5,
                        (index) =>
                            Icon(Icons.star, size: 12.sp, color: Colors.orange),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'Dr. Patel is a true professional who genuinely cares about his patients. I highly recommend Dr. Patel to anyone seeking exceptional cardiac care.',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF4F4F4F),
            fontFamily: "Satoshi",
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
