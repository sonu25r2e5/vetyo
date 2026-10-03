import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/snackbar/snackbar.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/features/community/widgets/community_post_card.dart';
import 'package:vetyo/features/community/widgets/share_post_card_widget.dart';

class PostDetailsScreen extends StatefulWidget {
  final Map<String, dynamic>? postData;
  final bool shouldScrollToComment;

  const PostDetailsScreen({
    super.key,
    this.postData,
    this.shouldScrollToComment = false,
  });

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late FocusNode _commentFocusNode;
  bool _isLiked = false;
  bool _isBookmarked = false;

  List<Map<String, String>> comments = [
    {
      'author': 'Rahul Sharma',
      'role': 'Farm Owner',
      'time': '6d',
      'comment':
          'How can I get this product, is this available in local marketplace?',
      'likes': '600',
    },
    {
      'author': 'Rahul Sharma',
      'role': 'Farm Owner',
      'time': '6d',
      'comment':
          'How can I get this product, is this available in local marketplace?',
      'likes': '600',
    },
    {
      'author': 'Rahul Sharma',
      'role': 'Farm Owner',
      'time': '6d',
      'comment':
          'How can I get this product, is this available in local marketplace?',
      'likes': '600',
    },
  ];

  @override
  void initState() {
    super.initState();
    _commentFocusNode = FocusNode();
    // Scroll to comment field only if opened by clicking comment icon
    if (widget.shouldScrollToComment) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCommentField();
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCommentField() {
    // Scroll to the comment input field at the bottom
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    // Focus on the comment input field
    _commentFocusNode.requestFocus();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
    showSnackBar(context, _isLiked ? 'Post liked!' : 'Like removed');
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    showSuccessSnackBar(
      context,
      _isBookmarked ? 'Post bookmarked!' : 'Bookmark removed',
    );
  }

  void _sharePost() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const SharePostCardWidget(),
    );
  }

  void _showMoreOptions(BuildContext anchorContext) {
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
          child: Text('Save Post'),
          onTap: () => showSnackBar(anchorContext, 'Post Saved.'),
        ),
        PopupMenuItem(
          child: Text('Report Post'),
          onTap: () => showSnackBar(anchorContext, 'Post reported.'),
        ),
        PopupMenuItem(child: Text('Copy Link'), onTap: _sharePost),
        PopupMenuItem(
          child: Text('Not Interested'),
          onTap: () => showSnackBar(anchorContext, 'Post Hidden'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: Text('Community', style: context.textBlackStyle().header4),
      centerTitle: false,
      showBackButton: true,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          physics: const ScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8,
                ),
                child: CommunityPostCard(
                  userName: widget.postData?['userName'] ?? 'Unknown User',
                  userAvatar:
                      widget.postData?['userAvatar'] ??
                      'assets/images/avatar.png',
                  userType: widget.postData?['userType'] ?? 'User',
                  timeAgo: widget.postData?['timeAgo'] ?? '2 hours ago',
                  postTitle: widget.postData?['postTitle'] ?? 'Post Title',
                  postDescription:
                      widget.postData?['postDescription'] ?? 'Post Description',
                  postImage: widget.postData?['postImage'] as String?,
                  poll: widget.postData?['poll'] as Map<String, dynamic>?,
                  hashtags:
                      widget.postData?['hashtags']
                          as List<Map<String, dynamic>>? ??
                      [],
                  likes: widget.postData?['likes']?.toString() ?? '0',
                  comments: widget.postData?['comments']?.toString() ?? '0',
                  bookmarks: widget.postData?['bookmarks']?.toString() ?? '0',
                  shares: widget.postData?['shares']?.toString() ?? '0',
                  //   onShare: _sharePost,
                  //   onBookmark: _toggleBookmark,
                  //   onLike: _toggleLike,
                  //   onComment: _scrollToCommentField,
                  //   onMoreWithContext: _showMoreOptions,
                  // ),
                  onShare:
                      widget.postData?['onShare'] as VoidCallback? ?? () {},
                  onBookmark:
                      widget.postData?['onBookmark'] as VoidCallback? ?? () {},
                  onLike: widget.postData?['onLike'] as VoidCallback? ?? () {},
                  onComment:
                      widget.postData?['onComment'] as VoidCallback? ?? () {},
                  onMore: widget.postData?['onMore'] as VoidCallback? ?? () {},
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    // Comments Header
                    Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: ColorPalete.brightSky[500],
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Comments',
                      style: context.textBlackStyle().header3.medium,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '124 comments',
                      style: context.textBlackStyle().extraLarge.regular,
                    ),
                  ],
                ),
              ),
            ),

            // Comments List
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => CommentCard(comment: comments[index]),
                  childCount: comments.length,
                ),
              ),
            ),

            // Add Comment Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  children: [
                    // Comment Input
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundImage: const AssetImage(
                            'assets/images/avatar.png',
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorPalete.slate[500]!,
                              ),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 0,
                              ),
                              child: TextField(
                                controller: _commentController,
                                focusNode: _commentFocusNode,
                                decoration: InputDecoration(
                                  hintText: 'Add Comment',
                                  hintStyle: context
                                      .textBlackStyle()
                                      .small
                                      .regular
                                      .copyWith(color: ColorPalete.slate[500]),
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.sentiment_satisfied_outlined,
                                    color: ColorPalete.slate[500],
                                    size: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorPalete.brightSky[600],
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.w),
                            child: Icon(
                              Icons.send_outlined,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final Map<String, String> comment;
  final VoidCallback? onLike;
  final VoidCallback? onReply;

  const CommentCard({
    required this.comment,
    super.key,
    this.onLike,
    this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18.5.r,
                backgroundImage: const AssetImage('assets/images/avatar.png'),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                comment['author'] ?? '',
                                style: context.textBlackStyle().medium.bold,
                              ),
                              SizedBox(width: 4.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorPalete.brightSky[50],
                                  border: Border.all(
                                    color: ColorPalete.brightSky[300]!,
                                    width: 0.25,
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  comment['role'] ?? '',
                                  style: context
                                      .textBlackStyle()
                                      .small
                                      .medium
                                      .copyWith(color: ColorPalete.slate[800]),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                comment['time'] ?? '',
                                style: context
                                    .textBlackStyle()
                                    .small
                                    .medium
                                    .copyWith(color: ColorPalete.slate[500]),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          iconSize: 16.sp,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            final RenderBox button =
                                context.findRenderObject() as RenderBox;
                            final RenderBox overlay =
                                Overlay.of(context).context.findRenderObject()
                                    as RenderBox;
                            final RelativeRect position = RelativeRect.fromRect(
                              Rect.fromPoints(
                                button.localToGlobal(
                                  Offset.zero,
                                  ancestor: overlay,
                                ),
                                button.localToGlobal(
                                  button.size.bottomLeft(Offset.zero),
                                  ancestor: overlay,
                                ),
                              ),
                              Offset.zero & overlay.size,
                            );
                            showMenu(
                              context: context,
                              position: position,
                              items: [
                                PopupMenuItem(
                                  onTap: () {
                                    print("Edit comment");
                                  },
                                  child: const Text("Edit"),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    print("Delete comment");
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      comment['comment'] ?? '',
                      style: context.textBlackStyle().medium.regular,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: onLike,
                              child: Icon(
                                Icons.favorite_outline,
                                size: 15.sp,
                                color: ColorPalete.slate[900],
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              comment['likes'] ?? '',
                              style: context.textBlackStyle().small.medium,
                            ),
                          ],
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: onReply,
                          child: Text(
                            'Reply',
                            style: context
                                .textBlackStyle()
                                .small
                                .medium
                                .copyWith(color: ColorPalete.slate[700]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 30.w,
                          child: Divider(
                            color: ColorPalete.slate[500],
                            height: 1,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'View 5 more replies',
                          style: context.textBlackStyle().small.medium.copyWith(
                            color: ColorPalete.slate[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
