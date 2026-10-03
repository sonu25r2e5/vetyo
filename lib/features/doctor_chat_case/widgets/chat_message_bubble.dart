import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatMessageBubble extends StatelessWidget {
  final String message;
  final bool isSentByDoctor; // true if doctor sent, false if user sent
  final String? doctorImageUrl;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isSentByDoctor,
    this.doctorImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isSentByDoctor ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isSentByDoctor && doctorImageUrl != null) ...[
            Container(
              width: 28.754.w,
              height: 28.75.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image:
                      doctorImageUrl!.startsWith('http')
                          ? NetworkImage(doctorImageUrl!) as ImageProvider
                          : AssetImage(doctorImageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 4.w),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 250.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
              decoration: BoxDecoration(
                color: isSentByDoctor ? Colors.white : const Color(0xFF22A487),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color:
                      isSentByDoctor ? const Color(0xFF525252) : Colors.white,
                  fontFamily: "Satoshi",
                  height: 1.5,
                ),
              ),
            ),
          ),
          if (!isSentByDoctor) SizedBox(width: isSentByDoctor ? 0 : 52.w),
        ],
      ),
    );
  }
}
