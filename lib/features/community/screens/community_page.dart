import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/common/snackbar/snackbar.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/community/widgets/community_post_card.dart';
import 'package:vetyo/features/community/widgets/share_post_card_widget.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;

class CommunityScreen extends StatefulWidget {
  final int initialPage;
  const CommunityScreen({super.key, this.initialPage = 0});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();
  List<CustomFormFieldConfig> formFields = [];

  // Track liked, commented, and bookmarked posts
  Set<int> likedPosts = {};
  Set<int> commentedPosts = {};
  Set<int> bookmarkedPosts = {};

  // Track selected community tab
  String _selectedCommunityTab = 'Community';

  // Track my posts and saved posts
  Set<int> myPosts = {0}; // Dummy: user has created post 0
  Set<int> savedPosts = {1, 2}; // Dummy: user saved posts 1,2

  late TabController _tabController;
  static const double _horizontalPadding = 16;

  @override
  void initState() {
    super.initState();
    // Initialize tab controller with initial page from widget
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialPage,
    );
    // Set selected tab string based on initialPage
    switch (widget.initialPage) {
      case 1:
        _selectedCommunityTab = 'Saved Post';
        break;
      case 2:
        _selectedCommunityTab = 'My Post';
        break;
      default:
        _selectedCommunityTab = 'Community';
    }
    getInitialData();

    // Ensure keyboard is dismissed when screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  getInitialData() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "search",
        label: "Search community posts...",
        showLabel: false,
        isRequired: false,
        prefixIcon: Icon(Icons.search),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Ensure formFields is not null
    if (formFields.isEmpty) {
      getInitialData();
    }

