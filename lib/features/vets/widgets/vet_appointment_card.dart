import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VetAppointmentCard extends StatelessWidget {
  final String dateTime;
  final String doctorName;
  final String specialty;
  final String location;
  final String imageUrl;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;
  final bool showRescheduleButton;

  const VetAppointmentCard({
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

  Color _statusBg() {
    return showRescheduleButton ? const Color(0xFFE8F5E9) : const Color(0xFFE3F2FD);
  }

  Color _statusText() {
    return showRescheduleButton ? const Color(0xFF00A651) : const Color(0xFF1976D2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFECECEC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: date and status
          Row(
            children: [
              Expanded(
                child: Text(
                  dateTime,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF262626),
                    fontFamily: 'Satoshi',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _statusBg(),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  showRescheduleButton ? 'Upcoming' : 'Completed',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: _statusText(),
                    fontFamily: 'Satoshi',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Main row: image + details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image(
                  width: 92.w,
                  height: 92.w,
                  fit: BoxFit.cover,
                  image: imageUrl.startsWith('http')
                      ? NetworkImage(imageUrl) as ImageProvider
                      : AssetImage(imageUrl),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0A3128),
                        fontFamily: 'Satoshi',
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      specialty,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF525252),
                        fontFamily: 'Satoshi',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12.sp,
                          color: const Color(0xFF737373),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF737373),
                              fontFamily: 'Satoshi',
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

          // Actions
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    height: 36.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF525252),
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ),
                ),
              ),
              if (showRescheduleButton) ...[
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: onReschedule,
                    child: Container(
                      height: 36.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF34F4C6),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        'Reschedule',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0A0A0A),
                          fontFamily: 'Satoshi',
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
