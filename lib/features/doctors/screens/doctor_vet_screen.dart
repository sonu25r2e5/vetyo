import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/features/vets/widgets/vet_card.dart';
import 'package:vetyo/features/doctors/widgets/recovery_progress_bar.dart';
import 'package:vetyo/features/doctors/widgets/seasonal_alert_card.dart';

class DoctorVetScreen extends StatefulWidget {
  const DoctorVetScreen({super.key});

  @override
  State<DoctorVetScreen> createState() => _DoctorVetScreenState();
}

class _DoctorVetScreenState extends State<DoctorVetScreen> {
  Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();
  List<CustomFormFieldConfig> formFields = [];

  static const double _horizontalPadding = 24;

  @override
  void initState() {
    super.initState();
    getInitialData();

    // Ensure keyboard is dismissed when screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  getInitialData() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "search",
        label: "Search doctors...",
        showLabel: false,
        isRequired: false,
        prefixIcon: Icon(Icons.search),
        // Changed to false for search field
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Ensure formFields is not null
    if (formFields.isEmpty) {
      getInitialData();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Search Section
          _buildSearchSection(),
          _verticalSpace(20),

          // Banner Carousel
          _buildBannerCarousel(),
          _verticalSpace(24),

          // Regional Insights (Seasonal Alerts)
          _buildRegionalInsightsSection(),
          _verticalSpace(24),
          // Appointments
          _buildAppointmentsSection(),
          _verticalSpace(24),

          // Outcome Tracker (Statistics Overview)
          _buildOutcomeTrackerSection(),
          _verticalSpace(24),

          // Saved Cases (Rare Cases)
          _buildSavedCasesSection(),
          _verticalSpace(24),

          // Community Tips
          _buildCommunityTipsSection(),
          _verticalSpace(24),

          // Recommended Vets
          _buildRecommendedVetsSection(),
          _verticalSpace(24),

          // All Vets
          _buildAllVetsSection(),
          _verticalSpace(64),
        ],
      ),
    );
  }

  // -------------------- Layout Helpers --------------------

  SliverToBoxAdapter _verticalSpace(double height) {
    return SliverToBoxAdapter(child: SizedBox(height: height.h));
  }

  // -------------------- Search --------------------

  SliverToBoxAdapter _buildSearchSection() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding.w),
          child: CustomFormFieldGenerator(
            onFieldSubmitted: (data) {
              formData = data ?? {};
              setState(() {});
            },
            formKey: _formKey,
            formFields: formFields,
          ),
        ),
      ),
    );
  }

  // -------------------- Banner --------------------

  SliverToBoxAdapter _buildBannerCarousel() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 163.h,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding.w),
          children: const [
            _BannerCard(
              title: 'Looking for\nSpecialist Doctors?',
              subtitle: 'Schedule an appointment with our top doctors.',

              image: AppImages.bannerVet1,
            ),

            SizedBox(width: 16),
            _BannerCard(
              title: 'Never Miss a Shot Again!',
              subtitle:
                  'Get personalized vaccination and checkup reminders for your pet.',

              image: AppImages.bannerVet1,
            ),
            SizedBox(width: 16),
            _BannerCard(
              title: 'Vet Help Anytime, Anywhere!',
              subtitle:
                  'Connect instantly with certified vets for any concern, day or night.',

              image: AppImages.bannerVet1,
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- Regional Insights Section --------------------

  SliverToBoxAdapter _buildRegionalInsightsSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Regional Insights',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF272828),
                fontFamily: "Satoshi",
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              children: [
                Expanded(
                  child: SeasonalAlertCard(
                    title: 'Heat Wave Alert',
                    description: 'Extreme heat expected',
                    icon: Icons.wb_sunny,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SeasonalAlertCard(
                    title: 'Flu Season',
                    description: 'Preventive measures recommended',
                    icon: Icons.health_and_safety,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- Outcome Tracker Section --------------------

  SliverToBoxAdapter _buildOutcomeTrackerSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Completed Cases & Pending Overview
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Color(0xFFE5E5E5), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Completed Cases',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF737373),
                            fontFamily: "Satoshi",
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '21',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF272828),
                            fontFamily: "Satoshi",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Color(0xFFE5E5E5), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pending',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF737373),
                            fontFamily: "Satoshi",
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '2',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF272828),
                            fontFamily: "Satoshi",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Recovery Rate & Average Time Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Color(0xFFE5E5E5), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recovery Rate',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF737373),
                                fontFamily: "Satoshi",
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                '+5%',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF00A651),
                                  fontFamily: "Satoshi",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '78%',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF272828),
                            fontFamily: "Satoshi",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Color(0xFFE5E5E5), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Avg. Time',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF737373),
                                fontFamily: "Satoshi",
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                '+5%',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF00A651),
                                  fontFamily: "Satoshi",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '3.2d',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF272828),
                            fontFamily: "Satoshi",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Overall Recovery Progress
            RecoveryProgressBar(
              progress: 0.78,
              label: 'Overall Recovery Progress',
              percentage: '78%',
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- Saved Cases Section --------------------

  SliverToBoxAdapter _buildSavedCasesSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Saved Cases',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF272828),
                fontFamily: "Satoshi",
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                _RareCaseCard(
                  icon: Icons.description,
                  title: 'Mastitis Case',
                  description: 'Severe infection in dairy cow',
                  timestamp: '2 days ago',
                ),
                SizedBox(height: 12.h),
                _RareCaseCard(
                  icon: Icons.description,
                  title: 'Poisoning Case',
                  description: 'Chemical poisoning in pet',
                  timestamp: '5 days ago',
                ),
                SizedBox(height: 12.h),
                _RareCaseCard(
                  icon: Icons.description,
                  title: 'Surgical Case',
                  description: 'Complex surgical intervention',
                  timestamp: '10 days ago',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- Community Tips Section --------------------

  SliverToBoxAdapter _buildCommunityTipsSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Community Tips',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF272828),
                fontFamily: "Satoshi",
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 140.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              itemCount: _dummyCommunityTips.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (_, index) {
                final tip = _dummyCommunityTips[index];
                return _CommunityTipCard(
                  icon: tip['icon'] as IconData,
                  question: tip['question'] as String,
                  likes: tip['likes'] as String,
                  views: tip['views'] as String,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- Appointments Section --------------------

  SliverToBoxAdapter _buildAppointmentsSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Appointments',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF272828),
                fontFamily: "Satoshi",
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Upcoming Appointments
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Upcoming',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF272828),
                fontFamily: "Satoshi",
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: _AppointmentListItem(
              doctorName: 'Dr. James Robinson',
              specialty: 'Orthopedic Surgery',
              dateTime: 'May 22, 2023 - 10:00 AM',
            ),
          ),
          SizedBox(height: 16.h),

          // Completed Appointments
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Completed',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF272828),
                fontFamily: "Satoshi",
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: _AppointmentListItem(
              doctorName: 'Dr. Daniel Lee',
              specialty: 'Gastroenterologist',
              dateTime: 'June 14, 2023 - 15:00 PM',
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- Recommended Vets Section --------------------

  SliverToBoxAdapter _buildRecommendedVetsSection() {
    return SliverToBoxAdapter(
      child: _VetRecommendList(title: 'Recommended Vets', cardWidth: 327.w),
    );
  }

  // -------------------- All Vets Section --------------------

  SliverToBoxAdapter _buildAllVetsSection() {
    return SliverToBoxAdapter(
      child: _VetAllList(title: 'All vets', cardWidth: 327.w),
    );
  }
}

// -------------------- Data --------------------

// -------------------- Reusable Widgets --------------------
class _BannerCard extends StatelessWidget {
  const _BannerCard({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      padding: EdgeInsets.all(11.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1DC7F2), Color(0xFF34F4C6)],
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: "Satoshi",
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontFamily: "Satoshi",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 100.w), // space for image
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(image, width: 155.w, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}

class _VetRecommendList extends StatelessWidget {
  const _VetRecommendList({required this.title, required this.cardWidth});

  final String title;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SectionHeader(
          title: title,
          onSeeAll: () {
            Navigator.pushNamed(context, '/recommendVetScreen');
          },
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 140.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 24.w),
            itemCount: _dummyVets.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (_, index) {
              final vet = _dummyVets[index];
              return SizedBox(
                width: cardWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VetCard(
                    name: vet['name']!,
                    specialty: vet['specialty']!,
                    rating: double.parse(vet['rating']!),
                    distance: vet['location']!,
                    imageUrl: vet['image']!,
                    onTap: () {
                      // Handle vet card tap
                      Navigator.pushNamed(context, '/vetDetailScreen');
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _VetAllList extends StatelessWidget {
  const _VetAllList({required this.title, required this.cardWidth});

  final String title;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SectionHeader(
          title: title,
          onSeeAll: () {
            Navigator.pushNamed(context, '/allVetScreen');
          },
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 140.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 16.w),
            itemCount: _dummyVets.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (_, index) {
              final vet = _dummyVets[index];
              return SizedBox(
                width: cardWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VetCard(
                    name: vet['name']!,
                    specialty: vet['specialty']!,
                    rating: double.parse(vet['rating']!),
                    distance: vet['location']!,
                    imageUrl: vet['image']!,
                    onTap: () {
                      // Handle vet card tap
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onSeeAll});

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0A3128),
              fontFamily: "Satoshi",
            ),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              'See All',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF737373),
                fontFamily: "Satoshi",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------- Rare Case Card --------------------

class _RareCaseCard extends StatelessWidget {
  const _RareCaseCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.timestamp,
  });

  final IconData icon;
  final String title;
  final String description;
  final String timestamp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFE5E5E5), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 20.sp, color: Color(0xFF1DCDFE)),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF272828),
                        fontFamily: "Satoshi",
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF0E6),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'RARE',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFBB4D00),
                          fontFamily: "Satoshi",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Color(0xFF737373),
                    fontFamily: "Satoshi",
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  timestamp,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Color(0xFFA9A9A9),
                    fontFamily: "Satoshi",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------- Community Tip Card --------------------

class _CommunityTipCard extends StatelessWidget {
  const _CommunityTipCard({
    required this.icon,
    required this.question,
    required this.likes,
    required this.views,
  });

  final IconData icon;
  final String question;
  final String likes;
  final String views;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFE5E5E5), width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 18.sp, color: Color(0xFF1DCDFE)),
          ),
          SizedBox(height: 8.h),
          Text(
            question,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF272828),
              fontFamily: "Satoshi",
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Divider(height: 1, color: Color(0xFFE5E5E5)),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 12.sp,
                    color: Color(0xFF737373),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    likes,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Color(0xFF737373),
                      fontFamily: "Satoshi",
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.visibility, size: 12.sp, color: Color(0xFF737373)),
                  SizedBox(width: 2.w),
                  Text(
                    views,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Color(0xFF737373),
                      fontFamily: "Satoshi",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -------------------- Appointment List Item --------------------

class _AppointmentListItem extends StatelessWidget {
  const _AppointmentListItem({
    required this.doctorName,
    required this.specialty,
    required this.dateTime,
  });

  final String doctorName;
  final String specialty;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFE5E5E5), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.person, size: 24.sp, color: Color(0xFF1DCDFE)),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF272828),
                    fontFamily: "Satoshi",
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  specialty,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Color(0xFF737373),
                    fontFamily: "Satoshi",
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  dateTime,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Color(0xFFA9A9A9),
                    fontFamily: "Satoshi",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------- Dummy Data --------------------

