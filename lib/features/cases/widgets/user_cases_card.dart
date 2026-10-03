import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class UserCaseCard extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final String date;
  final String status; // 'Active', 'Pending', 'Closed'
  final String imageUrl;
  final VoidCallback onViewCase;
  final VoidCallback? onFollowUp;
  final VoidCallback? onChat;
  final VoidCallback? onReport;

  // Pet details
  final String petName;
  final String petBreed;
  final int? petAge;
  final String? petGender;
  final String? petImageUrl;
  final String messagePreview; // e.g., "You sent a photo..."

  const UserCaseCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.status,
    required this.imageUrl,
    required this.onChat,
    required this.onViewCase,
    this.onFollowUp,
    this.onReport,
    required this.petName,
    required this.petBreed,
    this.petAge,
    this.petGender,
    this.petImageUrl,
    this.messagePreview = "You sent a photo...",
  });

  @override
  State<UserCaseCard> createState() => _UserCaseCardState();
}

class _UserCaseCardState extends State<UserCaseCard> {
  bool _isPetDetailsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top section: Case details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor info row
                GestureDetector(
                  onTap: widget.onChat,
                  // onLongPress: showMoreOptions,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor Avatar
                      Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          image: DecorationImage(
                            image:
                                widget.imageUrl.startsWith('http')
                                    ? NetworkImage(widget.imageUrl)
                                        as ImageProvider
                                    : AssetImage(widget.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Case details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Doctor name and specialty
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Doctor name
                                Text(
                                  widget.doctorName,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0F172B),
                                    fontFamily: 'Satoshi',
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                // Specialty badge
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD2F5FF),
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                  child: Text(
                                    widget.specialty,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF18ABD4),
                                      fontFamily: 'Satoshi',
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                // Status badge
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFCED8DB),
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                  child: Text(
                                    widget.status.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF083340),
                                      fontFamily: 'Satoshi',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            // Message and date info
                            Row(
                              children: [
                                Text(
                                  widget.messagePreview,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF335D6B),
                                    fontFamily: 'Satoshi',
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  widget.date,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF020C0F),
                                    fontFamily: 'Satoshi',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTertiaryButton(
                        label: 'Follow up',
                        onPressed: widget.onFollowUp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomButton(
                        label: 'Report',
                        height: 45.h,
                        onPressed: widget.onViewCase,
                        color: Color(0xFF1DCDFE),
                        labelStyle: context
                            .textBlackStyle()
                            .medium
                            .withSatoshi
                            .copyWith(color: Color(0xFFD2F5FF)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Divider
          // Bottom section: Pet details (expandable)
          GestureDetector(
            onTap: () {
              setState(() {
                _isPetDetailsExpanded = !_isPetDetailsExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expand/Collapse button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _isPetDetailsExpanded
                          ? Icon(
                            Icons.keyboard_arrow_up_sharp,
                            size: 24.sp,
                            color: const Color(0xFF0F172B),
                          )
                          : Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 24.sp,
                            color: const Color(0xFF0F172B),
                          ),
                    ],
                  ),
                  if (_isPetDetailsExpanded) ...[
                    SizedBox(height: 8.h),
                    // Pet details
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pet Avatar
                        Container(
                          width: 34.w,
                          height: 34.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            image: DecorationImage(
                              image:
                                  (widget.petImageUrl ?? '').startsWith('http')
                                      ? NetworkImage(widget.petImageUrl!)
                                          as ImageProvider
                                      : AssetImage(widget.petImageUrl ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Pet info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Pet name
                              Text(
                                widget.petName,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF083340),
                                  fontFamily: 'Satoshi',
                                ),
                              ),
                              SizedBox(height: 1.h),
                              // Pet breed, age, gender
                              Text(
                                _buildPetDetailsText(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF335D6B),
                                  fontFamily: 'Satoshi',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                  ],

                  Container(height: 1.h, color: const Color(0xFFE5E7EB)),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildPetDetailsText() {
    List<String> parts = [widget.petBreed];
    if (widget.petAge != null) {
      parts.add('${widget.petAge} yrs');
    }
    if (widget.petGender != null) {
      parts.add(widget.petGender!);
    }
    return parts.join('     ');
  }
}
