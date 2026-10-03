import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CasePictureScreen extends StatefulWidget {
  const CasePictureScreen({super.key});

  @override
  State<CasePictureScreen> createState() => _CasePictureScreenState();
}

class _CasePictureScreenState extends State<CasePictureScreen> {
  // Sample notification images (pet pictures)
  final List<String> notificationImages = [
    'assets/images/profile_avatar.jpg',
    'assets/images/profile_avatar.jpg',
    'assets/images/profile_avatar.jpg',
    'assets/images/profile_avatar.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FDFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 24.w,
                      height: 24.h,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 18.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Notification images list
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                itemCount: notificationImages.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  // Varying heights for visual interest
                  final heights = [308.h, 238.h, 238.h, 246.h];
                  final height = heights[index % heights.length];

                  return GestureDetector(
                    onTap: () {
                      // Handle notification tap
                      _showImageDetail(context, notificationImages[index]);
                    },
                    child: Container(
                      height: height,
                      width: 327.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.grey[300],
                        image: DecorationImage(
                          image: AssetImage(notificationImages[index]),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageDetail(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
    );
  }
}