final _dummyCommunityTips = [
  {
    'icon': Icons.help,
    'question': 'How to care for pets in summer?',
    'likes': '24',
    'views': '156',
  },
  {
    'icon': Icons.healing,
    'question': 'Best vaccination schedule',
    'likes': '36',
    'views': '289',
  },
  {
    'icon': Icons.food_bank,
    'question': 'Proper nutrition for animals',
    'likes': '42',
    'views': '367',
  },
  {
    'icon': Icons.local_hospital,
    'question': 'Emergency first aid tips',
    'likes': '28',
    'views': '201',
  },
];

const List<Map<String, String>> _dummyVets = [
  {
    'name': 'Dr. David Patel',
    'specialty': 'Cardiologist',
    'rating': '5.0',
    'location': 'Cardiology Center, USA',
    'image': 'assets/images/avatar.png',
  },
  {
    'name': 'Dr. Jessica Turner',
    'specialty': 'Gynecologist',
    'rating': '5.0',
    'location': 'Women\'s Clinic, Seattle, USA',
    'image': 'assets/images/avatar.png',
  },
  {
    'name': 'Dr. Michael Johnson',
    'specialty': 'Orthopedic Surgery',
    'rating': '4.7',
    'location': 'Maple Associates, NY, USA',
    'image': 'assets/images/avatar.png',
  },
  {
    'name': 'Dr. Emily Walker',
    'specialty': 'Pediatrics',
    'rating': '5.0',
    'location': 'Serenity Pediatrics Clinic',
    'image': 'assets/images/avatar.png',
  },
];
