import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../model/case_report_model.dart';

class CaseReportDetailCard extends StatelessWidget {
  final CaseReportModel caseReport;
  final VoidCallback? onTap;
  final bool showEvidence;
  final bool showQuestionnaire;

  const CaseReportDetailCard({
    super.key,
    required this.caseReport,
    this.onTap,
    this.showEvidence = true,
    this.showQuestionnaire = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F7F7),
          border: Border.all(color: _getPriorityBorderColor(), width: 2),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: _getPriorityBorderColor().withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Case ID and Status
            _buildHeader(),
            SizedBox(height: 16.h),

            // Pet Information
            _buildSectionTitle('Pet Information'),
            SizedBox(height: 8.h),
            _buildPetInfo(),
            SizedBox(height: 16.h),

            // Consultation Priority
            _buildSectionTitle('Consultation Priority'),
            SizedBox(height: 8.h),
            _buildPriorityBadge(),

            if (showQuestionnaire) ...[
              SizedBox(height: 16.h),
              _buildSectionTitle('Medical Questionnaire'),
              SizedBox(height: 8.h),
              _buildQuestionnaire(),
            ],

            if (showEvidence && caseReport.evidences.isNotEmpty) ...[
              SizedBox(height: 16.h),
              _buildSectionTitle('Evidence (${caseReport.evidences.length})'),
              SizedBox(height: 8.h),
              _buildEvidenceGrid(),
            ],

            SizedBox(height: 12.h),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Case #${caseReport.id.substring(0, 8)}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0A3128),
                  fontFamily: "Satoshi",
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                DateFormat(
                  'MMM dd, yyyy • hh:mm a',
                ).format(caseReport.createdAt),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF737373),
                  fontFamily: "Satoshi",
                ),
              ),
            ],
          ),
        ),
        _buildStatusBadge(),
      ],
    );
  }

  Widget _buildStatusBadge() {
    final statusInfo = _getStatusInfo();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: statusInfo['color'].withOpacity(0.15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: statusInfo['color'], width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusInfo['icon'], size: 14.sp, color: statusInfo['color']),
          SizedBox(width: 4.w),
          Text(
            statusInfo['text'],
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: statusInfo['color'],
              fontFamily: "Satoshi",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
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
        Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFB8ECE0),
                const Color(0xFFB8ECE0).withOpacity(0.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPetInfo() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          _buildInfoRow('Pet Name', caseReport.petName, Icons.pets),
          _buildDivider(),
          _buildInfoRow('Category', caseReport.category, Icons.category),
          _buildDivider(),
          _buildInfoRow('Species', caseReport.species, Icons.science),
          _buildDivider(),
          _buildInfoRow('Breed', caseReport.breed, Icons.info_outline),
          _buildDivider(),
          _buildInfoRow('Age', _formatAge(caseReport.ageInMonths), Icons.cake),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: const Color(0xFF10B981)),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF737373),
                fontFamily: "Satoshi",
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0A3128),
                fontFamily: "Satoshi",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Container(height: 1, color: const Color(0xFFF0F0F0)),
    );
  }

  Widget _buildPriorityBadge() {
    final priorityInfo = _getPriorityInfo();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            priorityInfo['color'].withOpacity(0.2),
            priorityInfo['color'].withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: priorityInfo['color'], width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(priorityInfo['icon'], size: 20.sp, color: priorityInfo['color']),
          SizedBox(width: 8.w),
          Text(
            priorityInfo['text'],
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: priorityInfo['color'],
              fontFamily: "Satoshi",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionnaire() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          _buildQuestionRow('Medicine Allergy', caseReport.hasMedicineAllergy),
          _buildDivider(),
          _buildQuestionRow(
            'Taking Other Medication',
            caseReport.isTakingOtherMedication,
          ),
          _buildDivider(),
          _buildQuestionRow(
            'Heart/Kidney Issues',
            caseReport.hasHeartOrKidneyIssues,
          ),
          _buildDivider(),
          _buildQuestionRow(
            'Vaccine Reaction History',
            caseReport.hadVaccineReaction,
          ),
          _buildDivider(),
          _buildQuestionRow(
            'Consumed Harmful Substance',
            caseReport.consumedHarmfulSubstance,
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionRow(String question, bool answer) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              question,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF525252),
                fontFamily: "Satoshi",
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color:
                  answer
                      ? const Color(0xFFFF6B6B).withOpacity(0.15)
                      : const Color(0xFF10B981).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  answer ? Icons.check_circle : Icons.cancel,
                  size: 14.sp,
                  color:
                      answer
                          ? const Color(0xFFFF6B6B)
                          : const Color(0xFF10B981),
                ),
                SizedBox(width: 4.w),
                Text(
                  answer ? 'Yes' : 'No',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        answer
                            ? const Color(0xFFFF6B6B)
                            : const Color(0xFF10B981),
                    fontFamily: "Satoshi",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvidenceGrid() {
    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: caseReport.evidences.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final evidence = caseReport.evidences[index];
          return _buildEvidenceItem(evidence);
        },
      ),
    );
  }

  Widget _buildEvidenceItem(EvidenceItem evidence) {
    final typeInfo = _getEvidenceTypeInfo(evidence.type);
    return Container(
      width: 80.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(typeInfo['icon'], size: 32.sp, color: typeInfo['color']),
          SizedBox(height: 4.h),
          Text(
            typeInfo['label'],
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF737373),
              fontFamily: "Satoshi",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 14.sp,
              color: const Color(0xFF737373),
            ),
            SizedBox(width: 4.w),
            Text(
              _getTimeAgo(),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF737373),
                fontFamily: "Satoshi",
              ),
            ),
          ],
        ),
        if (onTap != null)
          Icon(
            Icons.arrow_forward_ios,
            size: 14.sp,
            color: const Color(0xFF10B981),
          ),
      ],
    );
  }

  // Helper Methods
  Color _getPriorityBorderColor() {
    switch (caseReport.consultationPriority) {
      case ConsultationPriority.emergency:
        return const Color(0xFFDC2626);
      case ConsultationPriority.high:
        return const Color(0xFFF59E0B);
      case ConsultationPriority.normal:
        return const Color(0xFF10B981);
    }
  }

  Map<String, dynamic> _getStatusInfo() {
    switch (caseReport.status) {
      case CaseStatus.active:
        return {
          'text': 'Active',
          'color': const Color(0xFF10B981),
          'icon': Icons.check_circle,
        };
      case CaseStatus.closed:
        return {
          'text': 'Closed',
          'color': const Color(0xFF6B7280),
          'icon': Icons.lock,
        };
      case CaseStatus.cancelled:
        return {
          'text': 'Cancelled',
          'color': const Color(0xFFDC2626),
          'icon': Icons.cancel,
        };
    }
  }

  Map<String, dynamic> _getPriorityInfo() {
    switch (caseReport.consultationPriority) {
      case ConsultationPriority.emergency:
        return {
          'text': 'EMERGENCY',
          'color': const Color(0xFFDC2626),
          'icon': Icons.warning,
        };
      case ConsultationPriority.high:
        return {
          'text': 'HIGH PRIORITY',
          'color': const Color(0xFFF59E0B),
          'icon': Icons.priority_high,
        };
      case ConsultationPriority.normal:
        return {
          'text': 'Normal Priority',
          'color': const Color(0xFF10B981),
          'icon': Icons.info_outline,
        };
    }
  }

  Map<String, dynamic> _getEvidenceTypeInfo(EvidenceType type) {
    switch (type) {
      case EvidenceType.image:
        return {
          'label': 'Image',
          'icon': Icons.image,
          'color': const Color(0xFF10B981),
        };
      case EvidenceType.video:
        return {
          'label': 'Video',
          'icon': Icons.videocam,
          'color': const Color(0xFF3B82F6),
        };
      case EvidenceType.document:
        return {
          'label': 'Document',
          'icon': Icons.description,
          'color': const Color(0xFFF59E0B),
        };
    }
  }

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

  String _getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(caseReport.createdAt);

    if (difference.inDays > 30) {
      return DateFormat('MMM dd, yyyy').format(caseReport.createdAt);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? "day" : "days"} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? "hour" : "hours"} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? "minute" : "minutes"} ago';
    } else {
      return 'Just now';
    }
  }
}
