import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;

class ArticleSearchScreen extends StatefulWidget {
  const ArticleSearchScreen({super.key});

  @override
  State<ArticleSearchScreen> createState() => _ArticleSearchScreenState();
}

class _ArticleSearchScreenState extends State<ArticleSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _bannerController = PageController(
    viewportFraction: 0.92,
  );

  static const Color _mutedColor = Color(0xFF62748E);

  @override
  void dispose() {
    _searchController.dispose();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showBackButton: false,
      colors: Colors.white,
      title: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.keyboard_arrow_left,
                size: 24.sp,
                color: AppColor.brightSkyMain,
              ),
            ),
            SizedBox(width: 12.w),

            Expanded(
              child: Container(
                height: 44.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(Icons.search, size: 24.sp, color: _mutedColor),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 14,
                          color: Color(0xFF62748E),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search Articles',
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onSubmitted: (_) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Recent",
                  style: context.textBlackStyle().large.medium.withSatoshi,
                ),
                Spacer(),
                Text(
                  "See All ",
                  style: context.textBlackStyle().large.medium.withSatoshi,
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: List.generate(
                  5,
                  (index) => buildSearchItem(
                    SearchItem(title: "How to care for a new puppy?"),
                    context,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchItem {
  String title;
  SearchItem({required this.title});
}

Widget buildSearchItem(SearchItem item, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Iconoir.ClockRotateRight(
          width: 24.sp,
          height: 24.sp,
          color: Colors.black,
        ),

        SizedBox(width: 16.w),
        Text(
          item.title,
          style: context.textBlackStyle().large.bold.withSatoshi.copyWith(
            color: ColorPalete.oceanTeal.shade700,
          ),
        ),

        Spacer(),
        Iconoir.Xmark(
          width: 24.sp,
          height: 24.sp,
          color: ColorPalete.oceanTeal.shade500,
        ),

        // Text(
        //   item.title,
        //   style: context.textBlackStyle().medium.withSatoshi.copyWith(
        //         color: const Color(0xFF62748E),
        //         fontSize: 14,
        //       ),
      ],
    ),
  );
}
