import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class HomeContentCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String date;
  final String author;
  final String excerpt;
  final String imageAsset;
  final VoidCallback onShare;
  final VoidCallback onBookmark;
  final VoidCallback onSeeMore;
  final bool isBookmarked;

  const HomeContentCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.author,
    required this.excerpt,
    required this.imageAsset,
    required this.onShare,
    required this.onBookmark,
    required this.onSeeMore,
    this.isBookmarked = false,
  });

  @override
  State<HomeContentCard> createState() => _HomeContentCardState();
}

class _HomeContentCardState extends State<HomeContentCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSeeMore,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Headline
          Text(
            widget.title,
            style: context.textBlackStyle().withSatoshi.copyWith(
              color: ColorPalete.oceanTeal[950],
              fontSize: 36.sp,
              fontWeight: FontWeight.w900,
              height: 1.16.h,
            ),
            maxLines: 3,
          ),

          SizedBox(height: 8.h),

          /// Subheadline
          Text(
            widget.subtitle,
            style: context.textBlackStyle().header4.black.withSatoshi.copyWith(
              color: ColorPalete.oceanTeal[700],
              height: 1.11.h,
            ),
            maxLines: 2,
          ),

          SizedBox(height: 8.h),

          /// Meta
          Text(
            widget.date,
            style:
                context
                    .textStyle(palette: ColorPalete.oceanTeal, swatch: 500)
                    .small
                    .regular
                    .withSatoshi,
          ),
          Text(
            'Author: ${widget.author}',
            style:
                context
                    .textStyle(palette: ColorPalete.oceanTeal, swatch: 500)
                    .small
                    .regular
                    .withSatoshi,
          ),
          SizedBox(height: 8.h),

          /// Image with actions
          Stack(
            children: [
              Container(
                height: 260.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: AssetImage(widget.imageAsset),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          LayoutBuilder(
            builder: (context, constraints) {
              final textStyle =
                  context
                      .textStyle(palette: ColorPalete.oceanTeal, swatch: 700)
                      .small
                      .regular
                      .withSatoshi;

              final textPainter = TextPainter(
                text: TextSpan(text: widget.excerpt, style: textStyle),
                maxLines: 2,
                textDirection: TextDirection.ltr,
                ellipsis: '...',
              )..layout(maxWidth: constraints.maxWidth - 48.w);

              final isOverflowing = textPainter.didExceedMaxLines;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.excerpt,
                          style: textStyle,
                          maxLines: isExpanded ? null : 2,
                          overflow:
                              isExpanded
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        children: [
                          _ActionButton(
                            icon: Icons.share,
                            onTap: widget.onShare,
                          ),
                          SizedBox(height: 8.h),
                          _ActionButton(
                            icon:
                                widget.isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_outline,
                            onTap: widget.onBookmark,
                          ),
                        ],
                      ),
                    ],
                  ),

                  if (isOverflowing || isExpanded) ...[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? 'see less' : 'see more...',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: const Color(0xFF033D2F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20.sp, color: Colors.black),
      ),
    );
  }
}
