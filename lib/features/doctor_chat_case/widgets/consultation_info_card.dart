import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsultationInfoCard extends StatelessWidget {
  final String patientType;
  final String breed;
  final String age;
  final String priorityLevel;

  const ConsultationInfoCard({
    super.key,
    required this.patientType,
    required this.breed,
    required this.age,
    required this.priorityLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 47.w, bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 36.h),
      decoration: BoxDecoration(
        color: const Color(0xFFD6FDF4),
        border: Border.all(color: const Color(0xFF21ABA5), width: 0.5),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Consultation Status
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Satoshi",
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: 'Consultation Status: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF404040),
                  ),
                ),
                TextSpan(
                  text: 'Active',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1A7A63),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Pet Details
          Text(
            'Pet Details',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF404040),
              fontFamily: "Satoshi",
              height: 1.5,
            ),
          ),
          SizedBox(height: 4.h),
          _buildDetailRow('Patient', patientType),
          _buildDetailRow('Breed', breed),
          _buildDetailRow('Age', age),
          SizedBox(height: 16.h),

          // Basic Questionnaire
          Text(
            'Basic questionnarie\'s',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF404040),
              fontFamily: "Satoshi",
              height: 1.5,
            ),
          ),
          SizedBox(height: 4.h),
          _buildQuestionnaireText('Known drug allergies'),
          _buildQuestionnaireText('Ingested something toxic'),
          _buildQuestionnaireText('No', ' current medications'),
          _buildQuestionnaireText('No', ' heart or organ conditions'),
          _buildQuestionnaireText('No', ' past vaccine reactions'),
          SizedBox(height: 16.h),

          // Priority Level
          Text(
            'Priority Level',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF404040),
              fontFamily: "Satoshi",
              height: 1.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            priorityLevel,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF404040),
              fontFamily: "Satoshi",
              height: 1.5,
            ),
          ),
          SizedBox(height: 16.h),

          // Appointment
          Text(
            'Appointment',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF404040),
              fontFamily: "Satoshi",
              height: 1.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Consultation will begin after\npayment',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF404040),
              fontFamily: "Satoshi",
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "Satoshi",
          height: 1.5,
          color: const Color(0xFF404040),
        ),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionnaireText(String text, [String? suffix]) {
    if (suffix != null) {
      return RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "Satoshi",
            height: 1.5,
            color: const Color(0xFF404040),
          ),
          children: [
            TextSpan(
              text: text,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            TextSpan(text: suffix),
          ],
        ),
      );
    }
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF404040),
        fontFamily: "Satoshi",
        height: 1.5,
      ),
    );
  }
}
