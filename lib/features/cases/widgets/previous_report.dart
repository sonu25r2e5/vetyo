import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/features/cases/model/case_report_model.dart';

class PreviousCardReport extends StatelessWidget {
  final CaseReportModel caseReport;
  final VoidCallback? onTap;
  final String? appointmentStatus;
  final String? totalPaid;
  const PreviousCardReport({
    super.key,
    required this.caseReport,
    this.onTap,
    this.appointmentStatus,
    this.totalPaid,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Report Section
          _buildStatusReportSection(),
          SizedBox(height: 16.h),

          // Pet Information Section
          _buildPetInformationSection(),
          SizedBox(height: 16.h),

          // Supporting Evidence Section
          _buildSupportingEvidenceSection(),
          SizedBox(height: 16.h),

          // Doctor's Questionnaire Section
          _buildDoctorsQuestionnaireSection(),
          SizedBox(height: 16.h),

          // Consultation Detail Section
          _buildConsultationDetailSection(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildStatusReportSection() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7F7),
        border: Border.all(color: const Color(0xFFB8ECE0), width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            (caseReport.status.name == 'closed') ? 'Status Report' : 'Active',
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            'Status',
            caseReport.status.name.toUpperCase(),
            icon: _getStatusIcon(),
            iconColor: _getStatusColor(),
            valueFontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PET INFORMATION SECTION
  // ============================================================

  Widget _buildPetInformationSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7F7),
        border: Border.all(color: const Color(0xFFBBFBEC), width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Pet Information'),
          SizedBox(height: 12.h),
          Column(
            children: [
              _buildInfoRow('Category', caseReport.category),
              SizedBox(height: 8.h),
              _buildInfoRow('Specific Patient', caseReport.species),
              SizedBox(height: 8.h),
              _buildInfoRow('Pet Name', caseReport.petName),
              SizedBox(height: 8.h),
              _buildInfoRow('Breed', caseReport.breed),
              SizedBox(height: 8.h),
              _buildInfoRow('Age', _formatAge(caseReport.ageInMonths)),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SUPPORTING EVIDENCE SECTION
  // ============================================================

  Widget _buildSupportingEvidenceSection() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7F7),
        border: Border.all(color: const Color(0xFFBBFBEC), width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Supporting Evidence'),
          SizedBox(height: 12.h),
          _buildEvidenceCarousel(),
        ],
      ),
    );
  }

  Widget _buildEvidenceCarousel() {
    if (caseReport.evidences.isEmpty) {
      return Container(
        padding: EdgeInsets.all(20.h),
        alignment: Alignment.center,
        child: Text(
          'No evidence uploaded',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF737373),
            fontFamily: "Satoshi",
          ),
        ),
      );
    }

