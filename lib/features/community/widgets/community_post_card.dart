import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/community/widgets/status_chip_widget.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;

class CommunityPostCard extends StatefulWidget {
  const CommunityPostCard({
    super.key,
    required this.userName,
    required this.userAvatar,
    required this.userType,
    required this.timeAgo,
    required this.postTitle,
    required this.postDescription,
    required this.hashtags,
    required this.likes,
    required this.comments,
    required this.bookmarks,
    required this.shares,
    this.postImage,
    this.poll,
    this.isOnline = false,
    this.onLike,
    this.onComment,
    this.onBookmark,
    this.onShare,
    this.onMore,
    this.onMoreWithContext,
    this.onTap,
  });

  final String userName;
  final String userAvatar;
  final String userType;
  final String timeAgo;
  final bool isOnline;
  final String postTitle;
  final String postDescription;
  final String? postImage;
  final Map<String, dynamic>? poll;
  final List<Map<String, dynamic>> hashtags;
  final String likes;
  final String comments;
  final String bookmarks;
  final String shares;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onBookmark;
  final VoidCallback? onShare;
  final VoidCallback? onMore;
  final ValueChanged<BuildContext>? onMoreWithContext;
  final VoidCallback? onTap;

  @override
  State<CommunityPostCard> createState() => _CommunityPostCardState();
}

class _CommunityPostCardState extends State<CommunityPostCard> {
  late bool isLiked;
  late bool isBookmarked;
  int? _selectedPollOption;
  bool _hasVoted = false;

  @override
  void initState() {
    super.initState();
    isLiked = false;
    isBookmarked = false;
    _initializePollState();
  }

