import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_fonts.dart';
import 'package:vetyo/constants/font_size.dart';
import 'package:vetyo/constants/font_weight.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/localization/app_translations.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/vets/widgets/vet_card.dart';

// Vet Model
class Vet {
  final String name;
  final String specialty;
  final String location;
  final String imageUrl;
  final double rating;
  final int reviews;

  Vet({
    required this.name,
    required this.specialty,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
  });
}

class AllVetsScreen extends StatefulWidget {
  const AllVetsScreen({super.key});

  @override
  State<AllVetsScreen> createState() => _AllVetsScreenState();
}

class _AllVetsScreenState extends State<AllVetsScreen> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      bodyColor: AppColor.whiteColor,
      body: CustomScrollView(
        slivers: [
          /// App Bar
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColor.whiteColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.supporting2Main,
                size: 24.sp,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'All Vets',
              style:
                  context.textBlackStyle().header4.bold.withSatoshi.supporting2,
            ),
            centerTitle: true,
          ),

          /// Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: ColorPalete.clinicCloud[100],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: ColorPalete.neutral[400],
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: context.l10n.searchVets,
                          hintStyle:
                              context
                                  .textStyle(
                                    palette: ColorPalete.neutral,
                                    swatch: 400,
                                  )
                                  .largeBody
                                  .regular
                                  .withSatoshi,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Space
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          /// Found Count and Sort
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${vets.length} founds',
                    style:
                        context
                            .textBlackStyle()
                            .header5
                            .bold
                            .withSatoshi
                            .healingGreen900,
                  ),
                  Row(
                    children: [
                      Text(
                        'Default',
                        style: TextStyle(
                          fontSize: FontSize.largeBody,
                          fontWeight: AppFontWeight.bold,
                          color: ColorPalete.neutral[500],
                          fontFamily: AppFonts.satoshi,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.swap_vert,
                        size: 14.sp,
                        color: ColorPalete.neutral[500],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// Space
          SliverToBoxAdapter(child: SizedBox(height: 8.h)),

          /// Vets List
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final vet = vets[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: GestureDetector(
                  onTap: () {
                    //
                    //Handle vet card tap
                    Navigator.pushNamed(context, RoutePaths.doctorProfileDetailsScreen);
                  },

                  child: VetCard(
                    name: vet.name,
                    specialty: vet.specialty,
                    distance: vet.location,
                    imageUrl: vet.imageUrl,
                    rating: vet.rating,
                    reviewsNo: vet.reviews,
                    onTap: () {
                      // Handle vet card tap
                    },
                  ),
                ),
              );
            }, childCount: vets.length),
          ),

          /// Bottom Padding
          SliverToBoxAdapter(child: SizedBox(height: 40.h)),
        ],
      ),
    );
  }
}

final List<Vet> vets = [
  Vet(
    name: 'Dr. Suresh Adhikari',
    specialty: 'Veterinary Surgeon',
    location: 'Kathmandu Pet Clinic, Kathmandu, Nepal',
    imageUrl:
        'https://images.pexels.com/photos/6235233/pexels-photo-6235233.jpeg',
    rating: 4.9,
    reviews: 342,
  ),
  Vet(
    name: 'Dr. Anisha Karki',
    specialty: 'Animal Dermatologist',
    location: 'Pokhara Animal Care, Pokhara, Nepal',
    imageUrl:
        'https://images.pexels.com/photos/5327585/pexels-photo-5327585.jpeg',
    rating: 4.8,
    reviews: 210,
  ),
  Vet(
    name: 'Dr. Ramesh Thapa',
    specialty: 'Livestock Specialist',
    location: 'Chitwan Veterinary Hospital, Chitwan, Nepal',
    imageUrl:
        'https://images.pexels.com/photos/6749778/pexels-photo-6749778.jpeg',
    rating: 4.7,
    reviews: 189,
  ),
  Vet(
    name: 'Dr. Pooja Shrestha',
    specialty: 'Small Animal Specialist',
    location: 'Lalitpur Pet Care Center, Lalitpur, Nepal',
    imageUrl:
        'https://images.pexels.com/photos/8460157/pexels-photo-8460157.jpeg',
    rating: 5.0,
    reviews: 421,
  ),
  Vet(
    name: 'Dr. Bikash Lama',
    specialty: 'Veterinary Orthopedics',
    location: 'Bhaktapur Animal Clinic, Bhaktapur, Nepal',
    imageUrl:
        'https://images.pexels.com/photos/5726709/pexels-photo-5726709.jpeg',
    rating: 4.6,
    reviews: 133,
  ),
  Vet(
    name: 'Dr. Sunita Rai',
    specialty: 'Veterinary Gynecology',
    location: 'Biratnagar Vet Clinic, Biratnagar, Nepal',
    imageUrl:
        'https://images.pexels.com/photos/6234617/pexels-photo-6234617.jpeg',
    rating: 4.9,
    reviews: 298,
  ),
  Vet(
    name: 'Dr. Kiran Gurung',
    specialty: 'Animal Nutrition Expert',
    location: 'Dharan Animal Hospital, Dharan, Nepal',
    imageUrl:
        'https://images.pexels.com/photos/6234600/pexels-photo-6234600.jpeg',
    rating: 4.7,
    reviews: 156,
  ),
  Vet(
    name: 'Dr. Nisha Tamang',
    specialty: 'Pet Emergency Specialist',
    location: 'Nepal Vet Emergency Center, Kathmandu, Nepal',
    imageUrl:
        'https://images.pexels.com/photos/5722164/pexels-photo-5722164.jpeg',
    rating: 5.0,
    reviews: 512,
  ),
  Vet(
    name: 'Dr. Arjun Basnet',
    specialty: 'Large Animal Specialist',
    location: 'Butwal Veterinary Services, Butwal, Nepal',
    imageUrl:
        'https://images.pexels.com/photos/5327921/pexels-photo-5327921.jpeg',
    rating: 4.8,
    reviews: 264,
  ),
  Vet(
    name: 'Dr. Meena Bhandari',
    specialty: 'Veterinary Pathologist',
    location: 'Hetauda Animal Health Center, Hetauda, Nepal',
    imageUrl:
        'https://images.pexels.com/photos/6235025/pexels-photo-6235025.jpeg',
    rating: 4.9,
    reviews: 378,
  ),
];
