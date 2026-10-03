import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_fonts.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';

// Doctor model for better data structure
class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final String location;
  final String imageUrl;
  final int patients;
  final int experience;
  final double rating;
  final int reviews;
  final String about;
  final String workingHours;
  final List<ReviewModel> reviewsList;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.location,
    required this.imageUrl,
    required this.patients,
    required this.experience,
    required this.rating,
    required this.reviews,
    required this.about,
    required this.workingHours,
    required this.reviewsList,
  });
}

class ReviewModel {
  final String userName;
  final String userImage;
  final double rating;
  final String comment;
  final DateTime date;

  ReviewModel({
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

class VetDetailsScreen extends StatefulWidget {
  final DoctorModel? doctor; // Accept doctor data as parameter

  const VetDetailsScreen({super.key, this.doctor});

  @override
  State<VetDetailsScreen> createState() => VetDetailsScreenState();
}

class VetDetailsScreenState extends State<VetDetailsScreen>
    with TickerProviderStateMixin {
  // State variables for interactivity
  bool _isFavorite = false;
  bool _isAboutExpanded = false;
  late AnimationController _favoriteAnimationController;
  late Animation<double> _favoriteAnimation;

  // Sample doctor data
  late DoctorModel _doctor;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadDoctorData();
  }

  @override
  void dispose() {
    _favoriteAnimationController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _favoriteAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _favoriteAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _favoriteAnimationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  void _loadDoctorData() {
    // Use provided doctor data or create sample data
    _doctor =
        widget.doctor ??
        DoctorModel(
          id: '1',
          name: 'Dr. David Patel',
          specialty: 'Cardiologist',
          location: 'Golden Cardiology Center',
          imageUrl: 'assets/images/profile_avatar.jpg',
          patients: 2000,
          experience: 10,
          rating: 5.0,
          reviews: 1872,
          about:
              'Dr. David Patel, a dedicated cardiologist, brings a wealth of experience to Golden Gate Cardiology Center in Golden Gate, CA. With over 10 years of specialized training and practice, Dr. Patel is committed to providing exceptional cardiovascular care to his patients. He graduated from prestigious medical institutions and has contributed to numerous research publications in cardiology.',
          workingHours: 'Monday-Friday, 08.00 AM-18.00 PM',
          reviewsList: [
            ReviewModel(
              userName: 'Emily Anderson',
              userImage: 'assets/images/profile_avatar.jpg',
              rating: 5.0,
              comment:
                  'Dr. Patel is a true professional who genuinely cares about his patients. I highly recommend Dr. Patel to anyone seeking exceptional cardiac care.',
              date: DateTime.now().subtract(const Duration(days: 5)),
            ),
            ReviewModel(
              userName: 'Michael Johnson',
              userImage: 'assets/images/profile_avatar.jpg',
              rating: 4.8,
              comment:
                  'Excellent doctor with great expertise. Very thorough in his examinations and explains everything clearly.',
              date: DateTime.now().subtract(const Duration(days: 12)),
            ),
          ],
        );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    if (_isFavorite) {
      _favoriteAnimationController.forward().then((_) {
        _favoriteAnimationController.reverse();
      });
    }

    // Here you can add API call to save favorite status
    _showSnackBar(
      _isFavorite ? 'Added to favorites' : 'Removed from favorites',
    );
  }

  void _toggleAboutExpansion() {
    setState(() {
      _isAboutExpanded = !_isAboutExpanded;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  void _navigateToReviews() {
    // Navigate to reviews screen
    Navigator.pushNamed(context, '/reviews', arguments: _doctor.id);
  }

  void _bookAppointment() {
    // Navigate to booking screen
    Navigator.pushNamed(context, '/book-appointment', arguments: _doctor);
  }

  void _startChat() {
    // Navigate to chat screen
    Navigator.pushNamed(context, '/chat', arguments: _doctor);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: Text(
        'Doctor Details',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF404040),
          fontFamily: AppFonts.satoshi,
        ),
      ),
      centerTitle: true,
      trailing: [
        AnimatedBuilder(
          animation: _favoriteAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _favoriteAnimation.value,
              child: IconButton(
                onPressed: _toggleFavorite,
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : const Color(0xFF404040),
                ),
              ),
            );
          },
        ),
      ],
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Doctor Profile Card
                  _buildDoctorProfileCard(),
                  SizedBox(height: 20.h),

                  // Doctor Statistics
                  _buildDoctorStatistics(),
                  SizedBox(height: 20.h),

                  // About Me Section
                  _buildAboutMeSection(),
                  SizedBox(height: 20.h),

                  // Working Time Section
                  _buildWorkingTimeSection(),
                  SizedBox(height: 20.h),

                  // Reviews Section
                  _buildReviewsSection(),
                  SizedBox(height: 100.h), // Space for bottom buttons
                ],
              ),
            ),
          ),

          // Bottom Action Buttons
          _buildBottomActionButtons(),
        ],
      ),
    );
  }

  Widget _buildDoctorProfileCard() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF5F5F5), width: 0.5),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Doctor Image
          Container(
            width: 109.w,
            height: 109.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: const Color(0xFFF5F5F5),
              image: DecorationImage(
                image: AssetImage(_doctor.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Doctor Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _doctor.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0A3128),
                    fontFamily: AppFonts.satoshi,
                  ),
                ),
                SizedBox(height: 8.h),

                // Separator Line
                Container(height: 1, color: const Color(0xFFF5F5F5)),
                SizedBox(height: 8.h),

                Text(
                  _doctor.specialty,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF525252),
                    fontFamily: AppFonts.satoshi,
                  ),
                ),
                SizedBox(height: 8.h),

                // Location Row
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFF525252),
                      size: 20,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        _doctor.location,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF525252),
                          fontFamily: AppFonts.satoshi,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorStatistics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatisticItem(
          icon: Icons.people,
          value: '${_doctor.patients}+',
          label: 'patients',
        ),
        _buildStatisticItem(
          icon: Icons.military_tech,
          value: '${_doctor.experience}+',
          label: 'experience',
        ),
        _buildStatisticItem(
          icon: Icons.star,
          value: _doctor.rating.toString(),
          label: 'rating',
        ),
        _buildStatisticItem(
          icon: Icons.chat_bubble_outline,
          value: '${_doctor.reviews}',
          label: 'reviews',
        ),
      ],
    );
  }

  Widget _buildStatisticItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          padding: EdgeInsets.all(12.w),
          decoration: const BoxDecoration(
            color: Color(0xFFF3F4F6),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF525252), size: 30),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF525252),
            fontFamily: AppFonts.satoshi,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF737373),
            fontFamily: AppFonts.satoshi,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutMeSection() {
    const int previewLength = 150; // Character limit for preview
    final bool shouldShowToggle = _doctor.about.length > previewLength;
    final String displayText =
        _isAboutExpanded
            ? _doctor.about
            : (_doctor.about.length > previewLength
                ? '${_doctor.about.substring(0, previewLength)}...'
                : _doctor.about);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About me',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0A3128),
            fontFamily: AppFonts.satoshi,
          ),
        ),
        SizedBox(height: 8.h),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayText,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF737373),
                  fontFamily: AppFonts.satoshi,
                  height: 1.5,
                ),
              ),
              if (shouldShowToggle) ...[
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: _toggleAboutExpansion,
                  child: Text(
                    _isAboutExpanded ? 'view less' : 'view more',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF111928),
                      fontFamily: AppFonts.satoshi,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Working Time',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0A3128),
            fontFamily: AppFonts.satoshi,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          _doctor.workingHours,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF737373),
            fontFamily: AppFonts.satoshi,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Reviews Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reviews',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0A3128),
                fontFamily: AppFonts.satoshi,
              ),
            ),
            GestureDetector(
              onTap: _navigateToReviews,
              child: Text(
                'See All',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF737373),
                  fontFamily: AppFonts.satoshi,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Reviews List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _doctor.reviewsList.length.clamp(
            0,
            2,
          ), // Show max 2 reviews
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            return _buildReviewCard(_doctor.reviewsList[index]);
          },
        ),
      ],
    );
  }

  Widget _buildReviewCard(ReviewModel review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Reviewer Info
        Row(
          children: [
            Container(
              width: 57.w,
              height: 57.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF5F5F5),
                image: DecorationImage(
                  image: AssetImage(review.userImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.userName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF404040),
                      fontFamily: AppFonts.satoshi,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        review.rating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF737373),
                          fontFamily: AppFonts.satoshi,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      // Star Rating
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < review.rating.floor()
                                ? Icons.star
                                : (index < review.rating
                                    ? Icons.star_half
                                    : Icons.star_border),
                            color: const Color(0xFFFFD33C),
                            size: 12,
                          );
                        }),
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(review.date),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF999999),
                          fontFamily: AppFonts.satoshi,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Review Text
        Text(
          review.comment,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF737373),
            fontFamily: AppFonts.satoshi,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${difference ~/ 7} weeks ago';
    }
  }

  Widget _buildBottomActionButtons() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24.w,
        16.h,
        24.w,
        MediaQuery.of(context).padding.bottom + 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Chat Button
          Expanded(
            flex: 1,
            child: OutlinedButton.icon(
              onPressed: _startChat,
              icon: const Icon(Icons.chat_bubble_outline),
              label: Text(
                'Chat',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.satoshi,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF0A3128),
                side: const BorderSide(color: Color(0xFF0A3128)),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Book Appointment Button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _bookAppointment,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A3128),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Book Appointment',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.satoshi,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
