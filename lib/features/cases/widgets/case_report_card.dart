import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/cases/model/case_report_model.dart';

class CaseReportCard extends StatelessWidget {
  final CaseReportModel caseReport;
  final VoidCallback? onTap;
  final String? appointmentStatus;
  final String? totalPaid;

  const CaseReportCard({
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
          Text("Current Report", style: context.textBlackStyle().bold.header5),

          SizedBox(height: 16.h),
          // Status Report Section
          _buildStatusReportSection(context),
          SizedBox(height: 16.h),

          // Pet Information Section
          _buildPetInformationSection(context),
          SizedBox(height: 16.h),

          // Supporting Evidence Section
          _buildSupportingEvidenceSection(context),
          SizedBox(height: 16.h),

          // Doctor's Questionnaire Sectionk
          _buildDoctorsQuestionnaireSection(context),
          SizedBox(height: 16.h),

          // Consultation Detail Section
          _buildConsultationDetailSection(context),
          SizedBox(height: 16.h),

          // Payment Information Section
          if (appointmentStatus != null || totalPaid != null)
            _buildPaymentInformationSection(context),
        ],
      ),
    );
  }

  // ============================================================
  // STATUS REPORT SECTION
  // ============================================================

  Widget _buildStatusReportSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.applyAppColor(
          palette: ColorPalete.clinicCloud,
          swatch: 100,
        ),
        border: Border.all(
          color: context.applyAppColor(
            palette: ColorPalete.healingGreen,
            swatch: 100,
          ),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            context,
            (caseReport.status.name == 'closed') ? 'Status Report' : 'Active',
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            context,
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

  Widget _buildPetInformationSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: context.applyAppColor(
          palette: ColorPalete.clinicCloud,
          swatch: 100,
        ),
        border: Border.all(
          color: context.applyAppColor(
            palette: ColorPalete.healingGreen,
            swatch: 100,
          ),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, 'Pet Information'),
          SizedBox(height: 12.h),
          Column(
            children: [
              _buildInfoRow(context, 'Category', caseReport.category),
              SizedBox(height: 8.h),
              _buildInfoRow(context, 'Specific Patient', caseReport.species),
              SizedBox(height: 8.h),
              _buildInfoRow(context, 'Pet Name', caseReport.petName),
              SizedBox(height: 8.h),
              _buildInfoRow(context, 'Breed', caseReport.breed),
              SizedBox(height: 8.h),
              _buildInfoRow(context, 'Age', _formatAge(caseReport.ageInMonths)),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SUPPORTING EVIDENCE SECTION
  // ============================================================

  Widget _buildSupportingEvidenceSection(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.casesMediaScreen);
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: context.applyAppColor(
            palette: ColorPalete.clinicCloud,
            swatch: 100,
          ),
          border: Border.all(
            color: context.applyAppColor(
              palette: ColorPalete.healingGreen,
              swatch: 100,
            ),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Supporting Evidence'),
            SizedBox(height: 12.h),
            _buildEvidenceCarousel(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEvidenceCarousel(BuildContext context) {
    if (caseReport.evidences.isEmpty) {
      return Container(
        padding: EdgeInsets.all(20.h),
        alignment: Alignment.center,
        child: Text(
          'No evidence uploaded',
          style:
              context
                  .textStyle(palette: ColorPalete.neutral, swatch: 400)
                  .small
                  .regular,
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
                      color: context.applyAppColor(
                        palette: ColorPalete.healingGreen,
                        swatch: 100,
                      ),
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
                      child: _buildEvidencePreview(context, evidence),
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
                    color: context.applyAppColor(
                      palette: ColorPalete.healingGreen,
                      swatch: 100,
                    ),
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
                        child: _buildEvidencePreview(
                          context,
                          caseReport.evidences[3],
                        ),
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
                                style: context.textBlackStyle().copyWith(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w400,
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

  Widget _buildEvidencePreview(BuildContext context, EvidenceItem evidence) {
    return Container(
      color: context.applyAppColor(palette: ColorPalete.neutral, swatch: 200),
      child: Center(
        child: Icon(
          _getEvidenceIcon(evidence.type),
          size: 32.sp,
          color: context.applyAppColor(
            palette: ColorPalete.neutral,
            swatch: 400,
          ),
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

  Widget _buildDoctorsQuestionnaireSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.applyAppColor(
          palette: ColorPalete.clinicCloud,
          swatch: 100,
        ),
        border: Border.all(
          color: context.applyAppColor(
            palette: ColorPalete.healingGreen,
            swatch: 100,
          ),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 9.h, 12.w, 0),
            child: _buildSectionHeader(context, 'Doctor\'s Questionnaire'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
            child: Column(
              children: [
                _buildQuestionRow(
                  context,
                  'Known Drug Allergies?',
                  caseReport.hasMedicineAllergy,
                ),
                SizedBox(height: 16.h),
                _buildQuestionRow(
                  context,
                  'Taking Other Meds?',
                  caseReport.isTakingOtherMedication,
                ),
                SizedBox(height: 16.h),
                _buildQuestionRow(
                  context,
                  'Heart or Organ Issue?',
                  caseReport.hasHeartOrKidneyIssues,
                ),
                SizedBox(height: 16.h),
                _buildQuestionRow(
                  context,
                  'Prior Vaccine Reaction?',
                  caseReport.hadVaccineReaction,
                ),
                SizedBox(height: 16.h),
                _buildQuestionRow(
                  context,
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

  Widget _buildQuestionRow(BuildContext context, String question, bool answer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          question,
          style:
              context
                  .textStyle(palette: ColorPalete.neutral, swatch: 400)
                  .small
                  .regular,
        ),
        Text(
          answer ? 'Yes' : 'No',
          style: context.textBlackStyle().small.semiBold,
        ),
      ],
    );
  }

  // ============================================================
  // CONSULTATION DETAIL SECTION
  // ============================================================

  Widget _buildConsultationDetailSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.applyAppColor(
          palette: ColorPalete.clinicCloud,
          swatch: 100,
        ),
        border: Border.all(
          color: context.applyAppColor(
            palette: ColorPalete.healingGreen,
            swatch: 100,
          ),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8.w, 3.h, 8.w, 0),
            child: _buildSectionHeader(context, 'Consultation Detail'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Consultation Type',
                  style:
                      context
                          .textStyle(palette: ColorPalete.neutral, swatch: 400)
                          .small
                          .regular,
                ),
                Row(
                  children: [
                    Text(
                      _getPriorityText(),
                      style: context.textBlackStyle().small.semiBold.copyWith(
                        color: _getPriorityColor(),
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

  // ============================================================
  // PAYMENT INFORMATION SECTION
  // ============================================================

  Widget _buildPaymentInformationSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.applyAppColor(
          palette: ColorPalete.clinicCloud,
          swatch: 100,
        ),
        border: Border.all(
          color: context.applyAppColor(
            palette: ColorPalete.healingGreen,
            swatch: 100,
          ),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(9.w, 0, 9.w, 0),
            child: _buildSectionHeader(context, 'Payment Information'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Column(
              children: [
                if (appointmentStatus != null) ...[
                  _buildInfoRow(
                    context,
                    'Appointment',
                    appointmentStatus!,
                    icon: Icons.schedule_rounded,
                    iconColor: Colors.black,
                    valueFontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 19.h),
                ],
                if (totalPaid != null)
                  _buildInfoRow(
                    context,
                    'Total Paid',
                    totalPaid!,
                    icon: Icons.account_balance_wallet,
                    iconColor: Colors.black,
                    valueFontWeight: FontWeight.w700,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HELPER WIDGETS
  // ============================================================

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              context
                  .textStyle(palette: ColorPalete.healingGreen, swatch: 950)
                  .header5,
        ),
        SizedBox(height: 4.h),
        Container(
          height: 1,
          color: context.applyAppColor(
            palette: ColorPalete.healingGreen,
            swatch: 100,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
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
          style:
              context
                  .textStyle(palette: ColorPalete.neutral, swatch: 400)
                  .small
                  .regular,
        ),
        Row(
          children: [
            Text(
              value,
              style: context.textBlackStyle().small.copyWith(
                fontWeight: valueFontWeight ?? FontWeight.w400,
                color: context.applyAppColor(
                  palette: ColorPalete.healingGreen,
                  swatch: 950,
                ),
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
        return ColorPalete.green[400] ?? const Color(0xFF10B981);
      case CaseStatus.closed:
        return ColorPalete.slate[500] ?? const Color(0xFF6B7280);
      case CaseStatus.cancelled:
        return ColorPalete.error[500] ?? const Color(0xFFDC2626);
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
        return ColorPalete.error[500] ?? const Color(0xFFDE1515);
      case ConsultationPriority.high:
        return ColorPalete.error[500] ?? const Color(0xFFDE1515);
      case ConsultationPriority.normal:
        return ColorPalete.green[400] ?? const Color(0xFF10B981);
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
