import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class CategoryProfileScreen extends StatefulWidget {
  const CategoryProfileScreen({super.key});

  @override
  State<CategoryProfileScreen> createState() => _CategoryProfileScreenState();
}

class _CategoryProfileScreenState extends State<CategoryProfileScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = const [
    'All',
    'Pets',
    'Livestocks',
    'Poultry',
    'Aqua',
    'Agriculture',
  ];

  final List<_CategoryProfileSection> _sections = const [
    _CategoryProfileSection(title: 'Pets', subtitle: 'Husky'),
    _CategoryProfileSection(title: 'Livestocks', subtitle: 'Husky'),
  ];

  String _selectedFilter = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Category Profile',
            style: context.textBlackStyle().header6.semiBold.withSatoshi,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutePaths.categorySelectionScreen,
                );
              },
              child: Text(
                "Add New",
                style: context
                    .textStyle(palette: ColorPalete.brightSky, swatch: 700)
                    .bold
                    .withSatoshi
                    .copyWith(height: 1.2),
              ),
            ),
          ),
        ],
      ),
      bodyColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFormField(
                  config: CustomFormFieldConfig(
                    id: 'search-profile',
                    label: 'Search Profile',
                    hintText: 'Search Profile',
                    showLabel: false,
                    isRequired: false,
                    fieldType: FieldType.searchField,
                    controller: _searchController,
                    prefixIcon: Icon(
                      Icons.search,
                      color: ColorPalete.oceanTeal[400],
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        _filters
                            .map(
                              (filter) => Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedFilter = filter;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          _selectedFilter == filter
                                              ? ColorPalete.brightSky[500]
                                              : ColorPalete.clinicCloud[400],
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Text(
                                      filter,
                                      style: context
                                          .textBlackStyle()
                                          .small
                                          .medium
                                          .copyWith(
                                            color:
                                                _selectedFilter == filter
                                                    ? ColorPalete.brightSky[50]
                                                    : ColorPalete
                                                        .oceanTeal[900],
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                SizedBox(height: 24.h),
                ..._sections.map(_buildSection),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(_CategoryProfileSection section) {
    return Padding(
      padding: EdgeInsets.only(bottom: 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  section.title,
                  style: context.textBlackStyle().medium.semiBold.copyWith(
                    color: ColorPalete.oceanTeal[600],
                  ),
                ),
              ),
              Icon(Icons.add, color: ColorPalete.brightSky[500], size: 24.sp),
            ],
          ),
          SizedBox(height: 12.h),
          _buildProfileInfo(section, () {
            Navigator.pushNamed(
              context,
              RoutePaths.categoryProfileDetailsScreen,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(
    _CategoryProfileSection section,
    VoidCallback? onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.asset(
                AppImages.avatarImage,
                width: 52.w,
                height: 52.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Lucie',
              style: context.textBlackStyle().large.semiBold.copyWith(
                color: ColorPalete.supporting2[950]!,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              section.subtitle,
              style: context.textBlackStyle().medium.regular.copyWith(
                color: ColorPalete.oceanTeal[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryProfileSection {
  final String title;
  final String subtitle;

  const _CategoryProfileSection({required this.title, required this.subtitle});
}