  void _initializePollState() {
    if (widget.poll != null) {
      final options = widget.poll!['options'] as List<dynamic>?;
      if (options != null) {
        for (int i = 0; i < options.length; i++) {
          final option = Map<String, dynamic>.from(options[i] as Map);
          if (option['selected'] as bool? ?? false) {
            _selectedPollOption = i;
            break;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorPalete.clinicCloud[600]!, width: 1.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post top container
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top container with profile and menu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile container
                    Row(
                      children: [
                        // User avatar with online indicator
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.asset(
                                widget.userAvatar,
                                width: 32.w,
                                height: 32.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Online indicator
                            if (widget.isOnline)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 10.w,
                                  height: 10.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF34F5C6),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.w,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: 12.w),
                        // Name and time container
                        SizedBox(
                          width: 91.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.userName,
                                maxLines: 1,
                                style: context
                                    .textBlackStyle()
                                    .medium
                                    .bold
                                    .withSatoshi
                                    .copyWith(
                                      color: ColorPalete.oceanTeal.shade800,
                                      height: 1.2,
                                    ),
                              ),
                              Text(
                                widget.timeAgo,
                                style: context
                                    .textBlackStyle()
                                    .xsmall
                                    .regular
                                    .withSatoshi
                                    .copyWith(
                                      color: ColorPalete.oceanTeal.shade800,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        UserType(userType: widget.userType),
                      ],
                    ),
                    // Three dot menu
                    Builder(
                      builder: (anchorContext) {
                        return GestureDetector(
                          onTap: () {
                            if (widget.onMoreWithContext != null) {
                              widget.onMoreWithContext!(anchorContext);
                              return;
                            }
                            widget.onMore?.call();
                          },
                          child: SizedBox(
                            width: 28.w,
                            height: 28.w,
                            child: Icon(
                              Icons.more_horiz,
                              size: 28.sp,
                              color: ColorPalete.supporting2[600]!,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Body container with hashtags
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Body text container
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Post title
                        Text(
                          widget.postTitle,
                          style: context
                              .textBlackStyle()
                              .medium
                              .bold
                              .withSatoshi
                              .copyWith(
                                color: ColorPalete.oceanTeal.shade900,
                                height: 1.2,
                              ),
                        ),
                        SizedBox(height: 12.h),
                        // Post description
                        Text(
                          widget.postDescription,
                          style: context
                              .textBlackStyle()
                              .small
                              .regular
                              .withSatoshi
                              .copyWith(
                                color: ColorPalete.oceanTeal.shade800,
                                height: 1.10,
                              ),
                        ),
                      ],
                    ),

                    // Post image (if provided)
                    if (widget.postImage != null) ...[
                      SizedBox(height: 12.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.asset(
                          widget.postImage!,
                          width: double.infinity,
                          height: 153.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 200.h,
                              decoration: BoxDecoration(
                                color: ColorPalete.clinicCloud[300],
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 48.sp,
                                color: ColorPalete.supporting2[400],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ] else ...[
                      SizedBox(height: 12.h),
                    ],

                    // Poll container (if provided)
                    if (widget.poll != null) ...[
                      SizedBox(height: 12.h),
                      // Poll title row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 28.w,
                            height: 28.w,
                            decoration: BoxDecoration(
                              color: ColorPalete.brightSky[50],
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Iconoir.StatsUpSquare(
                              width: 18.sp,
                              height: 18.sp,
                              color: ColorPalete.brightSky[600],
                            ),
                            // child: Icon(
                            //   ,
                            //   size: 18.sp,
                            //   color: ColorPalete.brightSky[600],
                            // ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              widget.poll!['question'] as String,
                              style: context
                                  .textBlackStyle()
                                  .medium
                                  .bold
                                  .withSatoshi
                                  .supporting2_900
                                  .copyWith(height: 1.2),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // Poll options - Radio list style
                      ...((widget.poll!['options'] as List<dynamic>)
                          .asMap()
                          .entries
                          .map((entry) {
                            int index = entry.key;
                            final opt = entry.value;
                            final option = Map<String, dynamic>.from(
                              opt as Map,
                            );
                            final label = option['label'] as String;
                            final votes = option['votes'] as int? ?? 0;
                            final isSelected = _selectedPollOption == index;

                            return GestureDetector(
                              onTap: () {
                                if (!_hasVoted) {
                                  setState(() {
                                    _selectedPollOption = index;
                                  });
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Row(
                                  children: [
                                    // Radio button
                                    Container(
                                      width: 20.w,
                                      height: 20.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              isSelected
                                                  ? ColorPalete.brightSky[500]!
                                                  : ColorPalete
                                                      .supporting2[300]!,
                                          width: 2.w,
                                        ),
                                      ),
                                      child:
                                          isSelected
                                              ? Center(
                                                child: Container(
                                                  width: 10.w,
                                                  height: 10.w,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        ColorPalete
                                                            .brightSky[500],
                                                  ),
                                                ),
                                              )
                                              : null,
                                    ),
                                    SizedBox(width: 12.w),
                                    // Label
                                    Expanded(
                                      child: Text(
                                        label,
                                        style: context
                                            .textBlackStyle()
                                            .large
                                            .bold
                                            .withSatoshi
                                            .copyWith(
                                              color:
                                                  ColorPalete
                                                      .oceanTeal
                                                      .shade700,
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    // Vote count
                                    Text(
                                      '$votes ${votes == 1 ? 'vote' : 'votes'}',
                                      style:
                                          context
                                              .textBlackStyle()
                                              .smallBody
                                              .regular
                                              .withSatoshi
                                              .supporting2_600,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })).toList(),

                      SizedBox(height: 16.h),

                      // Empty state or Vote button
                      _buildPollAction(),

                      SizedBox(height: 12.h),

                      // Poll summary (votes and remaining time)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.poll!['totalVotes'] as String? ?? '0 votes',
                            style:
                                context
                                    .textBlackStyle()
                                    .smallBody
                                    .regular
                                    .withSatoshi
                                    .supporting2_600,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            '•',
                            style: TextStyle(
                              color: ColorPalete.supporting2[400],
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            widget.poll!['daysRemaining'] as String? ??
                                '1 day left',
                            style:
                                context
                                    .textBlackStyle()
                                    .smallBody
                                    .regular
                                    .withSatoshi
                                    .supporting2_600,
                          ),
                        ],
                      ),
                    ],

                    // Hashtags container
                    Row(
                      children:
                          widget.hashtags
                              .map(
                                (hashtag) => Container(
                                  margin: EdgeInsets.only(right: 6.w),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: hashtag['bgColor'] as Color,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    hashtag['text'] as String,
                                    style: context
                                        .textBlackStyle()
                                        .xsmall
                                        .bold
                                        .withSatoshi
                                        .copyWith(
                                          color: hashtag['color'] as Color,
                                        ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // Bottom container with divider and actions
            Column(
              children: [
                // Divider
                Container(height: 1.h, color: ColorPalete.clinicCloud[400]),

                SizedBox(height: 16.h),

                // Reaction container
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Likes container
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                          widget.onLike?.call();
                        },
                        child: Row(
                          children: [
                            Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              size: 20.sp,
                              color:
                                  isLiked
                                      ? Color(0xFFE74C3C)
                                      : ColorPalete.supporting2[600]!,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              widget.likes,
                              style: context
                                  .textBlackStyle()
                                  .smallBody
                                  .semiBold
                                  .withSatoshi
                                  .supporting2_600
                                  .copyWith(
                                    height: 1.2,
                                    color:
                                        isLiked
                                            ? Color(0xFFE74C3C)
                                            : ColorPalete.supporting2[600]!,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      // Comments container
                      GestureDetector(
                        onTap: () {
                          widget.onComment?.call();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 20.sp,
                              color: ColorPalete.supporting2[600]!,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              widget.comments,
                              style: context
                                  .textBlackStyle()
                                  .smallBody
                                  .semiBold
                                  .withSatoshi
                                  .supporting2_600
                                  .copyWith(height: 1.2),
                            ),
                          ],
                        ),
                      ),

                      // Bookmarks container
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isBookmarked = !isBookmarked;
                          });
                          widget.onBookmark?.call();
                        },
                        child: Row(
                          children: [
                            Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              size: 20.sp,
                              color:
                                  isBookmarked
                                      ? Color(0xFF34F5C6)
                                      : ColorPalete.supporting2[600]!,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              widget.bookmarks,
                              style: context
                                  .textBlackStyle()
                                  .smallBody
                                  .semiBold
                                  .withSatoshi
                                  .supporting2_600
                                  .copyWith(
                                    height: 1.2,
                                    color:
                                        isBookmarked
                                            ? Color(0xFF34F5C6)
                                            : ColorPalete.supporting2[600]!,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      // Shares container
                      GestureDetector(
                        onTap: () {
                          widget.onShare?.call();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.share,
                              size: 20.sp,
                              color: ColorPalete.supporting2[600]!,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              widget.shares,
                              style: context
                                  .textBlackStyle()
                                  .smallBody
                                  .semiBold
                                  .withSatoshi
                                  .supporting2_600
                                  .copyWith(height: 1.2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollAction() {
    final totalVotes =
        int.tryParse(widget.poll!['totalVotes'].toString().split(' ')[0]) ?? 0;

    if (totalVotes == 0 && !_hasVoted) {
      // Empty state: "Be the first one to vote!"
      return CustomButton(
        label: "Vote",
        height: 42.h,
        onPressed: null,
        width: double.infinity,
        color: AppColor.brightSkyMain,
        labelStyle: context.textBlackStyle().medium.medium.withSatoshi.copyWith(
          color: ColorPalete.brightSky[50],
        ),
      );
    } else if (!_hasVoted && _selectedPollOption != null) {
      // Vote button - enabled when option is selected
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _hasVoted = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Vote submitted!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalete.brightSky[500],
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
          child: Text(
            'Vote',
            style: context
                .textBlackStyle()
                .baseBody
                .semiBold
                .withSatoshi
                .copyWith(color: Colors.white),
          ),
        ),
      );
    } else if (_hasVoted) {
      // Voted state - show thank you message
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: ColorPalete.healingGreen[50],
          border: Border.all(color: ColorPalete.healingGreen[200]!, width: 1.w),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 16.sp,
              color: ColorPalete.healingGreen[600],
            ),
            SizedBox(width: 8.w),
            Text(
              'Thanks for voting!',
              style: context
                  .textBlackStyle()
                  .smallBody
                  .semiBold
                  .withSatoshi
                  .copyWith(color: ColorPalete.healingGreen[700]),
            ),
          ],
        ),
      );
    } else {
      // Vote button disabled - waiting for selection
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalete.clinicCloud[300],
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
          child: Text(
            'Select an option to vote',
            style: context
                .textBlackStyle()
                .baseBody
                .semiBold
                .withSatoshi
                .copyWith(color: ColorPalete.supporting2[400]),
          ),
        ),
      );
    }
  }
}
