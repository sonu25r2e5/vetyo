import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/localization/app_translations.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/features/appointments/screens/book_apppointment_flow.dart';
import 'package:vetyo/features/community/widgets/community_tips_card.dart';
import 'package:vetyo/features/vets/widgets/environment_status.dart';
import 'package:vetyo/features/vets/widgets/fact_section.dart';
import 'package:vetyo/features/vets/widgets/heath_advisory.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;

class VetScreen extends StatefulWidget {
  const VetScreen({super.key});

  @override
  State<VetScreen> createState() => _VetScreenState();
}

class _VetScreenState extends State<VetScreen> {
  Map<String, dynamic> formData = {};
  List<CustomFormFieldConfig> formFields = [];

  static const double _horizontalPadding = 24;

  @override
  void initState() {
    super.initState();

    // Ensure keyboard is dismissed when screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure formFields is not null
    if (formFields.isEmpty) {}

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: _horizontalPadding.w,
              right: _horizontalPadding,
              top: 16.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Vet',
                        style: TextStyle(
                          color: Color(
                            0xFF2BCCA5,
                          ) /* Brand-Healing-Green-600 */,
                          fontSize: 32,
                          fontFamily: 'Baloo 2',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: 'yo',
                        style: TextStyle(
                          color: Color(0xFF18ABD4) /* Brand-Bright-Sky-600 */,
                          fontSize: 32,
                          fontFamily: 'Baloo 2',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),

                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.communityScreen);
                  },
                  icon: Iconoir.Bell(width: 20.w, height: 20.h),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.communityScreen);
                  },
                  icon: Iconoir.Healthcare(width: 20.w, height: 20.h),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.communityScreen);
                  },
                  icon: Iconoir.Community(width: 20.w, height: 20.h),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                _buildBannerCarousel(),
                _verticalSpace(20),
                _buildCategorySection(),
                _verticalSpace(20),
                _buildAppointments(),

                _buildCommunityTipsSection(context),
                _verticalSpace(20),

                _buildRecommendedVets(),
                _verticalSpace(20),
                _buildHealthAdvisiory(),
                _verticalSpace(20),
                _buildFactSection(),

                _verticalSpace(64),
                _buildEnvironmentStatus(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // -------------------- Layout Helpers --------------------

  SliverToBoxAdapter _verticalSpace(double height) {
    return SliverToBoxAdapter(child: SizedBox(height: height.h));
  }

  SliverToBoxAdapter _buildBannerCarousel() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 163.h,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding.w),
          children: [
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

  // -------------------- Categories --------------------

  SliverToBoxAdapter _buildCategorySection() {
    return SliverToBoxAdapter(
      child: SizedBox(
        // height: 95.h,
        height: 105.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding.w),
          itemCount: categories.length,
          separatorBuilder: (_, __) => SizedBox(width: 16.w),
          itemBuilder: (_, index) {
            final category = categories[index];

            return _CategoryItem(
              label: category.name,
              image: category.imageUrl,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BookAppointmentFlow(
                          // You can pass category name if needed
                          categoryName: category.name,
                        ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHealthAdvisiory() {
    return SliverToBoxAdapter(child: Column(children: [HeathAdvisory()]));
  }

  SliverToBoxAdapter _buildFactSection() {
    return SliverToBoxAdapter(child: FactSection());
  }

  SliverToBoxAdapter _buildEnvironmentStatus() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: EnvironmentStatus(),
      ),
    );
  }

  // -------------------- Sections --------------------

  SliverToBoxAdapter _buildRecommendedVets() {
    return SliverToBoxAdapter(
      child: _VetRecommendList(
        title: context.l10n.recommendedVets,
        cardWidth: 327.w,
      ),
    );
  }

  SliverToBoxAdapter _buildAppointments() {
    return SliverToBoxAdapter(child: _AppointmentHorizontalList());
  }
}

class SilverToBoxAdapter {}

SliverToBoxAdapter _buildCommunityTipsSection(BuildContext context) {
  return SliverToBoxAdapter(
    child: Column(
      children: [
        _SectionHeader(title: context.l10n.communityTips, showSeeAll: false),
        SizedBox(height: 8.h),
        SizedBox(
          height: 136.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            itemCount: 5, // Example count
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (_, index) {
              return CommunityTipsCard(
                question: 'How to keep my pet healthy?',
                likes: '120',
                views: '1.2K',
                onTap: null,
                onLike: null,
              );
            },
          ),
        ),
      ],
    ),
  );
}

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
          colors: [
            ColorPalete.brightSky[500] ?? const Color(0xFF1DCDFE),
            ColorPalete.healingGreen[500] ?? const Color(0xFF34F5C6),
          ],
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
                      style: context.textBlackStyle().header5.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      subtitle,
                      style: context.textBlackStyle().small.copyWith(
                        color: Colors.white,
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

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.image,
    required this.label,
    required this.onTap,
  });

  // static const double _imageSize = 64;
  // static const double _itemWidth = 88;

  final String image;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 88.w,
        height: 104.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 76.w,
                  height: 76.h,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.00, 0.50),
                      end: Alignment(1.00, 0.50),
                      colors: [
                        Color(0xFF34F5C6) /* Brand-Healing-Green-500-(main) */,
                        Color(0xFF1DCDFE) /* Brand-Bright-Sky-500-(main) */,
                      ],
                    ),
                    shape: OvalBorder(),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    image,
                    width: 70.w,
                    height: 83.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            // SizedBox(height: 8.h),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textBlackStyle().medium.extraLarge.copyWith(
                fontFamily: 'Satoshi',
              ),
            ),
          ],
        ),
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
            Navigator.pushNamed(context, RoutePaths.allVetScreen);
          },
        ),
        SizedBox(height: 8.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(_dummyVets.length, (index) {
            final vet = _dummyVets[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: SizedBox(
                width: cardWidth,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(vet['image']!),
                    radius: 28.r,
                  ),
                  title: Text(
                    vet['name']!,
                    style: context.textBlackStyle().medium.bold.copyWith(
                      color: context.applyAppColor(
                        palette: ColorPalete.healingGreen,
                        swatch: 950,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    vet['specialty']!,
                    style:
                        context
                            .textStyle(
                              palette: ColorPalete.neutral,
                              swatch: 400,
                            )
                            .xsmall
                            .regular,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// class _VetAllList extends StatelessWidget {
//   const _VetAllList({required this.title, required this.cardWidth});

//   final String title;
//   final double cardWidth;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _SectionHeader(
//           title: title,
//           onSeeAll: () {
//             Navigator.pushNamed(context, '/allVetScreen');
//           },
//         ),
//         SizedBox(height: 8.h),
//         SizedBox(
//           height: 140.h,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             padding: EdgeInsets.only(left: 16.w),
//             itemCount: _dummyVets.length,
//             separatorBuilder: (_, __) => SizedBox(width: 8.w),
//             itemBuilder: (_, index) {
//               final vet = _dummyVets[index];
//               return SizedBox(
//                 width: cardWidth,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: VetCard(
//                     name: vet['name']!,
//                     specialty: vet['specialty']!,
//                     rating: double.parse(vet['rating']!),
//                     distance: vet['location']!,
//                     imageUrl: vet['image']!,
//                     onTap: () {
//                       // Handle vet card tap
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

class _AppointmentHorizontalList extends StatelessWidget {
  const _AppointmentHorizontalList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: context.l10n.appointments,
          onSeeAll: () {
            Navigator.pushNamed(context, '/appointmentScreen');
          },
        ),
        SizedBox(height: 9.h),
        SizedBox(
          height: 77.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            itemCount: _dummyAppointments.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final appointment = _dummyAppointments[index];
              return VetScreenAppointment(
                doctorName: appointment['doctorName']!,
                specialty: appointment['specialty']!,
                date: appointment['date']!,
                time: appointment['time']!,
                status: appointment['status']!,
                imageUrl: appointment['imageUrl'],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  final bool showSeeAll;

  const _SectionHeader({
    required this.title,
    this.onSeeAll,
    this.showSeeAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.textBlackStyle().large.bold.withSatoshi.brightSky900,
          ),
          if (showSeeAll)
            TextButton(
              onPressed: onSeeAll,
              child: Text(
                'See All',
                style:
                    context
                        .textStyle(palette: ColorPalete.brightSky, swatch: 500)
                        .small
                        .regular,
              ),
            ),
        ],
      ),
    );
  }
}

// -------------------- Dummy Data --------------------

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

const List<Map<String, String>> _dummyAppointments = [
  {
    'doctorName': 'Dr. David Patel',
    'specialty': 'Cardiologist',
    'date': 'May 26, 2026',
    'time': '10:30 AM',
    'status': 'Confirmed',
    'imageUrl': 'assets/images/avatar.png',
  },
  {
    'doctorName': 'Dr. Jessica Turner',
    'specialty': 'Gynecologist',
    'date': 'May 28, 2026',
    'time': '1:00 PM',
    'status': 'Pending',
    'imageUrl': 'assets/images/avatar.png',
  },
  {
    'doctorName': 'Dr. Michael Johnson',
    'specialty': 'Orthopedic Surgery',
    'date': 'Jun 01, 2026',
    'time': '4:15 PM',
    'status': 'Completed',
    'imageUrl': 'assets/images/avatar.png',
  },
];

class VetCategory {
  final String name;
  final String imageUrl;

  const VetCategory({required this.name, required this.imageUrl});
}

const List<VetCategory> categories = [
  VetCategory(name: 'Pet', imageUrl: AppImages.pet),
  VetCategory(name: "Livestock", imageUrl: AppImages.livestock),
  VetCategory(name: 'Poultry', imageUrl: AppImages.poultry),
  VetCategory(name: 'Aqua', imageUrl: AppImages.aquatic),
  VetCategory(name: 'Agriculture', imageUrl: AppImages.agriculture),
];

class VetScreenAppointment extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final String status;
  final String? imageUrl;

  const VetScreenAppointment({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.status,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 324.w,
      height: 76.h,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorPalete.brightSky.shade100),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with Doctor Image and Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Avatar
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                child: ClipOval(
                  child: Image.asset(
                    imageUrl ?? 'assets/images/avatar.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.person),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Doctor Name and Specialty
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      doctorName,
                      style: context.textBlackStyle().medium.bold.withSatoshi,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      specialty,
                      style: context.textBlackStyle().small.fontWeightMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
