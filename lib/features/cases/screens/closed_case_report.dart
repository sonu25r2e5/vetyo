import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/features/cases/model/case_report_model.dart';
import 'package:vetyo/features/cases/widgets/case_report_card.dart';

// ============================================================
// MOCK DATA
// ============================================================

// Mock data for a closed case with health concerns
final CaseReportModel mockClosedCaseWithConcerns = CaseReportModel(
  id: 'case-12345-abcdef-67890',
  status: CaseStatus.closed,
  createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
  category: 'Pet',
  species: 'Dog',
  petName: 'Max',
  breed: 'Golden Retriever',
  ageInMonths: 36, // 3 years
  evidences: [
    EvidenceItem(
      id: 'ev1',
      type: EvidenceType.image,
      url: 'https://example.com/image1.jpg',
    ),
    EvidenceItem(
      id: 'ev2',
      type: EvidenceType.image,
      url: 'https://example.com/image2.jpg',
    ),
    EvidenceItem(
      id: 'ev3',
      type: EvidenceType.video,
      url: 'https://example.com/video1.mp4',
    ),
  ],
  hasMedicineAllergy: true,
  isTakingOtherMedication: true,
  hasHeartOrKidneyIssues: false,
  hadVaccineReaction: false,
  consumedHarmfulSubstance: true,
  consultationPriority: ConsultationPriority.high,
);

// ============================================================

class ClosedCaseReport extends StatefulWidget {
  const ClosedCaseReport({super.key});

  @override
  State<ClosedCaseReport> createState() => _ClosedCaseReportState();
}

class _ClosedCaseReportState extends State<ClosedCaseReport> {
  // Previous report section expansion states

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showBackButton: true,
      bodyColor: const Color(0xFFEAE6E6),
      title: Text(
        'Report Case',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontFamily: "Satoshi",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Current Report Section - Using mock data
            CaseReportCard(
              caseReport: mockClosedCaseWithConcerns,
              onTap: () {
                // Navigate to details
              },
              appointmentStatus: 'Scheduled',
              totalPaid: 'Rs.1000',
            ),

            // SizedBox(height: 16.h),

            // // Example with no health concerns
            // ClosedCaseReportCard(
            //   caseReportModel: mockClosedCaseNoConcerns,
            //   onTap: () {
            //     // Navigate to closed case details
            //   },
            // ),

            // SizedBox(height: 16.h),

            // // Example with emergency case
            // ClosedCaseReportCard(
            //   caseReportModel: mockEmergencyClosedCase,
            //   onTap: () {
            //     // Navigate to closed case details
            //   },
            // ),

            // Quick Overview Card (Reusable Widget)
          ],
        ),
      ),
    );
  }
}
