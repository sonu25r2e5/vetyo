import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/localization/app_translations.dart';
import 'package:vetyo/features/vets/screens/all_vets_screen.dart';
import 'package:vetyo/features/vets/widgets/vet_card.dart';

class RecommendVetsScreen extends StatefulWidget {
  const RecommendVetsScreen({super.key});

  @override
  State<RecommendVetsScreen> createState() => _RecommendVetsScreenState();
}

class _RecommendVetsScreenState extends State<RecommendVetsScreen> {
  // List of 10 vets

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      bodyColor: AppColor.pageBodyColor,
      body: CustomScrollView(
        slivers: [
          /// App Bar
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColor.pageBodyColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.blackColor,
                size: 24.sp,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Recommend Vets',
              style: context.textBlackStyle().header6,
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
                  color: context.applyAppColor(
                    palette: ColorPalete.clinicCloud,
                    swatch: 100,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: context.applyAppColor(
                        palette: ColorPalete.neutral,
                        swatch: 400,
                      ),
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      context.l10n.searchVets,
                      style:
                          context
                              .textStyle(
                                palette: ColorPalete.neutral,
                                swatch: 400,
                              )
                              .small
                              .regular,
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
                    style: context.textBlackStyle().large.semiBold,
                  ),
                  Row(
                    children: [
                      Text(
                        'Default',
                        style:
                            context
                                .textStyle(
                                  palette: ColorPalete.neutral,
                                  swatch: 400,
                                )
                                .small
                                .semiBold,
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.swap_vert,
                        size: 14.sp,
                        color: context.applyAppColor(
                          palette: ColorPalete.neutral,
                          swatch: 400,
                        ),
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
                  onTap: (){
                    Navigator.pushNamed(
                      context,
                      RoutePaths.vetScreen,
                    );
                  },
                  child: VetCard(
                    name: vet.name,
                    specialty: vet.specialty,
                    distance: vet.location,
                    imageUrl: vet.imageUrl,
                    rating: vet.rating,
                    reviewsNo: vet.reviews,
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