    return BasePage(
      showAppBar: true,
      centerTitle: false,
      elevation: 0,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _selectedCommunityTab,
                style: context
                    .textBlackStyle()
                    .header6
                    .bold
                    .withBaloo2
                    .copyWith(fontSize: 20.sp),
              ),
              Builder(
                builder: (buttonContext) {
                  return GestureDetector(
                    onTap: () {
                      _showCommunityDropdown(buttonContext);
                    },
                    child: Iconoir.NavArrowDown(
                      width: 24.sp,
                      height: 24.sp,
                      color: ColorPalete.oceanTeal.shade900,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      trailing: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: CircleAvatar(
            backgroundColor: context.applyAppColor(
              palette: ColorPalete.brightSky,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutePaths.addPostScreen);
                // Handle notifications
              },
              icon: Icon(Icons.add, color: Colors.white, size: 24.sp),
            ),
          ),
        ),
      ],
      bottom: null,

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _horizontalPadding,
              ),
              child: CustomFormFieldGenerator(
                onFieldSubmitted: (data) {
                  formData = data ?? {};
                  setState(() {});
                },
                formKey: _formKey,
                formFields: formFields,
              ),
            ),

            // Header section

            // Content based on selected tab
            Expanded(child: _buildTabContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildAllPosts() {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          // avoid duplicating vertical spacing between the search and posts
          padding: EdgeInsets.fromLTRB(
            _horizontalPadding.w,
            0,
            _horizontalPadding.w,
            _horizontalPadding.w,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final post = _dummyCommunityPosts[index];
              final isLiked = likedPosts.contains(index);
              final isBookmarked = bookmarkedPosts.contains(index);

              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CommunityPostCard(
                  userName: post['userName'] as String,
                  userAvatar: post['userAvatar'] as String,
                  userType: post['userType'] as String, // Added userType
                  timeAgo: post['timeAgo'] as String,
                  isOnline: post['isOnline'] as bool? ?? false,
                  postTitle: post['postTitle'] as String,
                  postDescription: post['postDescription'] as String,
                  postImage: post['postImage'] as String?, // Added postImage
                  poll: post['poll'] as Map<String, dynamic>?,
                  hashtags: post['hashtags'] as List<Map<String, dynamic>>,
                  likes: post['likes'] as String,
                  comments: post['comments'] as String,
                  bookmarks: post['bookmarks'] as String,
                  shares: post['shares'] as String,
                  onLike: () {
                    setState(() {
                      if (likedPosts.contains(index)) {
                        likedPosts.remove(index);
                      } else {
                        likedPosts.add(index);
                      }
                    });
                    // Show feedback
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isLiked ? 'Like removed' : 'Post liked!',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        duration: Duration(milliseconds: 800),
                        backgroundColor: Color(0xFF34F5C6),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  onComment: () {
                    setState(() {
                      if (!commentedPosts.contains(index)) {
                        commentedPosts.add(index);
                      }
                    });
                    // Navigate to post detail with scroll to comment flag
                    Navigator.pushNamed(
                      context,
                      RoutePaths.postDetailScreen,
                      arguments: {
                        'postData': post,
                        'shouldScrollToComment': true,
                      },
                    );
                  },
                  onBookmark: () {
                    setState(() {
                      if (bookmarkedPosts.contains(index)) {
                        bookmarkedPosts.remove(index);
                      } else {
                        bookmarkedPosts.add(index);
                      }
                    });

                    showSuccessSnackBar(
                      context,
                      isBookmarked ? 'Bookmark removed' : 'Post bookmarked!',
                    );
                    // Show feedback
                  },
                  onShare: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const SharePostCardWidget(),
                    );
                  },
                  onMoreWithContext: (anchorContext) {
                    _showMoreOPtions(anchorContext);
                  },
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.postDetailScreen,
                      arguments: {'postData': post},
                    );
                  },
                ),
              );
            }, childCount: _dummyCommunityPosts.length),
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent() {
    switch (_selectedCommunityTab) {
      case 'Community':
        return _buildAllPosts();
      case 'Saved Post':
        return _buildSavedPosts();
      case 'My Post':
        return _buildMyPosts();
      default:
        return _buildAllPosts();
    }
  }

  Widget _buildMyPosts() {
    final myPostsList =
        _dummyCommunityPosts
            .asMap()
            .entries
            .where((entry) => myPosts.contains(entry.key))
            .toList();

    if (myPostsList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.post_add,
              size: 64.sp,
              color: ColorPalete.supporting2[400],
            ),
            SizedBox(height: 16.h),
            Text(
              'No posts yet',
              style: context.textBlackStyle().medium.bold.withSatoshi.copyWith(
                color: ColorPalete.oceanTeal.shade900,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Share your first experience with the community',
              style: context
                  .textBlackStyle()
                  .small
                  .regular
                  .withSatoshi
                  .copyWith(color: ColorPalete.supporting2[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            _horizontalPadding.w,
            0,
            _horizontalPadding.w,
            _horizontalPadding.w,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final entry = myPostsList[index];
              final originalIndex = entry.key;
              final post = entry.value;

              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CommunityPostCard(
                  userName: post['userName'] as String,
                  userAvatar: post['userAvatar'] as String,
                  userType: post['userType'] as String,
                  timeAgo: post['timeAgo'] as String,
                  isOnline: post['isOnline'] as bool? ?? false,
                  postTitle: post['postTitle'] as String,
                  postDescription: post['postDescription'] as String,
                  postImage: post['postImage'] as String?,
                  poll: post['poll'] as Map<String, dynamic>?,
                  hashtags: post['hashtags'] as List<Map<String, dynamic>>,
                  likes: post['likes'] as String,
                  comments: post['comments'] as String,
                  bookmarks: post['bookmarks'] as String,
                  shares: post['shares'] as String,
                  onLike: () {
                    setState(() {
                      if (likedPosts.contains(originalIndex)) {
                        likedPosts.remove(originalIndex);
                      } else {
                        likedPosts.add(originalIndex);
                      }
                    });
                  },
                  onComment: () {},
                  onBookmark: () {
                    setState(() {
                      if (bookmarkedPosts.contains(originalIndex)) {
                        bookmarkedPosts.remove(originalIndex);
                      } else {
                        bookmarkedPosts.add(originalIndex);
                      }
                    });
                  },
                  onShare: () {},
                  onMoreWithContext: (anchorContext) {
                    _showMyPostOptions(anchorContext);
                  },
                  onTap: () {},
                ),
              );
            }, childCount: myPostsList.length),
          ),
        ),
      ],
    );
  }

  Widget _buildSavedPosts() {
    final savedPostsList =
        _dummyCommunityPosts
            .asMap()
            .entries
            .where((entry) => savedPosts.contains(entry.key))
            .toList();

    if (savedPostsList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_outline,
              size: 64.sp,
              color: ColorPalete.supporting2[400],
            ),
            SizedBox(height: 16.h),
            Text(
              'No saved posts',
              style: context.textBlackStyle().medium.bold.withSatoshi.copyWith(
                color: ColorPalete.oceanTeal.shade900,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Bookmark posts to save them for later',
              style: context
                  .textBlackStyle()
                  .small
                  .regular
                  .withSatoshi
                  .copyWith(color: ColorPalete.supporting2[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            _horizontalPadding.w,
            0,
            _horizontalPadding.w,
            _horizontalPadding.w,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final entry = savedPostsList[index];
              final originalIndex = entry.key;
              final post = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CommunityPostCard(
                  userName: post['userName'] as String,
                  userAvatar: post['userAvatar'] as String,
                  userType: post['userType'] as String,
                  timeAgo: post['timeAgo'] as String,
                  isOnline: post['isOnline'] as bool? ?? false,
                  postTitle: post['postTitle'] as String,
                  postDescription: post['postDescription'] as String,
                  postImage: post['postImage'] as String?,
                  poll: post['poll'] as Map<String, dynamic>?,
                  hashtags: post['hashtags'] as List<Map<String, dynamic>>,
                  likes: post['likes'] as String,
                  comments: post['comments'] as String,
                  bookmarks: post['bookmarks'] as String,
                  shares: post['shares'] as String,
                  onLike: () {
                    setState(() {
                      if (likedPosts.contains(originalIndex)) {
                        likedPosts.remove(originalIndex);
                      } else {
                        likedPosts.add(originalIndex);
                      }
                    });
                  },
                  onComment: () {},
                  onBookmark: () {
                    setState(() {
                      if (bookmarkedPosts.contains(originalIndex)) {
                        bookmarkedPosts.remove(originalIndex);
                      } else {
                        bookmarkedPosts.add(originalIndex);
                      }
                    });
                  },
                  onShare: () {},
                  onMoreWithContext: (anchorContext) {
                    _showSavedPostOptions(anchorContext);
                  },
                  onTap: () {},
                ),
              );
            }, childCount: savedPostsList.length),
          ),
        ),
      ],
    );
  }

  void _showCommunityDropdown(BuildContext anchorContext) {
    final RenderBox overlay =
        Overlay.of(anchorContext).context.findRenderObject() as RenderBox;
    final RenderBox button = anchorContext.findRenderObject() as RenderBox;

    final Offset topLeft = button.localToGlobal(Offset.zero, ancestor: overlay);
    final Offset bottomRight = button.localToGlobal(
      button.size.bottomRight(Offset.zero),
      ancestor: overlay,
    );

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(topLeft, bottomRight),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: anchorContext,
      position: position,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      elevation: 8,
      items: [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.groups_outlined,
                size: 20.w,
                color: ColorPalete.oceanTeal.shade900,
              ),
              SizedBox(width: 12.w),
              Text(
                'Community',
                style: context
                    .textBlackStyle()
                    .medium
                    .medium
                    .withSatoshi
                    .copyWith(color: ColorPalete.oceanTeal.shade900),
              ),
            ],
          ),
          onTap: () {
            setState(() {
              _selectedCommunityTab = 'Community';
            });
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.bookmark_outline,
                size: 20.w,
                color: ColorPalete.oceanTeal.shade900,
              ),
              SizedBox(width: 12.w),
              Text(
                'Saved Post',
                style: context
                    .textBlackStyle()
                    .medium
                    .medium
                    .withSatoshi
                    .copyWith(color: ColorPalete.oceanTeal.shade900),
              ),
            ],
          ),
          onTap: () {
            setState(() {
              _selectedCommunityTab = 'Saved Post';
            });
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.edit_outlined,
                size: 20.w,
                color: ColorPalete.oceanTeal.shade900,
              ),
              SizedBox(width: 12.w),
              Text(
                'My Post',
                style: context
                    .textBlackStyle()
                    .medium
                    .medium
                    .withSatoshi
                    .copyWith(color: ColorPalete.oceanTeal.shade900),
              ),
            ],
          ),
          onTap: () {
            setState(() {
              _selectedCommunityTab = 'My Post';
            });
          },
        ),
      ],
    );
  }

  void _showMyPostOptions(BuildContext anchorContext) {
    showModalBottomSheet(
      context: anchorContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(8.w, 12.h, 16.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorPalete.clinicCloud[300]?.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              // Actions container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    // Edit Post
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showSnackBar(
                          anchorContext,
                          "Edit post feature coming soon",
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              size: 24.sp,
                              color: ColorPalete.oceanTeal.shade900,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Saved Post',
                              style: context
                                  .textBlackStyle()
                                  .medium
                                  .medium
                                  .withSatoshi
                                  .copyWith(
                                    color: ColorPalete.oceanTeal.shade700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Delete Post
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showSnackBar(anchorContext, "Post deleted");
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline,
                              size: 24.sp,
                              color: Color(0xFFC10007),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Delete Post',
                              style: context
                                  .textBlackStyle()
                                  .medium
                                  .medium
                                  .withSatoshi
                                  .copyWith(color: Color(0xFFC10007)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Turn Off Notifications
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showSnackBar(anchorContext, "Notifications turned off");
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.notifications_off_outlined,
                              size: 24.sp,
                              color: ColorPalete.oceanTeal.shade900,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Turn Off Notifications',
                              style: context
                                  .textBlackStyle()
                                  .medium
                                  .medium
                                  .withSatoshi
                                  .copyWith(
                                    color: ColorPalete.oceanTeal.shade700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Copy Link
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showSnackBar(anchorContext, "Link copied");
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.link,
                              size: 24.sp,
                              color: ColorPalete.oceanTeal.shade900,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Copy Link',
                              style: context
                                  .textBlackStyle()
                                  .medium
                                  .medium
                                  .withSatoshi
                                  .copyWith(
                                    color: ColorPalete.oceanTeal.shade700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSavedPostOptions(BuildContext anchorContext) {
    showModalBottomSheet(
      context: anchorContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(8.w, 12.h, 16.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorPalete.clinicCloud[300]?.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              // Actions container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    // Edit Post
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showSnackBar(
                          anchorContext,
                          "Edit post feature coming soon",
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              size: 24.sp,
                              color: ColorPalete.oceanTeal.shade900,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Saved Post',
                              style: context
                                  .textBlackStyle()
                                  .medium
                                  .medium
                                  .withSatoshi
                                  .copyWith(
                                    color: ColorPalete.oceanTeal.shade700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Turn Off Notifications
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showSnackBar(anchorContext, "Notifications turned off");
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Iconoir.ProfileCircle(
                              color: ColorPalete.oceanTeal.shade900,
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Follow this Discussions',
                              style: context
                                  .textBlackStyle()
                                  .medium
                                  .medium
                                  .withSatoshi
                                  .copyWith(
                                    color: ColorPalete.oceanTeal.shade700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Copy Link
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showSnackBar(anchorContext, "Link copied");
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.link,
                              size: 24.sp,
                              color: ColorPalete.oceanTeal.shade900,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Copy Link',
                              style: context
                                  .textBlackStyle()
                                  .medium
                                  .medium
                                  .withSatoshi
                                  .copyWith(
                                    color: ColorPalete.oceanTeal.shade700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showSnackBar(anchorContext, "Post deleted");
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Iconoir.WarningTriangle(
                              color: ColorPalete.oceanTeal.shade900,
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Copy Link',
                              style: context
                                  .textBlackStyle()
                                  .medium
                                  .medium
                                  .withSatoshi
                                  .copyWith(
                                    color: ColorPalete.oceanTeal.shade700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMoreOPtions(BuildContext anchorContext) {
    showModalBottomSheet(
      context: anchorContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorPalete.clinicCloud[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showSnackBar(anchorContext, "Post Saved.");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark_outline,
                        size: 24.sp,
                        color: ColorPalete.oceanTeal.shade900,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Save Post',
                        style: context
                            .textBlackStyle()
                            .medium
                            .medium
                            .withSatoshi
                            .copyWith(color: ColorPalete.oceanTeal.shade900),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showSnackBar(anchorContext, "Post reported.");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        size: 24.sp,
                        color: ColorPalete.oceanTeal.shade900,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Report Post',
                        style: context
                            .textBlackStyle()
                            .medium
                            .medium
                            .withSatoshi
                            .copyWith(color: ColorPalete.oceanTeal.shade900),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: anchorContext,
                    builder: (context) => const SharePostCardWidget(),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.link,
                        size: 24.sp,
                        color: ColorPalete.oceanTeal.shade900,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Copy Link',
                        style: context
                            .textBlackStyle()
                            .medium
                            .medium
                            .withSatoshi
                            .copyWith(color: ColorPalete.oceanTeal.shade900),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showSnackBar(anchorContext, "Post Hidden");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.visibility_off_outlined,
                        size: 24.sp,
                        color: ColorPalete.oceanTeal.shade900,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Not Interested',
                        style: context
                            .textBlackStyle()
                            .medium
                            .medium
                            .withSatoshi
                            .copyWith(color: ColorPalete.oceanTeal.shade900),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        );
      },
    );
  }
}

// -------------------- Dummy Data --------------------

final _dummyCommunityPosts = [
  {
    'userName': 'Rahul Sharma',
    'userAvatar': 'assets/images/profile_avatar.jpg',
    "userType": "Veterinarian", // Added userType
    'timeAgo': '2 hours ago',
    'isOnline': true,
    'postTitle':
        'My cows has stopped eating properly, any advice on what could be wrong?',
    'postDescription':
        'She seems lethargic since yesterday morning. I checked her temperature and it was normal. An...',
    'postImage': 'assets/images/farm.png', // Added post image
    'poll': {
      'question': 'Which deworming brand do you find most effective?',
      'options': [
        {'label': 'Brand AlphaVET', 'percentage': 45, 'selected': true},
        {'label': 'Brand CaninePlus', 'percentage': 30, 'selected': false},
        {'label': 'Brand GuardMax', 'percentage': 25, 'selected': false},
      ],
      'totalVotes': '1,240 total votes',
      'daysRemaining': '1 day remaining',
    },
    'hashtags': [
      {
        'text': '#Livestock',
        'color': Color(0xFF23A384),
        'bgColor': Color(0xFFECFDF5),
      },
      {
        'text': '#Nutrition',
        'color': Color(0xFFE17100),
        'bgColor': Color(0xFFFFFBEB),
      },
    ],
    'likes': '1.2k',
    'comments': '8.2k',
    'bookmarks': '8.2k',
    'shares': '8.2k',
  },
  {
    'userName': 'Emily Johnson',
    'userAvatar': 'assets/images/emily_center.png',
    "userType": "Farm Owner", // Added userType
    'timeAgo': '5 hours ago',
    'isOnline': false,
    'postTitle':
        'Best vaccination schedule for puppies - sharing my experience',
    'postDescription':
        'After consulting with multiple vets, here\'s the vaccination timeline that worked best for my golden retriever...',
    'postImage': 'assets/images/pet_cat.png', // Added post image
    'hashtags': [
      {
        'text': '#Pets',
        'color': Color(0xFF23A384),
        'bgColor': Color(0xFFECFDF5),
      },
      {
        'text': '#Vaccination',
        'color': Color(0xFFE17100),
        'bgColor': Color(0xFFFFFBEB),
      },
    ],
    'likes': '2.1k',
    'comments': '15.3k',
    'bookmarks': '5.2k',
    'shares': '1.8k',
  },
  {
    'userName': 'Dr. Mike Wilson',
    'userAvatar': 'assets/images/avatar.png',
    "userType": "Personal User", // Added userType
    'timeAgo': '1 day ago',
    'isOnline': true,
    'postTitle': 'Common signs of dehydration in farm animals during summer',
    'postDescription':
        'As temperatures rise, it\'s crucial to monitor your livestock for these warning signs...',
    'postImage': null, // Added post image
    'hashtags': [
      {
        'text': '#Farm',
        'color': Color(0xFF23A384),
        'bgColor': Color(0xFFECFDF5),
      },
      {
        'text': '#Health',
        'color': Color(0xFFE17100),
        'bgColor': Color(0xFFFFFBEB),
      },
    ],
    'likes': '892',
    'comments': '23.1k',
    'bookmarks': '3.4k',
    'shares': '2.1k',
  },
];
