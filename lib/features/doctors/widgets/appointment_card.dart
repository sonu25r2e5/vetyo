import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final String status;
  final String? avatarUrl;

  const   AppointmentCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.status,
    this.avatarUrl,
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return const Color(0xFFE8F5E9);
      case 'pending':
        return const Color(0xFFFEF3C6);
      case 'completed':
        return const Color(0xFFE3F2FD);
      default:
        return const Color(0xFFF5F5F5);
    }
  }

  Color _getStatusTextColor() {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return const Color(0xFF00A651);
      case 'pending':
        return const Color(0xFFBB4D00);
      case 'completed':
        return const Color(0xFF1976D2);
      default:
        return const Color(0xFF737373);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF0F0F0),
              image:
                  avatarUrl != null
                      ? DecorationImage(
                        image: NetworkImage(avatarUrl!),
                        fit: BoxFit.cover,
                      )
                      : null,
            ),
            child:
                avatarUrl == null
                    ? Icon(
                      Icons.person,
                      size: 22.sp,
                      color: const Color(0xFF737373),
                    )
                    : null,
          ),
          SizedBox(width: 12.w),
          // Doctor info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF272828),
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  specialty,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF737373),
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 12.sp,
                      color: const Color(0xFF737373),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '$date, $time',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF737373),
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // Status badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: _getStatusColor(),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: _getStatusTextColor(),
                fontFamily: 'Satoshi',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