    return SizedBox(
      height: 75.h,
      child: Stack(
        children: [
          Row(
            children: [
              ...caseReport.evidences.take(3).map((evidence) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Container(
                    width: 90.w,
                    height: 75.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFBBFBEC),
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: _buildEvidencePreview(evidence),
                    ),
                  ),
                );
              }),
              if (caseReport.evidences.length > 3)
                Container(
                  width: 94.w,
                  height: 75.h,
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBBFBEC),
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: _buildEvidencePreview(caseReport.evidences[3]),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, size: 24.sp, color: Colors.white),
                              Text(
                                '${caseReport.evidences.length - 3}',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEvidencePreview(EvidenceItem evidence) {
    return Container(
      color: const Color(0xFFE0E0E0),
      child: Center(
        child: Icon(
          _getEvidenceIcon(evidence.type),
          size: 32.sp,
          color: const Color(0xFF737373),
        ),
      ),
    );
  }

  IconData _getEvidenceIcon(EvidenceType type) {
    switch (type) {
      case EvidenceType.image:
        return Icons.image;
      case EvidenceType.video:
        return Icons.videocam;
      case EvidenceType.document:
        return Icons.description;
    }
  }

  // ============================================================
  // DOCTOR'S QUESTIONNAIRE SECTION
  // ============================================================

  Widget _buildDoctorsQuestionnaireSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7F7),
        border: Border.all(color: const Color(0xFFB8ECE0), width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 9.h, 12.w, 0),
            child: _buildSectionHeader('Doctor\'s Questionnaire'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
            child: Column(
              children: [
                _buildQuestionRow(
                  'Known Drug Allergies?',
                  caseReport.hasMedicineAllergy,
                ),
                SizedBox(height: 16.h),
                _buildQuestionRow(
                  'Taking Other Meds?',
                  caseReport.isTakingOtherMedication,
                ),
                SizedBox(height: 16.h),
                _buildQuestionRow(
                  'Heart or Organ Issue?',
                  caseReport.hasHeartOrKidneyIssues,
                ),
                SizedBox(height: 16.h),
                _buildQuestionRow(
                  'Prior Vaccine Reaction?',
                  caseReport.hadVaccineReaction,
                ),
                SizedBox(height: 16.h),
                _buildQuestionRow(
                  'Ate Something Toxic?',
                  caseReport.consumedHarmfulSubstance,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionRow(String question, bool answer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          question,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF525252),
            fontFamily: "Satoshi",
          ),
        ),
        Text(
          answer ? 'Yes' : 'No',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontFamily: "Satoshi",
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CONSULTATION DETAIL SECTION
  // ============================================================

  Widget _buildConsultationDetailSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7F7),
        border: Border.all(color: const Color(0xFFB8ECE0), width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8.w, 3.h, 8.w, 0),
            child: _buildSectionHeader('Consultation Detail'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Consultation Type',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF525252),
                    fontFamily: "Satoshi",
                  ),
                ),
                Row(
                  children: [
                    Text(
                      _getPriorityText(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: _getPriorityColor(),
                        fontFamily: "Satoshi",
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Icon(
                      _getPriorityIcon(),
                      size: 14.sp,
                      color: _getPriorityColor(),
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

  // // ============================================================
  // // PAYMENT INFORMATION SECTION
  // // ============================================================

  // Widget _buildPaymentInformationSection() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: const Color(0xFFF0F7F7),
  //       border: Border.all(color: const Color(0xFFB8ECE0), width: 1),
  //       borderRadius: BorderRadius.circular(12.r),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.fromLTRB(9.w, 0, 9.w, 0),
  //           child: _buildSectionHeader('Payment Information'),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
  //           child: Column(
  //             children: [
  //               if (appointmentStatus != null) ...[
  //                 _buildInfoRow(
  //                   'Appointment',
  //                   appointmentStatus!,
  //                   icon: Icons.schedule_rounded,
  //                   iconColor: Colors.black,
  //                   valueFontWeight: FontWeight.w700,
  //                 ),
  //                 SizedBox(height: 19.h),
  //               ],
  //               if (totalPaid != null)
  //                 _buildInfoRow(
  //                   'Total Paid',
  //                   totalPaid!,
  //                   icon: Icons.account_balance_wallet,
  //                   iconColor: Colors.black,
  //                   valueFontWeight: FontWeight.w700,
  //                 ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // ============================================================
  // HELPER WIDGETS
  // ============================================================

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0A3128),
            fontFamily: "Satoshi",
            height: 1.5,
          ),
        ),
        SizedBox(height: 4.h),
        Container(height: 1, color: const Color(0xFFB8ECE0)),
      ],
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    IconData? icon,
    Color? iconColor,
    FontWeight? valueFontWeight,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF737373),
            fontFamily: "Satoshi",
            height: 1.5,
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: valueFontWeight ?? FontWeight.w400,
                color: const Color(0xFF0A3128),
                fontFamily: "Satoshi",
              ),
            ),
            if (icon != null) ...[
              SizedBox(width: 3.w),
              Icon(icon, size: 12.sp, color: iconColor ?? Colors.black),
            ],
          ],
        ),
      ],
    );
  }

  // ============================================================
  // HELPER METHODS
  // ============================================================

  String _formatAge(int ageInMonths) {
    if (ageInMonths < 12) {
      return '$ageInMonths ${ageInMonths == 1 ? "month" : "months"}';
    } else {
      final years = ageInMonths ~/ 12;
      final months = ageInMonths % 12;
      if (months == 0) {
        return '$years ${years == 1 ? "year" : "years"}';
      }
      return '$years ${years == 1 ? "year" : "years"}, $months ${months == 1 ? "month" : "months"}';
    }
  }

  Color _getStatusColor() {
    switch (caseReport.status) {
      case CaseStatus.active:
        return const Color(0xFF10B981);
      case CaseStatus.closed:
        return const Color(0xFF6B7280);
      case CaseStatus.cancelled:
        return const Color(0xFFDC2626);
    }
  }

  IconData _getStatusIcon() {
    switch (caseReport.status) {
      case CaseStatus.active:
        return Icons.check_circle;
      case CaseStatus.closed:
        return Icons.lock;
      case CaseStatus.cancelled:
        return Icons.cancel;
    }
  }

  String _getPriorityText() {
    switch (caseReport.consultationPriority) {
      case ConsultationPriority.emergency:
        return 'High Priority';
      case ConsultationPriority.high:
        return 'High Priority';
      case ConsultationPriority.normal:
        return 'Normal';
    }
  }

  Color _getPriorityColor() {
    switch (caseReport.consultationPriority) {
      case ConsultationPriority.emergency:
        return const Color(0xFFDE1515);
      case ConsultationPriority.high:
        return const Color(0xFFDE1515);
      case ConsultationPriority.normal:
        return const Color(0xFF10B981);
    }
  }

  IconData _getPriorityIcon() {
    switch (caseReport.consultationPriority) {
      case ConsultationPriority.emergency:
        return Icons.local_fire_department;
      case ConsultationPriority.high:
        return Icons.local_fire_department;
      case ConsultationPriority.normal:
        return Icons.info_outline;
    }
  }
}
