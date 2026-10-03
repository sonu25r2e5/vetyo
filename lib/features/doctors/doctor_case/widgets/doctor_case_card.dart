import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorCaseCard extends StatelessWidget {
  final String patientName;
  final String userType;
  final String date;
  final String status; // 'Active', 'Pending', 'Closed'
  final String imageUrl;
  final VoidCallback onViewCase;
  final VoidCallback? onFollowUp;

  const DoctorCaseCard({
    super.key,
    required this.patientName,
    required this.userType,
    required this.date,
    required this.status,
    required this.imageUrl,
    required this.onViewCase,
    this.onFollowUp,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _getStatusColor(status);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color.fromARGB(30, 210, 245, 255),
        border: Border.all(color: const Color(0xFFB4EEFF), width: 1.w),
        borderRadius: BorderRadius.circular(12.r),
      ),
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
                    imageUrl.startsWith('http')
                        ? NetworkImage(imageUrl) as ImageProvider
                        : AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.w),

          // Content column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Doctor name + Specialty + Status badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Doctor name
                    Text(
                      patientName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172B),
                        fontFamily: 'Satoshi',
                      ),
                    ),
                    SizedBox(width: 12.w),

                    // Specialty badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: const [0.18371, 0.80506],
                          colors: [
                            const Color(0xFF34F5C6).withOpacity(0.2),
                            const Color(0xFF1DCDFE).withOpacity(0.2),
                          ],
                        ),
                        border: Border.all(
                          color: const Color(0xFF68DEFE),
                          width: 0.25.w,
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        userType,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1D293D),
                          fontFamily: 'Satoshi',
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Status badge (right-aligned)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            status,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: statusColor,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                // Date info
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1D293D),
                    fontFamily: 'Satoshi',
                  ),
                ),

                SizedBox(height: 8.h),
                Row(
                  children: [
                    _SolidButton(
                      label: 'View Case',
                      onTap: onViewCase,
                      backgroundColor:
                          (status.toLowerCase() == 'closed')
                              ? Colors.white
                              : Color(0xFF8EE6FE),
                      borderColor: Color(0xFF8EE6FE),
                      textColor: Color(0xFF0F172B),
                    ),

                    // _buildActionButton(label: 'View Case', onTap: onViewCase),
                    SizedBox(width: 12.w),

                    if (onFollowUp != null) ...[
                      _SolidButton(
                        label: 'Follow Up',
                        onTap: onFollowUp!,
                        backgroundColor: Color(0xFF8EE6FE),
                        borderColor: Color(0xFF8EE6FE),
                        textColor: Color(0xFF0F172B),
                      ),
                    ],
                  ],
                ),

                // Action button
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return const Color(0xFF004F3B);
      case 'pending':
        return const Color(0xFFE17100);
      case 'closed':
        return const Color(0xFFC10007);
      default:
        return const Color(0xFF004F3B);
    }
  }
}

class _SolidButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color? textColor;
  final Color borderColor;
  // final double? width;

  const _SolidButton({
    required this.label,
    required this.onTap,
    // required this.width,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20.r),
          // border: Border.all(color: borderColor, width: 0.5.w),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: textColor ?? Color(0xFF0F172B),
              fontFamily: 'Satoshi',
            ),
          ),
        ),
      ),
    );
  }
}
