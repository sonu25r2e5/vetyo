import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentBookSuccessWidget extends StatelessWidget {
  final String doctorName;
  final String appointmentDate;
  final String appointmentTime;
  final VoidCallback onDone;

  const AppointmentBookSuccessWidget({
    super.key,
    required this.doctorName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(32.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success Icon
          Container(
            width: 131.w,
            height: 131.h,
            decoration: BoxDecoration(
              color: const Color(0xFF56F6CF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 72.w,
                height: 72.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.check,
                  size: 48.w,
                  color: const Color(0xFF56F6CF),
                  weight: 700,
                ),
              ),
            ),
          ),

          SizedBox(height: 32.h),

          // Congratulations Text
          Text(
            'Congratulations!',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0A3128),
              fontFamily: "Satoshi",
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8.h),

          // Appointment Details
          SizedBox(
            width: 252.w,
            child: Text(
              'Your appointment with $doctorName is confirmed for $appointmentDate, at $appointmentTime.',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF737373),
                fontFamily: "Satoshi",
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 32.h),

          // Done Button
          GestureDetector(
            onTap: onDone,
            child: Container(
              width: double.infinity,
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1DC7F2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              alignment: Alignment.center,
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: "Satoshi",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
