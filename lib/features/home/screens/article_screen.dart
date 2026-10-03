import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/text_to_speech_widget/text_to_speech_widget.dart';
import 'package:vetyo/core/localization/app_translations.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/features/home/widgets/home_content_card.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedTab = 0; // 0 for News, 1 for Saved

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedTab = index;
      _currentPage = 0; // Reset to first page when switching tabs
    });

    // Animate to first page
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showArticleDetails(HomeArticle article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ArticleDetailSheet(article: article),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get articles based on selected tab
    final displayArticles = _selectedTab == 0 ? articles : savedArticles;

    return Stack(
      children: [
        // Full screen page view (TikTok style)
        PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemCount: displayArticles.length,
          itemBuilder: (context, index) {
            final article = displayArticles[index];
            return _buildFullScreenCard(context, article, index);
          },
        ),

        // Top App Bar (Overlay)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8.h,
              bottom: 8.h,
              left: 24.w,
              right: 24.w,
            ),
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,

              // ),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.articleSearchScreen,
                    );
                  },
                  child: Icon(
                    Icons.search,
                    size: 24.sp,
                    color: ColorPalete.brightSky[950],
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => _onTabChanged(0),
                          child: Text(
                            context.l10n.news,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight:
                                  _selectedTab == 0
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                              color:
                                  _selectedTab == 0
                                      ? ColorPalete.brightSky.shade700
                                      : ColorPalete.brightSky[500],
                            ),
                          ),
                        ),
                        // SizedBox(height: 4.h),
                        // Container(
                        //   width: 35.w,
                        //   height: 2.h,
                        //   decoration: BoxDecoration(
                        //     color:
                        //         _selectedTab == 0
                        //             ? ColorPalete.brand
                        //             : Colors.transparent,
                        //     borderRadius: BorderRadius.circular(1.r),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => _onTabChanged(1),
                          child: Text(
                            context.l10n.saved,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight:
                                  _selectedTab == 1
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                              color:
                                  _selectedTab == 1
                                      ? ColorPalete.brightSky.shade700
                                      : ColorPalete.brightSky[950],
                            ),
                          ),
                        ),
                        // SizedBox(height: 4.h),
                        // Container(
                        //   width: 35.w,
                        //   height: 2.h,
                        //   decoration: BoxDecoration(
                        //     color:
                        //         _selectedTab == 1
                        //             ? Colors.white
                        //             : Colors.transparent,
                        //     borderRadius: BorderRadius.circular(1.r),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/notificationScreen');
                  },
                  icon: Icon(
                    Icons.notifications_outlined,
                    size: 24.sp,
                    color: ColorPalete.brightSky[950],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Page indicator (optional)
        Positioned(
          right: 16.w,
          top: MediaQuery.of(context).size.height * 0.5 - 50,
          child: Column(
            children: List.generate(articles.length > 5 ? 5 : articles.length, (
              index,
            ) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 4.h),
                width: 6.w,
                height: _currentPage == index ? 20.h : 6.h,
                decoration: BoxDecoration(
                  color:
                      _currentPage == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildFullScreenCard(
    BuildContext context,
    HomeArticle article,
    int index,
  ) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: AppColor.whiteColor,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 60.h,
            bottom: 80.h,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: HomeContentCard(
              title: article.title,
              subtitle: article.subtitle,
              date: article.date,
              author: article.author,
              excerpt: article.excerpt,
              imageAsset: article.imageAsset,
              isBookmarked: savedArticles.contains(article),
              onShare: () {
                _showShareOptions(article);
              },
              onBookmark: () {
                _handleBookmark(article);
              },
              onSeeMore: () {
                _showArticleDetails(article);
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showShareOptions(HomeArticle article) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Share Article',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                ListTile(
                  leading: const Icon(Icons.copy),
                  title: const Text('Copy Link'),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Link copied to clipboard')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text('Share via...'),
                  onTap: () {
                    Navigator.pop(context);
                    // Implement share functionality
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _handleBookmark(HomeArticle article) {
    setState(() {
      if (savedArticles.contains(article)) {
        savedArticles.remove(article);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${article.title.replaceAll('\n', ' ')} removed from saved',
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        savedArticles.add(article);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${article.title.replaceAll('\n', ' ')} saved'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }
}

// Article Detail Sheet Widget
class _ArticleDetailSheet extends StatelessWidget {
  final HomeArticle article;

  const _ArticleDetailSheet({required this.article});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Close button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: [
                        // Text-to-Speech Widget
                        TextToSpeechWidget(
                          textToSpeak: _getFullArticleContent(article),
                          iconSize: 20.sp,
                          iconColor: ColorPalete.healingGreen[600],
                        ),
                        SizedBox(width: 8.w),
                        IconButton(
                          icon: const Icon(Icons.bookmark_outline),
                          onPressed: () {
                            // Handle bookmark
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {
                            // Handle share
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        article.title.replaceAll('\n', ' '),
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF033D2F),
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Subtitle
                      Text(
                        article.subtitle.replaceAll('\n', ' '),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0x70232323),
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Meta info
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            article.date,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Icon(Icons.person, size: 14.sp, color: Colors.grey),
                          SizedBox(width: 4.w),
                          Text(
                            article.author,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Feature image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(
                          article.imageAsset,
                          width: double.infinity,
                          height: 250.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 250.h,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image, size: 50),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Article content (full text)
                      Text(
                        _getFullArticleContent(article),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xFF033D2F),
                          height: 1.6,
                          letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Related topics or tags
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children:
                            _getArticleTags(article)
                                .map(
                                  (tag) => Chip(
                                    label: Text(
                                      tag,
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                    backgroundColor: const Color(
                                      0xFF078768,
                                    ).withOpacity(0.1),
                                    labelPadding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getFullArticleContent(HomeArticle article) {
    // Generate full article content based on the excerpt
    return '''${article.excerpt.replaceAll('\n', ' ')}

In recent developments within the veterinary community, this story has captured the attention of professionals and pet owners alike. The implications of this event extend far beyond immediate circumstances, affecting policies, practices, and the overall approach to animal welfare.

Veterinary experts have weighed in on the situation, providing insights that highlight the importance of continued education and awareness in the field. Dr. ${article.author} has been instrumental in bringing this matter to light, demonstrating the dedication and expertise that define modern veterinary practice.

The broader context of this story reveals interconnected issues within animal healthcare, from preventive care to emergency response systems. Stakeholders across the industry are taking note, recognizing that collaborative efforts are essential for advancing animal welfare standards.

As this situation continues to unfold, the veterinary community remains committed to transparency, excellence in care, and the unwavering mission to protect and serve animals in need. The lessons learned from this experience will undoubtedly shape future approaches and strengthen the bond between animals and their caregivers.

Moving forward, initiatives are being developed to address the key challenges identified through this case. These efforts involve partnerships between veterinary clinics, animal welfare organizations, and educational institutions, all working together to create sustainable solutions.

The impact of this story serves as a reminder of the critical role that veterinarians play in our communities. Their expertise, compassion, and dedication continue to make a difference in the lives of countless animals and their human companions.

This ongoing narrative underscores the importance of staying informed, engaged, and proactive in matters concerning animal health and welfare. As we continue to learn and adapt, the veterinary profession evolves to meet the ever-changing needs of the animals we serve.''';
  }

  List<String> _getArticleTags(HomeArticle article) {
    // Generate relevant tags based on article content
    if (article.title.contains('DR.') || article.title.contains('DOCTOR')) {
      return ['Veterinary', 'Healthcare', 'Professional', 'News'];
    } else if (article.title.contains('CLINIC') ||
        article.title.contains('HOSPITAL')) {
      return ['Clinic', 'Services', 'Healthcare', 'Community'];
    } else if (article.title.contains('RESCUE') ||
        article.title.contains('WILDLIFE')) {
      return ['Wildlife', 'Rescue', 'Conservation', 'Animal Welfare'];
    } else if (article.title.contains('CARE') ||
        article.title.contains('HEALTH')) {
      return ['Pet Care', 'Health', 'Tips', 'Wellness'];
    } else if (article.title.contains('VACCINATION') ||
        article.title.contains('RABIES')) {
      return ['Vaccination', 'Prevention', 'Public Health', 'Campaign'];
    } else {
      return ['Veterinary', 'News', 'Animals', 'Community'];
    }
  }
}

class HomeArticle {
  final String title;
  final String subtitle;
  final String date;
  final String author;
  final String excerpt;
  final String imageAsset;

  HomeArticle({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.author,
    required this.excerpt,
    required this.imageAsset,
  });
}

// Saved articles list (initially contains some articles)
final List<HomeArticle> savedArticles = [
  HomeArticle(
    title: 'Understanding Canine Lyme Disease',
    subtitle: 'Symptoms and Prevention Tips',
    date: 'Dec 29, 2025',
    author: 'Jane Henderson',
    excerpt: 'Kathmandu. Senior\nveterinarian of the Animal checkR',
    imageAsset: AppImages.uploadImage,
  ),
  HomeArticle(
    title: 'PET HEALTH\nAWARENESS',
    subtitle: 'CAMPAIGN LAUNCHED',
    date: 'Jan 05, 2026',
    author: 'Emily Carter',
    excerpt: 'Free checkups and\nvaccinations announced',
    imageAsset: AppImages.appImage,
  ),
  HomeArticle(
    title: 'WILDLIFE\nRESCUE DRIVE',
    subtitle: 'SUCCESSFULLY COMPLETED',
    date: 'Jan 08, 2026',
    author: 'Daniel Smith',
    excerpt: 'Over 50 animals\nrescued nationwide',
    imageAsset: AppImages.vet2,
  ),
];

final List<HomeArticle> articles = [
  HomeArticle(
    title: 'DR. GHIMIRE\nRETURNS',
    subtitle: 'UNEXPECTEDLY FROM\nAUSTRALIA',
    date: 'Dec 29, 2025',
    author: 'Jane Henderson',
    excerpt: 'Kathmandu. Senior\nveterinarian of the Animal checkR',
    imageAsset: AppImages.uploadImage,
  ),
  HomeArticle(
    title: 'NEW ANIMAL\nCLINIC OPENS',
    subtitle: 'IN LALITPUR AREA',
    date: 'Jan 02, 2026',
    author: 'Mark Wilson',
    excerpt: 'A modern veterinary\nclinic opens for pets',
    imageAsset: AppImages.vet1,
  ),
  HomeArticle(
    title: 'PET HEALTH\nAWARENESS',
    subtitle: 'CAMPAIGN LAUNCHED',
    date: 'Jan 05, 2026',
    author: 'Emily Carter',
    excerpt: 'Free checkups and\nvaccinations announced',
    imageAsset: AppImages.appImage,
  ),
  HomeArticle(
    title: 'WILDLIFE\nRESCUE DRIVE',
    subtitle: 'SUCCESSFULLY COMPLETED',
    date: 'Jan 08, 2026',
    author: 'Daniel Smith',
    excerpt: 'Over 50 animals\nrescued nationwide',
    imageAsset: AppImages.vet2,
  ),
  HomeArticle(
    title: 'DOG CARE\nTIPS',
    subtitle: 'FOR WINTER SEASON',
    date: 'Jan 10, 2026',
    author: 'Sophia Brown',
    excerpt: 'Experts suggest diet\nand shelter precautions',
    imageAsset: AppImages.vet2,
  ),
  HomeArticle(
    title: 'CAT\nADOPTION DRIVE',
    subtitle: 'HAPPENING THIS WEEK',
    date: 'Jan 12, 2026',
    author: 'Oliver Green',
    excerpt: 'Local shelters invite\nanimal lovers',
    imageAsset: AppImages.vet3,
  ),
  HomeArticle(
    title: 'EMERGENCY\nVET SERVICES',
    subtitle: 'AVAILABLE 24/7',
    date: 'Jan 15, 2026',
    author: 'Isabella Moore',
    excerpt: 'Round-the-clock\nanimal care ensured',
    imageAsset: AppImages.vet4,
  ),
  HomeArticle(
    title: 'RABIES\nVACCINATION',
    subtitle: 'DRIVE IN KATHMANDU',
    date: 'Jan 18, 2026',
    author: 'William Scott',
    excerpt: 'Free vaccination camps\nset across the city',
    imageAsset: AppImages.vet5,
  ),
  HomeArticle(
    title: 'PET\nNUTRITION',
    subtitle: 'EXPERT GUIDELINES',
    date: 'Jan 20, 2026',
    author: 'Ava Taylor',
    excerpt: 'Balanced diet improves\nanimal longevity',
    imageAsset: AppImages.vet5,
  ),
  HomeArticle(
    title: 'ANIMAL\nWELFARE LAW',
    subtitle: 'NEW AMENDMENTS',
    date: 'Jan 22, 2026',
    author: 'Liam Anderson',
    excerpt: 'Stricter rules introduced\nto protect animals',
    imageAsset: AppImages.vet6,
  ),
];
