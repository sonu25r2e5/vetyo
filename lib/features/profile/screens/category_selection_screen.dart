import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/constants/app_images.dart';

class CategorySelectectionScreen extends StatefulWidget {
  const CategorySelectectionScreen({super.key});

  @override
  State<CategorySelectectionScreen> createState() =>
      _CategorySelectectionScreenState();
}

class _CategorySelectectionScreenState
    extends State<CategorySelectectionScreen> {
  late final List<_ProfileCategoryItem> _profileCategories;

  @override
  void initState() {
    super.initState();
    _initializeCategories();
  }

  void _initializeCategories() {
    _profileCategories = [
      _ProfileCategoryItem(
        title: 'Pet profile',
        asset: AppImages.pet,
        onTap: _handlePetProfileTap,
      ),
      _ProfileCategoryItem(
        title: 'Livestock profile',
        asset: AppImages.livestock,
        onTap: _handleLivestockProfileTap,
      ),
      _ProfileCategoryItem(
        title: 'Poultry profile',
        asset: AppImages.poultry,
        onTap: _handlePoultryProfileTap,
      ),
      _ProfileCategoryItem(
        title: 'Aqua profile',
        asset: AppImages.aquatic,
        onTap: _handleAquaProfileTap,
      ),
      _ProfileCategoryItem(
        title: 'Agriculture profile',
        asset: AppImages.agriculture,
        onTap: _handleAgricultureProfileTap,
      ),
    ];
  }

  /// Handle Pet Profile selection
  void _handlePetProfileTap() {
    Navigator.pushNamed(context, RoutePaths.addPetScreen);
  }

  /// Handle Livestock Profile selection
  void _handleLivestockProfileTap() {
    Navigator.pushNamed(context, RoutePaths.addLivestockScreen);
  }

  /// Handle Poultry Profile selection
  void _handlePoultryProfileTap() {
    Navigator.pushNamed(context, RoutePaths.addPoultryScreen);
  }

  /// Handle Aqua Profile selection
  void _handleAquaProfileTap() {
    Navigator.pushNamed(context, RoutePaths.addAquaScreen);
    // print('Aqua Profile Selected');
  }

  /// Handle Agriculture Profile selection
  void _handleAgricultureProfileTap() {
    Navigator.pushNamed(context, RoutePaths.addVegetableScreen);

    print('Agriculture Profile Selected');
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showBackButton: true,
      showAppBar: true,
      title: Text(
        'Select Categories',
        style: context.textBlackStyle().newheader1.withBaloo2,
      ),
      elevation: 0,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Header Section
                Text(
                  'Create  Pofile',
                  style:
                      context.textBlackStyle().large.semiBold.withSatoshi,
                ),
                SizedBox(height: 4.h,),
                Text(
                  'Select the category accordingly, to create the profile',
                  overflow: TextOverflow.ellipsis, // 👈 handles extra text
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style:
                      context
                          .textStyle(
                            palette: ColorPalete.supporting2,
                            swatch: 700,
                          )
                          .largeBody
                          .regular,
                ),
                SizedBox(height: 24.h),
                // Category Items
                Column(
                  children: List.generate(_profileCategories.length, (index) {
                    final item = _profileCategories[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 14.h),
                      child: _buildProfileCategoryTile(context, item),
                    );
                  }),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCategoryTile(
    BuildContext context,
    _ProfileCategoryItem item,
  ) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.4.r),
        ),
        child: Row(
          children: [
            // Image Container with Gradient
            Container(
              height: 56.h,
              width: 73.5.w,
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(52, 245, 198, 0.3),
                    Color.fromRGBO(29, 205, 254, 0.3),
                  ],
                  stops: [0.18371, 0.80506],
                ),
                borderRadius: BorderRadius.circular(8.4.r),
              ),
              child: Image.asset(item.asset, fit: BoxFit.contain),
            ),
            SizedBox(width: 16.w),
            // Title
            Expanded(
              child: Text(
                item.title,
                style: context.textBlackStyle().header3.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCategoryItem {
  final String title;
  final String asset;
  final VoidCallback onTap;

  const _ProfileCategoryItem({
    required this.title,
    required this.asset,
    required this.onTap,
  });
}
