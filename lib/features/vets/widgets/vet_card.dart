import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/localization/app_translations.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class VetCard extends StatefulWidget {
  final String name;
  final String specialty;

  final double rating;
  final String distance;
  final String imageUrl;
  final int? reviewsNo;
  final VoidCallback? onTap;
  final bool isFavorite;
  final ValueChanged<bool>? onFavoriteChanged;

  const VetCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.distance,
    required this.imageUrl,
    this.reviewsNo,
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteChanged,
    // required Null Function() onPressed,
  });

  @override
  State<VetCard> createState() => _VetCardState();
}

class _VetCardState extends State<VetCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  void didUpdateWidget(VetCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      _isFavorite = widget.isFavorite;
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onFavoriteChanged?.call(_isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.sp),
      decoration: ShapeDecoration(
        color: Color(0xFFFAFAFA),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: const Color(0xFFF5F5F5)),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          BoxShadow(
            color: Colors.black.withAlpha(05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Vet Image
          Container(
            width: 109.w,
            height: 109.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: const Color(0xFFF5F5F5),
              image: DecorationImage(
                image:
                    widget.imageUrl.startsWith('http')
                        ? NetworkImage(widget.imageUrl) as ImageProvider
                        : AssetImage(widget.imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 16.w),

          // Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.name,
                        style: context.textBlackStyle().bold.extraLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: _toggleFavorite,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          key: ValueKey<bool>(_isFavorite),
                          color: _isFavorite ? Colors.red : Colors.black,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                Divider(color: Colors.grey),
                SizedBox(height: 4.h),
                Text(
                  widget.specialty,
                  style: context.textBlackStyle().medium.largeBody.copyWith(
                    fontFamily: 'Satoshi',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),

                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: const Color(0xFFC5C6CC),
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        widget.distance,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        // softWrap: true,
                        style: context
                            .textBlackStyle()
                            .largeBody
                            .regular
                            .copyWith(
                              fontFamily: 'Satoshi',
                              color: const Color(0xFF525252),
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                // Rating and Distance Row
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: const Color(0xFFFFD33C),
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      widget.rating.toStringAsFixed(1),
                      style: context.textBlackStyle().regular.baseBody.copyWith(
                        fontFamily: "Satoshi",
                      ),
                    ),

                    SizedBox(width: 16.w),
                    if (widget.reviewsNo != null) ...[
                      Icon(
                        Icons.comment,
                        color: const Color(0xFF71727A),
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${widget.reviewsNo} ${context.l10n.reviews}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF71727A),
                          fontFamily: "Inter",
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
