import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class CategoryProfileDetailsScreen extends StatefulWidget {
  const CategoryProfileDetailsScreen({super.key});

  @override
  State<CategoryProfileDetailsScreen> createState() =>
      _CategoryProfileDetailsScreenState();
}

class _CategoryProfileDetailsScreenState
    extends State<CategoryProfileDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      centerTitle: false,

      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Lucie',
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
                "Edit Profile",
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 24.h),
                      _buildProfileHeader(),
                      SizedBox(height: 32.h),
                      _buildAttachmentsSection(),
                      SizedBox(height: 28.h),
                      _buildConsultationHistorySection(),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: 'Book appointment for Lucie',
                  color: ColorPalete.brightSky[500],
                  width: double.infinity,
                  height: 40.h,
                  labelStyle: context.textBlackStyle().medium.regular.copyWith(
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              AppImages.vet1,
              width: 52.w,
              height: 52.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Lucie',
            style: context.textBlackStyle().large.semiBold.copyWith(
              color: ColorPalete.supporting2[950],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Husky',
            style: context.textBlackStyle().medium.regular.copyWith(
              color: ColorPalete.oceanTeal[300],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attachments',
          style: context.textBlackStyle().large.semiBold.copyWith(
            color: ColorPalete.supporting2[950],
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: 92.w,
          height: 64.h,
          decoration: BoxDecoration(
            color: ColorPalete.brightSky[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: ColorPalete.brightSky[500]!, width: 1),
          ),
          child: Icon(
            Icons.add_photo_alternate_outlined,
            color: ColorPalete.supporting2[500],
            size: 22.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildConsultationHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Consultation History',
          style: context.textBlackStyle().large.semiBold.copyWith(
            color: ColorPalete.supporting2[950],
          ),
        ),
        SizedBox(height: 12.h),
        _buildHistoryCard(),
        SizedBox(height: 16.h),
        _buildHistoryCard(),
      ],
    );
  }

  Widget _buildHistoryCard() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorPalete.clinicCloud[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              AppImages.vet1,
              width: 54.w,
              height: 54.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Skin infection consultation',
                        style: context
                            .textBlackStyle()
                            .medium
                            .semiBold
                            .copyWith(color: ColorPalete.supporting2[950]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorPalete.clinicCloud[400],
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'CLOSED',
                        style: context.textBlackStyle().small.regular.copyWith(
                          color: ColorPalete.supporting2[700],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  '12 Apr 2024',
                  style: context.textBlackStyle().small.regular.copyWith(
                    color: ColorPalete.oceanTeal[300],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Dr. Emma Watson · Closed',
                  style: context.textBlackStyle().small.regular.copyWith(
                    color: ColorPalete.oceanTeal[300],
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
