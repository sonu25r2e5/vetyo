import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentCard extends StatelessWidget {
  final String dateTime;
  final String doctorName;
  final String specialty;
  final String location;
  final String imageUrl;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;
  final bool showRescheduleButton;

  const AppointmentCard({
    super.key,
    required this.dateTime,
    required this.doctorName,
    required this.specialty,
    required this.location,
    required this.imageUrl,
    this.onCancel,
    this.onReschedule,
    this.showRescheduleButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF5F5F5), width: 0.5),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date and time
          Text(
            dateTime,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF262626),
              fontFamily: "Satoshi",
            ),
          ),
          SizedBox(height: 12.h),

          // Divider
          Container(height: 1, color: const Color(0xFFF5F5F5)),
          SizedBox(height: 12.h),

          // Doctor info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor image
              Container(
                width: 109.w,
                height: 109.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: const Color(0xFFF5F5F5),
                  image: DecorationImage(
                    image:
                        imageUrl.startsWith('http')
                            ? NetworkImage(imageUrl) as ImageProvider
                            : AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Doctor details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0A3128),
                        fontFamily: "Satoshi",
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      specialty,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF525252),
                        fontFamily: "Satoshi",
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14.sp,
                          color: const Color(0xFF525252),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF525252),
                              fontFamily: "Satoshi",
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Divider
          Container(height: 1, color: const Color(0xFFF5F5F5)),
          SizedBox(height: 12.h),

          // Action buttons
          Row(
            children: [
              // Cancel button
              Expanded(
                child: GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    height: 34.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.r),
                      color: Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF525252),
                        fontFamily: "Satoshi",
                      ),
                    ),
                  ),
                ),
              ),
              if (showRescheduleButton) ...[
                SizedBox(width: 16.w),
                // Reschedule button
                Expanded(
                  child: GestureDetector(
                    onTap: onReschedule,
                    child: Container(
                      height: 34.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.r),
                        color: const Color(0xFF34F4C6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Reschedule',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0A0A0A),
                          fontFamily: "Satoshi",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
