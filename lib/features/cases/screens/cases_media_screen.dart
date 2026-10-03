import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class CasesMediaScreen extends StatefulWidget {
  const CasesMediaScreen({super.key});

  @override
  State<CasesMediaScreen> createState() => _CasesMediaScreenState();
}

class _CasesMediaScreenState extends State<CasesMediaScreen> {
  final List<String> _galleryImages = List.generate(
    8,
    (index) => AppImages.pet,
  );

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      title: Text(
        "Images",
        style:
            context
                .textStyle(palette: ColorPalete.supporting2, swatch: 500)
                .medium
                .semiBold
                .header4,
      ),
      bodyColor: Colors.white,
      body: Column(
        children: [
          // _buildHeader(context),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 168 / 122,
                ),
                itemCount: _galleryImages.length,
                itemBuilder:
                    (context, index) =>
                        _buildImageTile(context, _galleryImages[index]),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          _buildHomeIndicator(context),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildImageTile(BuildContext context, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: context.applyAppColor(
          palette: ColorPalete.brightSky,
          swatch: 50,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.applyAppColor(
            palette: ColorPalete.brightSky,
            swatch: 200,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 10),
            blurRadius: 16,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildHomeIndicator(BuildContext context) {
    return Center(
      child: Container(
        height: 5.h,
        width: 134.w,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(3.r),
        ),
      ),
    );
  }
}
